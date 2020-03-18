package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Context;
import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class ReleaseNotesBuilder extends AbstractBuilder {

    private static final String BASE_URL = "https://raw.githubusercontent.com/keycloak/keycloak-documentation/master/";
    private static final String DOCUMENT_ATTRIBUTES_URL = BASE_URL + "topics/templates/document-attributes-community.adoc";

    @Override
    protected String getTitle() {
        return "Release Notes";
    }

    public void build() throws IOException {
        Map<String, Object> attributes = new HashMap<>();

        attributes.put("project_buildType", "latest");
        attributes.put("leveloffset", "1");

        attributes = context.asciiDoctor().parseAttributes(new URL(DOCUMENT_ATTRIBUTES_URL), attributes);

        context.getTmpDir().mkdirs();

        for (Versions.Version v : context.versions()) {
            try {
                String fileName = v.getVersion().replace(".", "_");
                URL url = new URL(BASE_URL + "release_notes/topics/" + fileName + ".adoc");

                context.asciiDoctor().writeFile(attributes, url, context.getTmpDir(), fileName + ".ftl");

                v.setReleaseNotes("target/tmp/" + fileName + ".ftl");

                printStep("created", v.getVersion());
            } catch (FileNotFoundException e) {
                printStep("missing",  v.getVersion());
            } catch (Exception e) {
                printStep("error", v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

}
