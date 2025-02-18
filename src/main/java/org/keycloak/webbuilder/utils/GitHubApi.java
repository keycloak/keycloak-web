package org.keycloak.webbuilder.utils;

import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.kohsuke.github.extras.ImpatientHttpConnector;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static org.keycloak.webbuilder.builders.AbstractBuilder.printBuilderStep;

public class GitHubApi implements AutoCloseable {
    private static GitHubApi SINGLETON;
    final List<HttpURLConnection> connections = new LinkedList<>();
    String token;

    private GitHubApi() {
    }

    public static GitHubApi getInstance() {
        if (SINGLETON == null) {
            SINGLETON = new GitHubApi();
        }
        return SINGLETON;
    }

    public GitHub get() {
        String token = getGitHubToken();
        if (token == null) {
            printBuilderStep("error", "Failed to get token for GitHub APIs");
            return null;
        }

        try {
            return new GitHubBuilder()
                    .withConnector(new ImpatientHttpConnector(url -> {
                        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
                        connections.add(httpURLConnection);
                        return httpURLConnection;
                    }))
                    .withOAuthToken(getGitHubToken()).build();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String getGitHubToken() {
        if (token == null) {
            String tokenEnvVar = System.getenv("GITHUB_TOKEN");
            if (tokenEnvVar != null) {
                printBuilderStep("token", "Using token from GITHUB_TOKEN environment variable");
                this.token = tokenEnvVar;
                return token;
            }

            try {
                Process process = Runtime.getRuntime().exec("gh auth token");
                process.waitFor(60, TimeUnit.SECONDS);
                try (BufferedReader ir = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                    this.token = ir.readLine();
                }
                process.destroy();
            } catch (Exception e) {
            }
        }

        return token;
    }

    @Override
    public void close() {
        for (HttpURLConnection c : connections) {
            c.disconnect();
        }
    }
}
