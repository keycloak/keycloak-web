package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.IOException;

public class Cleaner extends AbstractBuilder {

    @Override
    protected void build() throws IOException {
        if (context.getTargetDir().isDirectory()) {
            FileUtils.deleteDirectory(context.getTargetDir());
            printStep("deleted", context.getTargetDir().toString());
        }
    }

    @Override
    protected String getTitle() {
        return "Clean";
    }

}
