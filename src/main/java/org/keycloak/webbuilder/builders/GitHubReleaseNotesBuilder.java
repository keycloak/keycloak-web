package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.ReleasesMetadata;
import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GitHubReleaseNotesBuilder extends AbstractBuilder {

    @Override
    protected String getTitle() {
        return "GitHub Release Notes";
    }

    public void build() throws Exception {
        ReleasesMetadata metadata = context.getReleasesMetadata();

        for (ReleasesMetadata.ReleaseSource source : metadata.getSources()) {
            buildForSource(source);
        }
    }

    private void buildForSource(ReleasesMetadata.ReleaseSource source) throws Exception {
        File releasesCache = new File(context.getCacheDir(), "releases/" + source.getId());
        List<Versions.Version> versions = context.versionsFor(source.getId());

        for (Versions.Version v : versions) {
            String releaseNotesFrom = source.getGithubReleaseNotesFrom();

            if (releaseNotesFrom == null || v.compareTo(releaseNotesFrom) <= 0) {
                File releaseCacheDir = new File(releasesCache, v.getVersion());
                releaseCacheDir.mkdirs();

                File ghReleaseNotes = new File(releaseCacheDir, "gh-release-notes.html");

                if (!ghReleaseNotes.isFile()) {
                    Map<String, Object> attributes = new HashMap<>();
                    attributes.put("version", v);
                    attributes.put("source", source);

                    try {
                        context.freeMarker().writeFile(attributes, "templates/gh-release-3.ftl", ghReleaseNotes.getParentFile(), ghReleaseNotes.getName());
                        printStep("created", source.getId() + " " + v.getVersion());
                    } catch (Exception e) {
                        printStep("failed", source.getId() + " " + e.getMessage());
                    }
                }
            }
        }
    }

}
