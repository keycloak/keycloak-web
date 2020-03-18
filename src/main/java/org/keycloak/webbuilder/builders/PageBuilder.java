package org.keycloak.webbuilder.builders;

import java.io.File;
import java.util.Arrays;

public class PageBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File[] pageFiles = context.getPagesDir().listFiles((dir, name) -> name.endsWith(".ftl"));
        Arrays.sort(pageFiles);

        for (File pageFile : pageFiles) {
            context.freeMarker().writeFile( "pages/" + pageFile.getName(), context.getTargetDir(), pageFile.getName().replace(".ftl", ".html"));
            printStep("created", pageFile.getName().replace(".ftl", ".html"));
        }
    }

    @Override
    protected String getTitle() {
        return "Pages";
    }
}
