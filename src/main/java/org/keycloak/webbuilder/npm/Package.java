package org.keycloak.webbuilder.npm;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Map;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Package {
    @JsonProperty("dist-tags")
    private Map<String, String> distTags;

    @JsonProperty("versions")
    private Map<String, Version> versions;

    public Version getVersionByTag(String tag) {
        String versionName = distTags.get(tag);
        return versions.get(versionName);
    }
}
