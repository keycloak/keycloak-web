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

        context.getTmpDir().mkdirs();

        for (Versions.Version v : context.versions()) {
            try {
                String releaseNotesUrl = String.format(RELEASE_NOTES_URL, v.getVersionShorter(), v.getVersion().replace(".", "_"));
                URL url = new URL(releaseNotesUrl);

                String fileName = "release-notes-" + v.getVersion().replace(".", "_") + ".html";

                if (new File(context.getTmpDir(), fileName).isFile()) {
                    printStep("exists", v.getVersion());
                } else {
                    context.asciiDoctor().writeFile(attributes, url, context.getTmpDir(), fileName);
                    printStep("created", v.getVersion());
                }

                v.setReleaseNotes("target/tmp/" + fileName);
            } catch (FileNotFoundException e) {
                printStep("missing",  v.getVersion());
            } catch (Exception e) {
                printStep("error", v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

}
