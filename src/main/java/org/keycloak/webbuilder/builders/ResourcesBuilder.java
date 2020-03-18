package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.File;

public class ResourcesBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File targetResourcesDir = new File(context.getTargetDir(), "resources");

        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), new File(new File(targetResourcesDir, "images"), "guides"));

        printStep("copied", "blog images");

        FileUtils.copyDirectory(context.getStaticDir(), context.getTargetDir());

        printStep("copied", "static files");
    }

    @Override
    protected String getTitle() {
        return "Resources";
    }

}
