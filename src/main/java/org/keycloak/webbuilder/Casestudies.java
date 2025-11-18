package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.JsonParser;

import java.io.File;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

public class Casestudies {

    List<Casestudy> casestudies = new ArrayList<>();

    public List<Casestudy> getCaseStudies() {
        casestudies.sort(Comparator.comparing(Casestudy::getPublished).reversed());
        return casestudies;
    }

    public Casestudies(File casestudiesDir) {
        for (File extensionFile : casestudiesDir.listFiles((dir, name) -> name.endsWith(".json"))) {
            var casestudy = JsonParser.read(extensionFile, Casestudy.class);
            casestudies.add(casestudy);
        }
    }

    public static class Casestudy implements  Comparable<Casestudy> {
        private String name;
        private String title;
        private String description;
        private String url;
        private String logoUrl;
        private String logoStyle;
        private String logoBackground;
        private String published;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getLogoUrl() {
            return logoUrl;
        }

        public void setLogoUrl(String logoUrl) {
            this.logoUrl = logoUrl;
        }

        @Override
        public int compareTo(Casestudy o) {
            return name.compareTo(o.name);
        }

        public String getPublished() {
            return published;
        }

        public void setPublished(String published) {
            this.published = published;
        }

        public String getLogoBackground() {
            return logoBackground;
        }

        public void setLogoBackground(String logoBackground) {
            this.logoBackground = logoBackground;
        }

        public String getLogoStyle() {
            return Objects.requireNonNullElse(logoStyle, "");
        }

        public void setLogoStyle(String logoStyle) {
            this.logoStyle = logoStyle;
        }
    }
}
