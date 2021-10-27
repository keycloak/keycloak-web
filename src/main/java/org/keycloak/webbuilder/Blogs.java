package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;
import org.keycloak.webbuilder.utils.FreeMarker;

import java.io.File;
import java.util.*;

public class Blogs extends LinkedList<Blogs.Blog> {

    private static final Date REMOVE_ADOC_FROM_TITLE_FIX_DATE = new GregorianCalendar(2021, Calendar.OCTOBER, 25).getTime();

    private static Calendar OLD_BLOG;
    static {
        OLD_BLOG = Calendar.getInstance();
        OLD_BLOG.setTime(new Date());
        OLD_BLOG.add(Calendar.MONTH, -12);
    }

    private FreeMarker freeMarker;
    private AsciiDoctor asciiDoctor;

    public Blogs(File blogDir, Versions versions, Config config, FreeMarker freeMarker, AsciiDoctor asciiDoctor) throws Exception {
        this.freeMarker = freeMarker;
        this.asciiDoctor = asciiDoctor;

        List<File> blogFiles = new LinkedList<>();
        for (File d : blogDir.listFiles((dir, name) -> name.matches("\\d{4}"))) {
            for (File f: d.listFiles((dir, name) -> name.endsWith(".ftl") || name.endsWith(".adoc"))) {
                blogFiles.add(f);
            }
        }

        if (blogFiles != null) {
            for (File f : blogFiles) {
                BlogFormat format = f.getName().endsWith(".ftl") ? BlogFormat.FREEMARKER : BlogFormat.ASCIIDOC;
                Map<String, Object> attributes = BlogFormat.FREEMARKER.equals(format) ? freeMarker.parseAttributes(f) : asciiDoctor.parseAttributes(f);

                Date date = attributes.containsKey("date") ? Constants.DATE_IN.parse(attributes.get("date").toString()) : null;
                boolean publish = attributes.containsKey("publish") ? Boolean.parseBoolean((String) attributes.get("publish")) : false;

                String name = f.getName().replace(".ftl", "");

                // Remove '.adoc' from blog links only after fix date not to break external links to blog posts
                if (date.after(REMOVE_ADOC_FROM_TITLE_FIX_DATE)) {
                    name = name.replace(".adoc", "");
                }

                Blog blog = new Blog(
                        format,
                        date,
                        name,
                        (String) attributes.get("title"),
                        (String) attributes.get("summary"),
                        (String) attributes.get("author"),
                        (String) attributes.get("category"),
                        publish,
                        false,
                        "blog/" + f.getParentFile().getName() + "/" + f.getName());

                if (blog.isPublish() || !config.isPublish()) {
                    add(blog);
                }
            }
        }

        for (Versions.Version v : versions) {
            Blog blog = new Blog(BlogFormat.FREEMARKER, v.getDate(), "keycloak-" + v.getVersion().replace(".", "") + "-released", "Keycloak " + v.getVersion() + " released", null, null, "Keycloak Release", true, true, "templates/blog-release.ftl");
            blog.getMap().put("version", v);
            add(blog);
        }

        sort(Comparator.comparing(Blog::getDate).reversed());
    }

    public static class Blog {

        private BlogFormat format;

        private final Date date;

        private final String name;

        private final String title;

        private final String summary;

        private final String author;

        private final String category;

        private final boolean release;

        private final boolean publish;

        private String template;

        private final Map<String, Object> map = new HashMap<>();

        public Blog(BlogFormat format, Date date, String name, String title, String summary, String author, String category, boolean publish, boolean release, String template) {
            this.format = format;
            this.date = date;
            this.name = name;
            this.title = title;
            this.summary = summary;
            this.author = author;
            this.category = category;
            this.publish = publish;
            this.release = release;
            this.template = template;
        }

        public BlogFormat getFormat() {
            return format;
        }

        public Date getDate() {
            return date;
        }

        public String getName() {
            return name;
        }

        public String getTitle() {
            return title;
        }

        public String getSummary() {
            return summary;
        }

        public String getAuthor() {
            return author;
        }

        public String getCategory() {
            return category;
        }

        public String getFilename() {
            return name + ".html";
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

        public void setTemplate(String template) {
            this.template = template;
        }

        public String getPath() {
            return Constants.DATE_YEAR.format(getDate()) + "/" + Constants.DATE_MONTH.format(getDate());
        }

        public Map<String, Object> getMap() {
            return map;
        }

        public boolean isOld() {
            return OLD_BLOG.getTime().after(date);
        }
    }

    public enum BlogFormat {
        FREEMARKER, ASCIIDOC
    }

}
