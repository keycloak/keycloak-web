package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.JsonParser;

import java.io.File;
import java.text.ParseException;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedList;

public class News extends LinkedList<News.NewsItem> {

    public News(File newsDir, Blogs blogs, Config config) throws ParseException {
        File[] newsFiles = newsDir.listFiles((dir, name) -> name.endsWith(".json"));
        if (newsFiles != null) {
            for (int i = 0; i < newsFiles.length && i < config.getMaxNews(); i++) {
                NewsItem news = JsonParser.read(newsFiles[i], NewsItem.class);
                news.setDate(Constants.DATE_IN.parse(newsFiles[i].getName()));
                add(news);
            }
        }

        for (Blogs.Blog b : blogs) {
            News.NewsItem news = new News.NewsItem();
            news.setDate(b.getDate());
            news.setTitle(b.getTitle());
            news.setLink(b.getPath() + "/" + b.getFilename());
            add(news);
        }

        sort(Comparator.comparing(News.NewsItem::getDate).reversed());

        if (size() > config.getMaxNews()) {
            removeRange(config.getMaxNews(), size());
        }
    }

    public static class NewsItem {

        private Date date;

        private String title;

        private String link;

        public Date getDate() {
            return date;
        }

        public void setDate(Date date) {
            this.date = date;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getLink() {
            return link;
        }

        public void setLink(String link) {
            this.link = link;
        }

    }

}
