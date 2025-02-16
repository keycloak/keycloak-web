package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.util.HashMap;

public class DownloadsArchiveBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File archiveDir = new File(context.getTargetDir(), "archive");
        if (!archiveDir.isDirectory()) {
            archiveDir.mkdir();
        }

        for (Versions.Version version : context.versions()) {
            HashMap<String, Object> attributes = new HashMap<>();
            attributes.put("archive", true);
            attributes.put("version", version);

            String file = "downloads-" + version.getVersionShort() + ".html";
            context.freeMarker().writeFile(attributes, "templates/downloads-archive-version.ftl", archiveDir, file);
            context.sitemap().addFile(new File(archiveDir, file));
            printStep("created", file);
        }
    }

    @Override
    protected String getTitle() {
        return "Downloads Archive";
    }

}
