package org.keycloak.webbuilder;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class GuideVersions {

    private final Properties properties;
    private final GuideVersion current;
    private final GuideVersion nightly = new GuideVersion("nightly", "999.0.0-SNAPSHOT");
    private final List<GuideVersion> archived;

    public GuideVersions() throws IOException {
        this(loadProperties());
    }

    GuideVersions(Properties properties) {
        this.properties = properties;
        current = new GuideVersion("release", getSourceVersion("keycloak"));
        archived = new ArrayList<>();
        for (String property : List.of("version.keycloak-previous-1", "version.keycloak-previous-2")) {
            String version = properties.getProperty(property, "");
            if (version.isBlank()) {
                continue;
            }
            if (!version.matches("\\d+\\.\\d+\\.\\d+")) {
                throw new IllegalArgumentException("Archived guides require an exact release version: " + version);
            }
            String minor = version.substring(0, version.lastIndexOf('.'));
            if (Versions.Version.compareToVersions(minor + ".0", current.getMinor() + ".0") >= 0
                    || archived.stream().anyMatch(v -> v.getMinor().equals(minor))) {
                throw new IllegalArgumentException("Archived guide branches must be distinct and older than "
                        + current.getMinor() + ": " + version);
            }
            archived.add(new GuideVersion(minor, version));
        }
        archived.sort((a, b) -> Versions.Version.compareToVersions(b.getVersion(), a.getVersion()));
    }

    private static Properties loadProperties() throws IOException {
        Properties properties = new Properties();
        try (var stream = GuideVersions.class.getResourceAsStream("/guide-versions.properties")) {
            if (stream == null) {
                throw new IOException("Missing guide-versions.properties; run ./mvnw process-resources first");
            }
            properties.load(stream);
        }
        return properties;
    }

    public String getSourceVersion(String sourceId) {
        String property = "version." + sourceId.replaceFirst("-guides$", "");
        String version = properties.getProperty(property);
        if (version == null || version.isBlank()) {
            throw new IllegalArgumentException("Missing guide version property " + property);
        }
        return version;
    }

    public GuideVersion getCurrent() {
        return current;
    }

    public GuideVersion getNightly() {
        return nightly;
    }

    public List<GuideVersion> getArchived() {
        return archived;
    }

    public List<GuideVersion> getAll() {
        List<GuideVersion> versions = new ArrayList<>(List.of(nightly, current));
        versions.addAll(archived);
        return versions;
    }

    public GuideVersion forRelease(String release) {
        String minor = release.substring(0, release.lastIndexOf('.'));
        return getAll().stream()
                .filter(v -> !v.isSnapshot() && v.getMinor().equals(minor))
                .findFirst().orElse(null);
    }

    public static class GuideVersion {

        private final String id;
        private final String version;

        public GuideVersion(String id, String version) {
            this.id = id;
            this.version = version;
        }

        public String getId() {
            return id;
        }

        public String getVersion() {
            return version;
        }

        public String getMinor() {
            return version.substring(0, version.lastIndexOf('.'));
        }

        public String getLabel() {
            return isSnapshot() ? "Nightly" : version;
        }

        public boolean isSnapshot() {
            return id.equals("nightly");
        }

        public boolean isArchived() {
            return !id.equals("release") && !isSnapshot();
        }

        public boolean isNoindex() {
            return isSnapshot() || isArchived();
        }

        public String getPrefix() {
            return id.equals("release") ? "" : id + "/";
        }
    }
}
