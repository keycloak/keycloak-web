package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.JsonParser;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public class ImportMap {
    private final String FILE_NAME = "import-map.json";

    private Path targetDir = null;
    private String value;

    public ImportMap(Path targetDir) {
        this.targetDir = targetDir;
    }

    public String getValue() throws Exception {
        // Return cached value if present.
        if (value != null) {
            return value;
        }

        // Read import map from disk and cache.
        Path source = targetDir.resolve(FILE_NAME);
        value = Files.readString(source);
        return value;
    }

    public void writeValue(Map<String, String> imports) throws Exception {
        // Create target directory if needed.
        Files.createDirectories(targetDir);

        // Build import map from installed packages.
        Map<String, Map<String, String>> importMap = new HashMap<>();
        importMap.put("imports", imports);

        // Write import map to disk.
        Path target = targetDir.resolve(FILE_NAME);
        JsonParser.write(target.toFile(), importMap);
    }
}
