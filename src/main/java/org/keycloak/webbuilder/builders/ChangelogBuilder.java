package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;
import org.keycloak.webbuilder.misc.ChangeLogEntry;
import org.kohsuke.github.GHIssue;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.kohsuke.github.HttpConnector;
import org.kohsuke.github.extras.HttpClientGitHubConnector;
import org.kohsuke.github.extras.ImpatientHttpConnector;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

public class ChangelogBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        String token = getGitHubToken();
        if (token == null) {
            printStep("error", "Failed to get token for GitHub APIs");
            return;
        }

        final List<HttpURLConnection> connections = new LinkedList<>();

        GitHub gh = new GitHubBuilder()
                .withConnector(new ImpatientHttpConnector(url -> {
                    HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
                    connections.add(httpURLConnection);
                    return httpURLConnection;
                }))
                .withOAuthToken(token).build();

        for (Versions.Version v : context.versions()) {
            if (Integer.parseInt(v.getBlogTemplate()) >= 2) {
                List<GHIssue> ghIssues = gh.searchIssues().q("user:keycloak milestone:" + v.getVersion() + " is:closed is:issue").isClosed().list().toList();

                List<ChangeLogEntry> changes = new LinkedList<>();

                for(GHIssue issue : ghIssues) {
                    ChangeLogEntry change = new ChangeLogEntry();
                    change.setNumber(issue.getNumber());
                    change.setRepository(issue.getRepository().getName());
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

                    if (change.getKind() != null) {
                        changes.add(change);
                    }
                }

                changes.sort(Comparator.comparingInt(ChangeLogEntry::getNumber));
                v.setChanges(new Versions.ChangeLog(changes));

                printStep("loaded", v.getVersion());
            }
        }

        for (HttpURLConnection c : connections) {
            c.disconnect();
        }
    }


    private String getGitHubToken() {
        String token = System.getenv("GITHUB_TOKEN");
        if (token != null) {
            printStep("token", "Using token from GITHUB_TOKEN environment variable");
            return token;
        }

        try {
            Process process = Runtime.getRuntime().exec("gh auth status -t");
            BufferedReader ir = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            for (String l = ir.readLine(); l != null; l = ir.readLine()) {
                if (l.contains("Token:")) {
                    printStep("token", "Using token from GitHub command line");
                    return l.split(": ")[1];
                }
            }
            process.destroy();
        } catch (Exception e) {
        }

        return null;
    }

    @Override
    protected String getTitle() {
        return "Changelog";
    }

}
