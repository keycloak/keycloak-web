package org.keycloak.webbuilder.utils;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;

public class JsonParser {

    private final ObjectMapper mapper = new ObjectMapper();

    public <T> T read(File f, Class<T> t) {
        try {
            return mapper.readValue(f, t);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
