package org.keycloak.webbuilder;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ProjectStars {

    private String aspectRatioLarge;
    private String aspectRatioLSmall;

    public String getAspectRatioSmall() {
        return aspectRatioLSmall;
    }

    public String getAspectRatioLarge() {
        return aspectRatioLarge;
    }

    public ProjectStars() {
    }

    private static final Pattern ASPECT = Pattern.compile("<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"([0-9]*)\" height=\"([0-9]*)\">");

    private String retrieveAspectRatio(String logoLarge) {
        Matcher matcher = ASPECT.matcher(logoLarge);
        if (matcher.find()) {
            return matcher.group(1) + "/" + matcher.group(2);
        }
        else {
            return null;
        }
    }

    private String fetch(URL url) throws IOException {
        return IOUtils.toString(url, StandardCharsets.UTF_8);
    }

    public void init(Context context) {
        try {
            String logoLarge = fetch(new URL("https://img.shields.io/github/stars/keycloak/keycloak?label=GitHub%20Stars"));
            FileUtils.write(new File(context.getTargetDir(), "resources/images/stars-large.svg"), logoLarge, StandardCharsets.UTF_8);
            aspectRatioLarge = retrieveAspectRatio(logoLarge);
            String logoSmall = fetch(new URL("https://img.shields.io/github/stars/keycloak/keycloak?label="));
            FileUtils.write(new File(context.getTargetDir(), "resources/images/stars-small.svg"), logoSmall, StandardCharsets.UTF_8);
            aspectRatioLSmall = retrieveAspectRatio(logoSmall);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
