package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class ResourcesBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File targetResourcesDir = new File(context.getTargetDir(), "resources");
        File guidesImageDir = new File(new File(targetResourcesDir, "images"), "guides");

        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), guidesImageDir);
        List<File> genGuidesImagesDirs = Arrays.stream(context.getTmpDir().getParentFile()
                .listFiles((f, s) -> s.startsWith("keycloak-guides") || s.startsWith("keycloak-client-guides")))
                .flatMap(d -> Arrays.stream(new File(d, "generated-guides").listFiles(n -> n.getName().equals("images"))))
                .collect(Collectors.toList());

         for (File genGuidesImagesDir : genGuidesImagesDirs) {
            for (File f : genGuidesImagesDir.listFiles()) {
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
