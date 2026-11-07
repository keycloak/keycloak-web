package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Versions;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.HashMap;

public class DocumentationArchiveBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File archiveDir = new File(context.getTargetDir(), "archive");
        if (!archiveDir.isDirectory()) {
            archiveDir.mkdir();
        }

        // It will be used at keycloak.github.io to identify versions in this list.
        // Rest of documentation directories will be deleted to save pages deployment size and obey the 1GB limit
        File activeArchiveVersions = new File(archiveDir, "active-docs-versions.txt");
        try (PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(activeArchiveVersions)))) {
            pw.println("latest");
            for (Versions.Version version : context.versions().getMajorMinor()) {
                HashMap<String, Object> attributes = new HashMap<>();
                attributes.put("archive", true);
                attributes.put("version", version);

                String file = "documentation-" + version.getVersionShorter() + ".html";
                context.freeMarker().writeFile(attributes, "templates/documentation-archive-version.ftl", archiveDir, file);
                context.sitemap().addFile(new File(archiveDir, file));
                printStep("created", file);
                pw.println(version.getVersion());
            }
        }

    }

    @Override
    protected String getTitle() {
        return "Documentation Archive";
    }

}
