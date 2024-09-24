package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;
import org.keycloak.webbuilder.GuidesMetadata;

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
        File guidesNightlyImageDir = new File(new File(targetResourcesDir, "images"), "guides/nightly");

        FileUtils.copyDirectory(context.getResourcesDir(), targetResourcesDir);

        printStep("copied", "resources");

        FileUtils.copyDirectory(new File(context.getBlogDir(), "images"), new File(new File(targetResourcesDir, "images"), "blog"));
        FileUtils.copyDirectory(new File(context.getGuidesDir(), "images"), guidesImageDir);

        for (GuidesMetadata.GuideSource guideSource : context.getGuidesMetadata().getSources()) {
            final File d = new File(context.getWebSrcDir(), guideSource.getDir());
            File[] sourceDirs;
            if (d.getName().contains("$$VERSION$$")) {
                sourceDirs = d.getParentFile().listFiles(f -> f.getName().matches(d.getName().replace("$$VERSION$$", ".*")));
            } else {
                sourceDirs = new File[] { d };
            }

            for (File sourceDir : sourceDirs) {
                File imageDir = new File(sourceDir, "generated-guides/images");
                if (imageDir.isDirectory()) {
                    boolean snapshot = sourceDir.getName().endsWith("-SNAPSHOT");
                    File targetDir = snapshot ? guidesNightlyImageDir : guidesImageDir;
                    for (File f : imageDir.listFiles()) {
                        if (f.isFile()) {
                            FileUtils.copyFileToDirectory(f, targetDir);
                        } else {
                            FileUtils.copyDirectoryToDirectory(f, targetDir);
                        }
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
