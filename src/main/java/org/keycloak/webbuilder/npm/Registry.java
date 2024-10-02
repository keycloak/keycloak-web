package org.keycloak.webbuilder.npm;

import org.keycloak.webbuilder.utils.JsonParser;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;

public class Registry {
    public static URI REGISTRY_URI;

    static {
        try {
            REGISTRY_URI = new URI("https://registry.npmjs.org");
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

    public static Package getPackage(String name) throws MalformedURLException {
        return JsonParser.read(REGISTRY_URI.resolve("/" + name).toURL(), Package.class);
    }
}
