package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.util.HashMap;

public class DocumentationArchiveBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File archiveDir = new File(context.getTargetDir(), "archive");
        if (!archiveDir.isDirectory()) {
            archiveDir.mkdir();
        }

        for (Versions.Version version : context.versions().getMajorMinor()) {
            HashMap<String, Object> attributes = new HashMap<>();
            attributes.put("archive", true);
            attributes.put("version", version);

            context.freeMarker().writeFile(attributes, "templates/documentation-archive-version.ftl", archiveDir, "documentation-" + version.getVersionShorter() + ".html");
            printStep("created", "documentation-" + version.getVersionShorter() + ".html");
        }
    }

    @Override
    protected String getTitle() {
        return "Documentation Archive";
    }

}
