package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;
import java.io.File;

public class ResourcesBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File targetResourcesDir = new File(context.getTargetDir(), "resources");
        File guidesImageDir = new File(new File(targetResourcesDir, "images"), "guides");

        if (guidesImageDir.isDirectory()) {
            for (File directory : guidesImageDir.listFiles(f -> f.isDirectory() && f.getName().matches("\\d+\\.\\d+"))) {
                FileUtils.deleteDirectory(directory);
            }
        }
        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), guidesImageDir);

        for (var source : context.guides().getSources()) {
            File imageDir = source.directory().resolve("generated-guides/images").toFile();
            if (imageDir.isDirectory()) {
                File targetDir = new File(guidesImageDir, source.version().getPrefix());
                for (File f : imageDir.listFiles()) {
                    if (f.isFile()) {
                        FileUtils.copyFileToDirectory(f, targetDir);
                    } else {
                        FileUtils.copyDirectoryToDirectory(f, targetDir);
                    }
                }
            }
        }

        printStep("copied", "blog images");

        FileUtils.copyDirectory(context.getStaticDir(), context.getTargetDir());

        printStep("copied", "static files");
    }

    @Override
    protected String getTitle() {
        return "Resources";
    }

}
