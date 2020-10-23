package org.keycloak.webbuilder.misc;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class NpmPackageInfo {

    @JsonProperty("dist-tags")
    private DistTags distTags;

    public DistTags getDistTags() {
        return distTags;
    }

    public class DistTags {
        private String latest;

        public String getLatest() {
            return latest;
        }
    }

}
