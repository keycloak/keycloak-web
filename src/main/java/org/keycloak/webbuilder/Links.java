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

    public String getNightly() {
        return getRoot() + (config.isPublish() ? "/nightly/" : "/nightly/index.html");
    }

    public String getExtensions() {
        return getLink("extensions");
    }

    public String getCasestudies() {
        return getLink("case-studies");
    }

    public String getTranslations() {
        return getLink("translations");
    }

    public String getDocs() {
        return getLink("documentation");
    }

    public String getGuides() {
        return getGuides(false);
    }

    public String getGuides(boolean snapshot) {
        return snapshot ? getLink("nightly/guides") : getLink("guides");
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
        return get(guide, null);
    }

    public String get(Guides.Guide guide, Boolean snapshot) {
        if (guide.isExternal()) {
            return guide.getExternalLink();
        } else {
            boolean nightly = (guide.isSnapshot() && snapshot == null) || (snapshot != null && snapshot);
            return getLink((nightly ? "nightly/" : "") + guide.getPath());
        }
    }

    public String getGuideEdit(Guides.Guide guide) {
        return guide.getGuideSource().getGithub() + guide.getMetadata().getId() + "/" + guide.getFQName() + ".adoc";
    }

    public String get(Blogs.Blog blog) {
        return getLink(blog.getPath() + "/" + blog.getName());
    }

    public String getLink(String path) {
        if (!path.startsWith("/")) {
            path = "/" + path;
        }
        return getRoot() + path + (config.isPublish() ? "" : ".html");
    }

    public String getParentLink(Guides.Guide guide) {
        StringBuilder sb = new StringBuilder(getRoot()).append("/");
        if (guide.isSnapshot()) {
            sb.append("nightly/");
        }
        sb.append(guide.getMetadata().getId()).append("/");
        if (guide.hasParent()) {
            sb.append(guide.getParent()).append("/");
        }
        sb.append("introduction");
        if (!config.isPublish()) {
            sb.append(".html");
        }
        return sb.toString();
    }
}
