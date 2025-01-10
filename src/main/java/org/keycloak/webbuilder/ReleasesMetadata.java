package org.keycloak.webbuilder;

import java.util.List;

public class ReleasesMetadata {
    public final static String MAIN_PROJECT_ID = "keycloak";

    public List<ReleaseSource> sources;

    public List<ReleaseSource> getSources() {
        return sources;
    }

    public void setSources(List<ReleaseSource> sources) {
        this.sources = sources;
    }

    public static class ReleaseSource {
        private String id;
        private String productName;
        private String repo;
        private String githubReleaseNotesFrom;
        private String releaseNotes;
        private List<String> attributeSources;
        private String migrationGuidePath;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getProductName() {
            return this.productName;
        }

        public void setProductName(String productName) {
            this.productName = productName;
        }

        public String getRepo() {
            return repo;
        }

        public void setRepo(String repo) {
            this.repo = repo;
        }

        public String getGithubReleaseNotesFrom() {
            return githubReleaseNotesFrom;
        }

        public void setGithubReleaseNotesFrom(String githubReleaseNotesFrom) {
            this.githubReleaseNotesFrom = githubReleaseNotesFrom;
        }

        public String getReleaseNotes() {
            return releaseNotes;
        }

        public void setReleaseNotes(String releaseNotes) {
            this.releaseNotes = releaseNotes;
        }

        public List<String> getAttributeSources() {
            return attributeSources;
        }

        public void setAttributeSources(List<String> attributeSources) {
            this.attributeSources = attributeSources;
        }

        public String getMigrationGuidePath() {
            return migrationGuidePath;
        }

        public void setMigrationGuidePath(String migrationGuidePath) {
            this.migrationGuidePath = migrationGuidePath;
        }

        public boolean isMainProject() {
            return getId().equals(MAIN_PROJECT_ID);
        }
    }
}
