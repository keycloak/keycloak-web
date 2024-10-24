package org.keycloak.webbuilder.npm;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveInputStream;
import org.apache.commons.compress.compressors.gzip.GzipCompressorInputStream;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Map;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Version {
    @JsonProperty("exports")
    private Map<String, Export> exports;

    @JsonProperty("dist")
    private Dist dist;

    public Dist getDist() {
        return dist;
    }

    public String resolveEntryPoint() {
        Export defaultExport = exports.get(".");
        return defaultExport != null ? defaultExport.getDefaultPath() : null;
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Export {
        @JsonProperty("default")
        private String defaultPath;

        public String getDefaultPath() {
            return defaultPath;
        }
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Dist {
        @JsonProperty("tarball")
        private String tarball;

        public ArchiveInputStream<TarArchiveEntry> getTarballStream() throws IOException {
            URL url = new URL(tarball);

            return new TarArchiveInputStream(
                    new GzipCompressorInputStream(
                            new BufferedInputStream(url.openStream())
                    )
            );
        }
    }
}
