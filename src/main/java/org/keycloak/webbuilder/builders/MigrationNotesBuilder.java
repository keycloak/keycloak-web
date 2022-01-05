package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class MigrationNotesBuilder extends AbstractBuilder {

    private static final String BASE_URL = "https://raw.githubusercontent.com/keycloak/keycloak-documentation/master/";
    private static final String DOCUMENT_ATTRIBUTES_URL = BASE_URL + "topics/templates/document-attributes-community.adoc";

    @Override
    protected String getTitle() {
        return "Migration Notes";
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
                URL url = new URL(BASE_URL + "upgrading/topics/keycloak/changes-" + v.getVersion().replace(".", "_") + ".adoc");

                String fileName = "migration-notes-" + v.getVersion().replace(".", "_");

                if (new File(context.getTmpDir(), fileName).isFile()) {
                    printStep("exists", v.getVersion());
                } else {
                    context.asciiDoctor().writeFile(attributes, url, context.getTmpDir(), fileName);
                    printStep("created", v.getVersion());
                }

                v.setMigrationNotes("target/tmp/" + fileName);
            } catch (FileNotFoundException e) {
                printStep("missing",  v.getVersion());
            } catch (Exception e) {
                printStep("error", v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

}
