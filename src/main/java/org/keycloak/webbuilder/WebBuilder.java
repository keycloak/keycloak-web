package org.keycloak.webbuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class WebBuilder {

    public static final DateFormat dateIn = new SimpleDateFormat("yyyy-MM-dd");
    public static final DateFormat dateYear = new SimpleDateFormat("yyyy");
    public static final DateFormat dateMonth = new SimpleDateFormat("MM");

    private static final ObjectMapper mapper = new ObjectMapper();

    private final Configuration cfg;

    private boolean publish = System.getProperties().containsKey("publish");

    private final File webSrcDir;
    private final File pagesDir;
    private final File resourcesDir;
    private final File staticDir;
    private final File versionsDir;
    private final File extensionsDir;
    private final File newsDir;
    private final File blogDir;
    private final File targetDir;

    private Map<String, Object> map;
    private List<Version> versions;
    private List<Version> versionsShorter;
    private List<Extension> extensions;
    private List<News> news;
    private List<Blog> blogs;

    public static void main(String[] args) throws Exception {
        WebBuilder builder = new WebBuilder(new File(System.getProperty("user.dir")));

        builder.clean();
        System.out.println();

        builder.copyAssets();
        System.out.println();

        builder.createPages();
        System.out.println();

        System.out.println("Built:              " + new File(builder.targetDir, "index.html").toURI().toString());
        System.out.println();
    }

    public WebBuilder(File rootDir) throws Exception {
        webSrcDir = rootDir;

        System.out.println("Building from:      " + webSrcDir.getAbsolutePath());

        pagesDir = new File(webSrcDir, "pages");
        resourcesDir = new File(webSrcDir, "resources");
        staticDir = new File(webSrcDir, "static");
        versionsDir = new File(webSrcDir, "versions");
        extensionsDir = new File(webSrcDir, "extensions");
        newsDir = new File(webSrcDir, "news");
        blogDir = new File(webSrcDir, "blog");
        targetDir = new File(rootDir, "target/web").getAbsoluteFile();

        cfg = new Configuration(Configuration.VERSION_2_3_24);
        cfg.setDirectoryForTemplateLoading(webSrcDir);
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);

        loadConfig();
    }

    public void clean() throws IOException {
        if (targetDir.isDirectory()) {
            FileUtils.deleteDirectory(targetDir);
        }

        System.out.println("Removed previous build");
    }

    private void loadConfig() throws Exception {
        map = new HashMap<>();

        Config config = mapper.readValue(new File(webSrcDir,"/config.json"), Config.class);
        if (!publish) {
            config.getUrls().setHome(targetDir.toURI().toString());
        }


        map.put("root", "");
        map.put("config", config);
        map.put("home", config.getUrls().getHome());
        map.put("blogImages", config.getUrls().getHome() + "/resources/images/blog");

        File[] versionFiles = versionsDir.listFiles((dir, name) -> {
            return name.endsWith(".json");
        });
        versions = new LinkedList<>();
        for (File versionFile : versionFiles) {
            versions.add(mapper.readValue(versionFile, Version.class));
        }
        Collections.sort(versions);
        map.put("versions", versions);

        File[] extensionFiles = extensionsDir.listFiles((dir, name) -> {
            return name.endsWith(".json");
        });
        extensions = new LinkedList<>();
        for (File extensionFile : extensionFiles) {
            extensions.add(mapper.readValue(extensionFile, Extension.class));
        }
        Collections.sort(extensions);
        map.put("extensions", extensions);

        versionsShorter = getVersionsShorter(versions);
        map.put("versionsShorter", versionsShorter);

        versions.get(0).setLatest(true);

        map.put("version", versions.get(0));

        loadNews(config);
        loadBlog(config);

        System.out.println("Target directory:   " + targetDir.getAbsolutePath());
        System.out.println();
    }

    private void loadNews(Config config) throws IOException, ParseException {
        news = new LinkedList<>();

        File[] newsFiles = newsDir.listFiles((dir, name) -> name.endsWith(".json"));
        if (newsFiles != null) {
            for (int i = 0; i < newsFiles.length && i < config.getMaxNews(); i++) {
                News news = mapper.readValue(newsFiles[i], News.class);
                news.setDate(dateIn.parse(newsFiles[i].getName()));
                this.news.add(news);
            }
        }

        for (Version v : versions) {
            if (v.getDate() != null) {
                News news = new News();
                news.setDate(v.getDate());
                news.setTitle("Keycloak " + v.getVersion() + " released");
                news.setLink("downloads.html");
                this.news.add(news);
            }
        }

        news.sort(Comparator.comparing(News::getDate).reversed());
        news = news.subList(0, config.getMaxNews());
        map.put("news", news);
    }

    private void loadBlog(Config config) throws Exception {
        blogs = new LinkedList<>();

        File[] blogFiles = blogDir.listFiles((dir, name) -> name.endsWith(".ftl"));
        if (blogFiles != null) {
            for (File f : blogFiles) {
                BufferedReader br = new BufferedReader(new FileReader(f));
                String l = br.readLine();
                if (!l.trim().equals("<#--")) {
                    throw new Exception("Invalid starting line " + l);
                }
                Properties p = new Properties();
                for (l = br.readLine(); l != null && !l.trim().equals("-->"); l = br.readLine()) {
                    String[] split = l.split("=");
                    p.put(split[0].trim(), split[1].trim());
                }

                Blog blog = new Blog(dateIn.parse(p.getProperty("date")), f.getName().replace(".html", "") , p.getProperty("title"), p.getProperty("author"), p.getProperty("category"), Boolean.parseBoolean(p.getProperty("publish")), false, "blog/" + f.getName());
                if (blog.isPublish() || !publish) {
                    blogs.add(blog);
                }
            }
        }

        for (Version v : versions) {
            Blog blog = new Blog(v.getDate(), "keycloak-" + v.getVersion().replace(".", "") + "-released", "Keycloak " + v.getVersion() + " released", null, "Keycloak Release", true, true, "templates/blog-release.ftl");
            blog.getMap().put("version", v);
            blogs.add(blog);
        }


        blogs.sort(Comparator.comparing(Blog::getDate).reversed());
        map.put("blogs", blogs);
    }

    public void copyAssets() throws Exception {
        System.out.println("Copying resources");

        File targetResourcesDir = new File(targetDir, "resources");

        FileUtils.copyDirectory(resourcesDir, targetResourcesDir);
        FileUtils.copyDirectory(new File(blogDir, "images"), new File(new File(targetResourcesDir, "images"), "blog"));

        FileUtils.copyDirectory(staticDir, targetDir);
    }

    public void createPages() throws Exception {
        map.put("archive", false);

        System.out.println("Creating pages");
        System.out.println();

        File[] pageFiles = pagesDir.listFiles((dir, name) -> {
            return name.endsWith(".ftl");
        });

        for (File pageFile : pageFiles) {
            writeFile(map, "pages/" + pageFile.getName(), targetDir, pageFile.getName().replace(".ftl", ".html"));
        }

        map.put("root", "../");

        map.put("archive", true);

        File archiveDir = new File(targetDir, "archive");
        if (!archiveDir.isDirectory()) {
            archiveDir.mkdir();
        }

        // Download archive
        for (Version version : versions) {
            HashMap<String, Object> versionMap = new HashMap<>(map);
            versionMap.put("version", version);

            writeFile(versionMap, "templates/downloads-archive-version.ftl", archiveDir, "downloads-" + version.getVersionShort() + ".html");
        }

        // Documentation archive
        for (Version version : versionsShorter) {
            HashMap<String, Object> versionMap = new HashMap<>(map);
            versionMap.put("version", version);

            writeFile(versionMap, "templates/documentation-archive-version.ftl", archiveDir, "documentation-" + version.getVersionShorter() + ".html");
        }

        for (Blog blog : blogs) {
            if (blog.isPublish()) {
                HashMap<String, Object> blogMap = new HashMap<>(map);
                blogMap.putAll(blog.getMap());
                blogMap.put("root", "../../");
                blogMap.put("blog", blog);

                File dir = new File(targetDir, blog.getPath());
                dir.mkdirs();

                writeFile(blogMap, "templates/blog-entry.ftl", dir, blog.getFilename());
            }
        }

        writeFile(map, "templates/rss.ftl", targetDir, "rss.xml");
    }

    private void writeFile(Map<String, Object> map, String template, File targetDir, String output) throws Exception {
        Template downloadTemplate = cfg.getTemplate(template);

        Writer out = new FileWriter(new File(targetDir, output));
        downloadTemplate.process(map, out);

        System.out.println("\t- created: " + output);
    }

    private List<Version> getVersionsShorter(List<Version> versions) {
        Map<String, Version> map = new HashMap<>();
        for (Version v : versions) {
            if (!map.containsKey(v.getVersionShorter())) {
                map.put(v.getVersionShorter(), v);
            }
        }
        LinkedList<Version> versionsShorter = new LinkedList<>(map.values());
        Collections.sort(versionsShorter);
        return versionsShorter;
    }

}
