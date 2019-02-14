package org.keycloak.webbuilder;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class Config {

    private int maxBlog;
    private int maxNews;

    private Urls urls;

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
        private String docs;
        private String blog;
        private String source;
        private String issues;

        public String getDocs() {
            return docs;
        }

        public void setDocs(String docs) {
            this.docs = docs;
        }

        public String getBlog() {
            return blog;
        }

        public void setBlog(String blog) {
            this.blog = blog;
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
