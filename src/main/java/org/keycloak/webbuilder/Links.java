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
        if (!guide.getCategory().getDynamic()) {
            return "https://github.com/keycloak/keycloak-web/tree/main/guides/" + guide.getCategory().getId() + "/" + guide.getName() + ".adoc";
        } else {
            return "https://github.com/keycloak/keycloak/tree/main/docs/guides/src/main/" + guide.getCategory().getId() + "/" + guide.getName() + ".adoc";
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
