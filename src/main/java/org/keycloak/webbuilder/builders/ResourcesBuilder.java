package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.Arrays;
import java.util.Optional;

public class ResourcesBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File targetResourcesDir = new File(context.getTargetDir(), "resources");

        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), new File(new File(targetResourcesDir, "images"), "guides"));
        Optional<File> genGuidesDir = Arrays.stream(context.getTmpDir().getParentFile().listFiles((f, s) -> s.startsWith("keycloak-guides"))).findFirst();
        Optional<File> genGuidesImagesDir = genGuidesDir.flatMap( d -> Arrays.stream(new File(d, "generated-guides").listFiles(n -> n.getName().equals("images"))).findAny());
        if (genGuidesImagesDir.isPresent()) {
            FileUtils.copyDirectory(genGuidesImagesDir.get(), new File(new File(targetResourcesDir, "images"), "generated-guides"));
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
