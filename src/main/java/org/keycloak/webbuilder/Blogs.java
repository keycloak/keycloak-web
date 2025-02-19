package org.keycloak.webbuilder;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.IOException;
import java.util.*;

public class Blogs extends LinkedList<Blogs.Blog> {

    private static final Date REMOVE_ADOC_FROM_TITLE_FIX_DATE = new GregorianCalendar(2021, Calendar.OCTOBER, 25).getTime();

    private static Calendar OLD_BLOG;
    static {
        OLD_BLOG = Calendar.getInstance();
        OLD_BLOG.setTime(new Date());
        OLD_BLOG.add(Calendar.MONTH, -12);
    }

    public Blogs(Context context) throws Exception {
        List<File> blogFiles = new LinkedList<>();
        for (File d : context.getBlogDir().listFiles((dir, name) -> name.matches("\\d{4}"))) {
            for (File f: d.listFiles((dir, name) -> name.endsWith(".ftl") || name.endsWith(".adoc"))) {
                blogFiles.add(f);
            }
        }

        if (blogFiles != null) {
            for (File f : blogFiles) {
                BlogFormat format = f.getName().endsWith(".ftl") ? BlogFormat.FREEMARKER : BlogFormat.ASCIIDOC;
                Map<String, Object> attributes = BlogFormat.FREEMARKER.equals(format) ? context.freeMarker().parseAttributes(f) : context.asciiDoctor().parseAttributes(f);

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
                        (String) attributes.get("preview"),
                        (String) attributes.get("author"),
                        (String) attributes.get("category"),
                        publish,
                        false,
                        "blog/" + f.getParentFile().getName() + "/" + f.getName());

                if (blog.isPublish() || !context.config().isPublish()) {
                    add(blog);
                }
            }
        }

        ReleasesMetadata metadata = context.getReleasesMetadata();

        for (ReleasesMetadata.ReleaseSource source : metadata.getSources()) {
            for (Versions.Version v : context.versionsFor(source.getId())) {
                String summary = getSummary(source, v);
                Blog blog = new Blog(
                        BlogFormat.FREEMARKER,
                        v.getDate(),
                        source.getId() + "-" + v.getVersion().replace(".", "") + "-released",
                        source.getProductName() + " " + v.getVersion() + " released",
                        summary,
                        null,
                        null,
                        source.getProductName() + " Release",
                        true,
                        true,
                        "templates/blog-release-" + v.getBlogTemplate() + ".ftl"
                );
                blog.getMap().put("version", v);
                blog.getMap().put("source", source);
                add(blog);
            }
        }

        sort(Comparator.comparing(Blog::getDate).reversed());
    }

    /**
     * Use the H3/H4 headings in the release notes to auto-generate a summary.
     */
    private String getSummary(ReleasesMetadata.ReleaseSource source, Versions.Version v) {
        File file = new File("cache/releases/" + source.getId() + "/" + v.getVersion() + "/release-notes.html");
        if (!file.exists()) {
            return null;
        }
        try {
            Document document = Jsoup.parse(file);
            Elements headings = document.select("h3,h4");
            StringBuilder sb = new StringBuilder();
            int found = 0;
            for (int i = 0; i < headings.size() && found < 4; i++) {
                Element element = headings.get(i);
                // if the heading has subheadings, ignore the heading
                if (element.nameIs("h3") && element.nextElementSibling() != null && !element.nextElementSibling().select("h4").isEmpty()) {
                    continue;
                }
                if (sb.length() > 0) {
                    sb.append(" * ");
                }
                sb.append(element.text());
                ++ found;
            }
            return sb.toString();
        } catch (IOException e) {
            throw new RuntimeException("Unable to read file " + file, e);
        }
    }

    public static class Blog {

        private BlogFormat format;

        private final Date date;

        private final String name;

        private final String title;

        private final String summary;

        private final String preview;

        private final String author;

        private final String category;

        private final boolean release;

        private final boolean publish;

        private String template;

        private final Map<String, Object> map = new HashMap<>();

        public Blog(BlogFormat format, Date date, String name, String title, String summary, String preview, String author, String category, boolean publish, boolean release, String template) {
            this.format = format;
            this.date = date;
            this.name = name;
            this.title = title;
            this.summary = summary;
            this.preview = preview;
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

        public String getPreview() {
            return (preview == null) ? null : "blog/" + getPath()  + "/" + preview;
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
