package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class ReleaseNotesBuilder extends AbstractBuilder {

    private static final String DOCUMENT_ATTRIBUTES_URL = "https://raw.githubusercontent.com/keycloak/keycloak/main/docs/documentation/topics/templates/document-attributes.adoc";

    private static final String RELEASE_NOTES_URL = "https://raw.githubusercontent.com/keycloak/keycloak/release/%s/docs/documentation/release_notes/topics/%s.adoc";

    @Override
    protected String getTitle() {
        return "Release Notes";
    }

    public void build() throws IOException {
        Map<String, Object> attributes = new HashMap<>();

        attributes.put("project_buildType", "latest");
        attributes.put("leveloffset", "2");
        attributes.put("fragment", "yes");

        attributes = context.asciiDoctor().parseAttributes(new URL(DOCUMENT_ATTRIBUTES_URL), attributes);

        File releasesCache = new File(context.getCacheDir(), "releases");

        for (Versions.Version v : context.versions()) {
            try {
                File releaseCacheDir = new File(releasesCache, v.getVersion());
                releaseCacheDir.mkdirs();

                File releaseNotesFile = new File(releaseCacheDir, "release-notes.html");
                File releaseNotesMissingFile = new File(releaseCacheDir, "release-notes.empty");

                if (releaseNotesFile.isFile()) {
                    printStep("exists", v.getVersion());
                } else if (releaseNotesMissingFile.isFile()) {
                    printStep("missing",  v.getVersion());
                } else {
                    String releaseNotesUrl = String.format(RELEASE_NOTES_URL, v.getVersionShorter(), v.getVersion().replace(".", "_"));
                    URL url = new URL(releaseNotesUrl);

                    try {
                        context.asciiDoctor().writeFile(attributes, url, releaseNotesFile.getParentFile(), releaseNotesFile.getName());
                        printStep("created", v.getVersion());
                    } catch (FileNotFoundException e) {
                        printStep("notfound",  v.getVersion());
                        releaseNotesMissingFile.createNewFile();
                    }
                }

                if (releaseNotesFile.isFile()) {
                    v.setReleaseNotes("cache/releases/" + v.getVersion() + "/release-notes.html");
                }
            } catch (Exception e) {
                printStep("error", v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

}
