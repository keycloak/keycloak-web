package org.keycloak.webbuilder;

import java.util.List;

public class GuidesMetadata {

    public List<GuideMetadata> guides;

    public List<GuideSource> sources;

    public List<GuideMetadata> getGuides() {
        return guides;
    }

    public void setGuides(List<GuideMetadata> guides) {
        this.guides = guides;
    }

    public List<GuideSource> getSources() {
        return sources;
    }

    public void setSources(List<GuideSource> sources) {
        this.sources = sources;
    }

    public static class GuideMetadata {

        private String id;
        private String title;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }

    public static class GuideSource {

        private String id;
        private String dir;
        private String github;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getDir() {
            return dir;
        }

        public void setDir(String dir) {
            this.dir = dir;
        }

        public String getGithub() {
            return github;
        }

        public void setGithub(String github) {
            this.github = github;
        }
    }

}
