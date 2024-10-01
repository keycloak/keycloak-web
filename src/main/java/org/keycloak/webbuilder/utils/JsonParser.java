package org.keycloak.webbuilder.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class JsonParser {

    private static final ObjectMapper mapper = new ObjectMapper();

    public static <T> T read(File f, Class<T> t) {
        try {
            return mapper.readValue(f, t);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> T read(URL url, Class<T> t) {
        try {
            return mapper.readValue(url, t);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
