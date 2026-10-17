package org.keycloak.webbuilder;

public class Links {

    private Config config;
    private Guides guides;

    public Links(Config config) {
        this.config = config;
    }

    public void setGuides(Guides guides) {
        this.guides = guides;
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

    public String getGuides(GuideVersions.GuideVersion version) {
        return getLink(version.getPrefix() + "guides");
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
        return guide.isExternal() ? guide.getExternalLink() : getLink(guide.getVersion().getPrefix() + guide.getPath());
    }

    public String get(Guides.Guide guide, Boolean snapshot) {
        return snapshot == null ? get(guide) : getGuideVersion(guide,
                snapshot ? guides.getVersions().getNightly() : guides.getVersions().getCurrent());
    }

    public String getGuideVersion(Guides.Guide guide, GuideVersions.GuideVersion version) {
        Guides.Guide equivalent = guides.getEquivalent(guide, version);
        return equivalent == null ? getGuides(version) : get(equivalent);
    }

    public String getGuideEdit(Guides.Guide guide) {
        String github = guide.getGuideSource().getGithub();
        if (guide.getVersion().isArchived()) {
            github = github.replace("/tree/main/", "/tree/" + guide.getVersion().getVersion() + "/");
        }
        return github + guide.getMetadata().getId() + "/" + guide.getFQName() + ".adoc";
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
        return get(guides.getParent(guide));
    }
}
