package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.Optional;
import java.util.stream.Stream;

public class ResourcesBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File targetResourcesDir = new File(context.getTargetDir(), "resources");
        File guidesImageDir = new File(new File(targetResourcesDir, "images"), "guides");

        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), guidesImageDir);
        Optional<File> genGuidesDir = Arrays.stream(context.getTmpDir().getParentFile().listFiles((f, s) -> s.startsWith("keycloak-guides"))).findFirst();

        Optional<File> genGuidesImagesDir = genGuidesDir.flatMap( d -> Arrays.stream(new File(d, "generated-guides").listFiles(n -> n.getName().equals("images"))).findAny());
        if (genGuidesImagesDir.isPresent()) {
            for (File f : genGuidesImagesDir.get().listFiles()) {
                if (f.isFile()) {
                    FileUtils.copyFileToDirectory(f, guidesImageDir);
                } else {
                    FileUtils.copyDirectoryToDirectory(f, guidesImageDir);
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
