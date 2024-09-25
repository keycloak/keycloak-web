package org.keycloak.webbuilder.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;

import java.io.File;

public class YamlParser {

    private final ObjectMapper mapper = new ObjectMapper(new YAMLFactory());

    public <T> T read(File f, Class<T> t) {
        try {
            return mapper.readValue(f, t);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
