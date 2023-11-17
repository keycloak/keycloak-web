package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class GitHubReleaseNotesBuilder extends AbstractBuilder {

    private String ghReleaseFrom = "23.0.0";

    @Override
    protected String getTitle() {
        return "GitHub Release Notes";
    }

    public void build() throws IOException {
        File releasesCache = new File(context.getCacheDir(), "releases");

        for (Versions.Version v : context.versions()) {
            if (v.compareTo(ghReleaseFrom) <= 0) {
                File releaseCacheDir = new File(releasesCache, v.getVersion());
                releaseCacheDir.mkdirs();

                File ghReleaseNotes = new File(releaseCacheDir, "gh-release-notes.html");

                if (!ghReleaseNotes.isFile()) {
                    Map<String, Object> attributes = new HashMap<>();
                    attributes.put("version", v);

                    try {
                        context.freeMarker().writeFile(attributes, "templates/gh-release-3.ftl", ghReleaseNotes.getParentFile(), ghReleaseNotes.getName());
                        printStep("created", v.getVersion());
                    } catch (Exception e) {
                        printStep("failed", e.getMessage());
                    }
                }
            }
        }
    }

}
