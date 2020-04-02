package org.keycloak.webbuilder;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class Config {

    private boolean publish;

    private int maxBlog;
    private int maxNews;

    private Urls urls;

    public boolean isPublish() {
        return publish;
    }

    public void setPublish(boolean publish) {
        this.publish = publish;
    }

    public int getMaxBlog() {
        return maxBlog;
    }

    public void setMaxBlog(int maxBlog) {
        this.maxBlog = maxBlog;
    }

    public int getMaxNews() {
        return maxNews;
    }

    public void setMaxNews(int maxNews) {
        this.maxNews = maxNews;
    }

    public Urls getUrls() {
        return urls;
    }

    public void setUrls(Urls urls) {
        this.urls = urls;
    }

    public static class Urls {
        private String home;
        private String source;
        private String issues;

        public String getHome() {
            return home;
        }

        public void setHome(String home) {
            if (!home.endsWith("/")) {
                home += "/";
            }
            this.home = home;
        }

        public String getSource() {
            return source;
        }

        public void setSource(String source) {
            this.source = source;
        }

        public String getIssues() {
            return issues;
        }

        public void setIssues(String issues) {
            this.issues = issues;
        }
    }

}
