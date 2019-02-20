package org.keycloak.webbuilder;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Blog {

    private final Date date;

    private final String name;

    private final String title;

    private final String author;

    private final String category;

    private final boolean release;

    private final boolean publish;

    private final String template;

    private final Map<String, Object> map = new HashMap<>();

    public Blog(Date date, String name, String title, String author, String category, boolean publish, boolean release, String template) {
        this.date = date;
        this.name = name;
        this.title = title;
        this.author = author;
        this.category = category;
        this.publish = publish;
        this.release = release;
        this.template = template;
    }

    public Date getDate() {
        return date;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getCategory() {
        return category;
    }

    public String getFilename() {
        return title.toLowerCase().replace(" ", "-").replace(".", "").replace("?", "").replace("!", "") + ".html";
    }

    public boolean isPublish() {
        return publish;
    }

    public boolean isRelease() {
        return release;
    }

    public String getTemplate() {
        return template;
    }

    public String getPath() {
        return WebBuilder.dateYear.format(getDate()) + "/" + WebBuilder.dateMonth.format(getDate());
    }

    public Map<String, Object> getMap() {
        return map;
    }
}
