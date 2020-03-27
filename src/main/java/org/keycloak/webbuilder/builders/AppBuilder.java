package org.keycloak.webbuilder.builders;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;

public class AppBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File f = new File(context.getTargetDir(), "app/keycloak.js");
        if (!f.isFile()) {
            URL u = new URL("https://raw.githubusercontent.com/keycloak/keycloak/" + context.versions().getLatest().getVersion() + "/adapters/oidc/js/src/main/resources/keycloak.js");
            InputStream is = u.openStream();
            Files.copy(is, f.toPath());
            is.close();
        }
    }

    @Override
    protected String getTitle() {
        return "App";
    }
}
