package org.keycloak.webbuilder.builders;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.keycloak.webbuilder.ReleasesMetadata;
import org.keycloak.webbuilder.Versions;
import org.keycloak.webbuilder.misc.ChangeLogEntry;
import org.keycloak.webbuilder.utils.GitHubApi;
import org.keycloak.webbuilder.utils.JsonParser;
import org.kohsuke.github.GHIssue;

import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class ChangelogBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        ReleasesMetadata metadata = context.getReleasesMetadata();

        for (ReleasesMetadata.ReleaseSource source : metadata.getSources()) {
            buildForSource(source);
        }
    }

    private void buildForSource(ReleasesMetadata.ReleaseSource source) throws Exception {
        try (var ghApi = GitHubApi.getInstance()) {
            var gh = ghApi.get();
            if (gh == null) {
                return;
            }

            File releasesCache = new File(context.getCacheDir(), "releases/" + source.getId());
            Versions versions = context.versionsFor(source.getId());

            for (Versions.Version v : versions) {
                File releaseCacheDir = new File(releasesCache, v.getVersion());
                releaseCacheDir.mkdirs();

                File changeLogFile = new File(releaseCacheDir, "changelog.json");

                if (changeLogFile.exists()) {
                    Versions.ChangeLog changeLog = new Versions.ChangeLog(Arrays.asList(JsonParser.read(changeLogFile, ChangeLogEntry[].class)));

                    if (v.getBlogTemplate() >= 3) {
                        for (ChangeLogEntry e : changeLog.getAll()) {
                            if (!e.getRepository().equals(ReleasesMetadata.MAIN_PROJECT_ID)) {
                                String area = e.getRepository().replaceAll("keycloak-", "");
                                e.setArea(area);
                            }
                        }
                    }

                    v.setChanges(changeLog);
                    printStep("exists", source.getId() + " " + v.getVersion());
                } else {
                    if (v.getBlogTemplate() >= 2) {
                        Map<Integer, GHIssue> ghIssues = new HashMap<>();
                        List<String> queries = new LinkedList<>();

                        if (source.isMainProject()) {
                            // Query all Keycloak projects only for the main project.
                            queries.add("org:keycloak");

                            // For the main project query all repositories except the ones explicitly listed as separately versioned.
                            List<String> ignoredRepos = context.getReleasesMetadata().getSources()
                                    .stream()
                                    .filter(s -> !s.isMainProject())
                                    .map(s -> "-repo:" + s.getRepo())
                                    .collect(Collectors.toList());

                            queries.addAll(ignoredRepos);
                        } else {
                            // Only query the currently active repo if we're not targeting the main project.
                            // The main project is the only one that can pull in release notes from other repos.
                            queries.add("repo:" + source.getRepo());
                        }

                        queries.add("is:issue");

                        String baseQuery = String.join(" ", queries);

                        gh.searchIssues().q(baseQuery + " milestone:" + v.getVersion()).list().forEach(i -> ghIssues.put(i.getNumber(), i));
                        gh.searchIssues().q(baseQuery + " label:release/" + v.getVersion()).list().forEach(i -> ghIssues.put(i.getNumber(), i));

                        List<ChangeLogEntry> changes = new LinkedList<>();
                        // precompute list of versions that have been published before this version
                        Set<String> previousVersions = versions.stream()
                                .filter(version -> version.compareTo(v) < 0 && version.getDate().compareTo(v.getDate()) < 0)
                                .map(Versions.Version::getVersion)
                                .collect(Collectors.toSet());
                        for (GHIssue issue : ghIssues.values()) {
                            ChangeLogEntry change = new ChangeLogEntry();
                            change.setNumber(issue.getNumber());
                            change.setRepository(getRepositoryName(issue));
                            change.setTitle(issue.getTitle());
                            change.setUrl(issue.getHtmlUrl().toString());

                            issue.getLabels().stream()
                                    .map(l -> l.getName())
                                    .filter(s -> s.startsWith("kind/"))
                                    .map(s -> s.substring(5))
                                    .findFirst().ifPresent(s -> change.setKind(s));

                            issue.getLabels().stream()
                                    .map(l -> l.getName())
                                    .filter(s -> s.startsWith("area/"))
                                    .map(s -> s.substring(5))
                                    .findFirst().ifPresent(s -> change.setArea(s));

                            if (v.getVersion().endsWith(".0")) {
                                // For a minor release, don't show items already backported to published patch releases in a previous version
                                if (issue.getLabels().stream()
                                    .filter(ghLabel -> ghLabel.getName().startsWith("release/"))
                                    .anyMatch(ghLabel -> previousVersions.contains(ghLabel.getName().substring("release/".length())))) {
                                    continue;
                                }
                            }

                            if (change.getKind() != null) {
                                changes.add(change);
                            }
                        }

                        changes.sort(Comparator.comparingInt(ChangeLogEntry::getNumber));

                        Versions.ChangeLog changeLog = new Versions.ChangeLog(changes);
                        v.setChanges(changeLog);

                        new ObjectMapper().writerWithDefaultPrettyPrinter().writeValue(changeLogFile, changes);

                        printStep("loaded", source.getId() + " " + v.getVersion());
                    }
                }
            }
        }
    }

    /**
     * Retrieve the repository name from the issue.
     * This avoids `issue.getRepository().getName()` as it would issue a GitHub API call for each issue.
     */
    private static String getRepositoryName(GHIssue issue) {
        String result = issue.getHtmlUrl().toString();
        result = result.substring("https://github.com/".length());
        return result.split("/")[1]; // 0 = org, 1 = repo
    }

    @Override
    protected String getTitle() {
        return "Changelog";
    }

}
