package org.keycloak.webbuilder.builders;

import java.io.File;
import java.util.Arrays;

public class PageBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        buildDir(context.getPagesDir(), true);

        File[] dirs = context.getPagesDir().listFiles(f -> f.isDirectory());
        Arrays.sort(dirs);

        for (File d : dirs) {
            buildDir(d, false);
        }
    }

    private void buildDir(File d, boolean root) throws Exception {
        File[] pageFiles = d.listFiles((dir, name) -> name.endsWith(".ftl"));
        Arrays.sort(pageFiles);

        for (File pageFile : pageFiles) {
            String template = "pages/" + (root ? "" : d.getName() + "/") + pageFile.getName();
            File target = root ? context.getTargetDir() : new File(context.getTargetDir(), d.getName());
            target.mkdirs();
            context.freeMarker().writeFile( template, target, pageFile.getName().replace(".ftl", ".html"));
            printStep("created", pageFile.getName().replace(".ftl", ".html"));
        }
    }

    @Override
    protected String getTitle() {
        return "Pages";
    }
}
