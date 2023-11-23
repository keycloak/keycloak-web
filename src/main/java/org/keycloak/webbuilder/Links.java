package org.keycloak.webbuilder;

public class Links {

    private Config config;

    public Links(Config config) {
        this.config = config;
    }

    public String getRoot() {
        return config.getUrls().getHome();
    }

    public String getHome() {
        return getRoot() + (config.isPublish() ? "/" : "/index.html");
    }

    public String getDocs() {
        return getLink("documentation");
    }

    public String getGuides() {
        return getLink("guides");
    }

    public String getDownloads() {
        return getLink("downloads");
    }

    public String getCommunity() {
        return getLink("community");
    }

    public String getBlog() {
        return getLink("blog");
    }

    public String getAbout() {
        return getLink("about");
    }

    public String getResource(String path) {
        return getRoot() + "/resources/" + path;
    }

    public String getRss() {
        return getRoot() + "/rss.xml";
    }

    public String get(Guides.Guide guide) {
        if (guide.isExternal()) {
            return guide.getExternalLink();
        } else {
            return getLink(guide.getPath());
        }
    }

    public String getGuideEdit(Guides.Guide guide) {
        switch (guide.getCategory()) {
            case SERVER:
                return "https://github.com/keycloak/keycloak/tree/main/docs/guides/server/" + guide.getName() + ".adoc";
            case SECURING_APPS:
                return "https://github.com/keycloak/keycloak-web/tree/main/guides/securing-apps/" + guide.getName() + ".adoc";
            case MIGRATION:
                return "https://github.com/keycloak/keycloak/tree/main/docs/guides/migration/" + guide.getName() + ".adoc";
            case OPERATOR:
                return "https://github.com/keycloak/keycloak/tree/main/docs/guides/operator/" + guide.getName() + ".adoc";
            case GETTING_STARTED:
                return "https://github.com/keycloak/keycloak/tree/main/docs/guides/getting-started/" + guide.getName() + ".adoc";
            case HIGH_AVAILABILITY:
                return "https://github.com/keycloak/keycloak/tree/main/docs/guides/high-availability/" + guide.getName() + ".adoc";
            default:
                return null;
        }
    }

    public String get(Blogs.Blog blog) {
        return getLink(blog.getPath() + "/" + blog.getName());
    }

    private String getLink(String path) {
        if (!path.startsWith("/")) {
            path = "/" + path;
        }
        return getRoot() + path + (config.isPublish() ? "" : ".html");
    }

}
