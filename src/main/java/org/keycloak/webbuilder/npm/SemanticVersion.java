package org.keycloak.webbuilder.npm;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SemanticVersion {
    private static final Pattern VERSION_PATTERN = Pattern.compile("^(\\d+)\\.(\\d+)\\.(\\d+)$");

    private final int major;
    private final int minor;
    private final int patch;

    private SemanticVersion(int major, int minor, int patch) {
        this.major = major;
        this.minor = minor;
        this.patch = patch;
    }

    public int getMajor() {
        return major;
    }

    public int getMinor() {
        return minor;
    }

    public int getPatch() {
        return patch;
    }

    public static SemanticVersion fromString(String versionString) {
        Matcher matcher = VERSION_PATTERN.matcher(versionString);

        if (!matcher.matches()) {
            return null;
        }

        int major = Integer.parseInt(matcher.group(1));
        int minor = Integer.parseInt(matcher.group(2));
        int patch = Integer.parseInt(matcher.group(3));

        return new SemanticVersion(major, minor, patch);
    }
}
