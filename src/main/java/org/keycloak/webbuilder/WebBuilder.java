package org.keycloak.webbuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class WebBuilder {

    private static final DateFormat dateIn = new SimpleDateFormat("yyyy-MM-dd");
    private static final DateFormat dateOut = new SimpleDateFormat("dd MMM");

    private final Configuration cfg;
    private final File pagesDir;
    private final File resourcesDir;
    private final File versionsDir;
    private final File newsDir;
    private final File targetDir;
    private Map<String, Object> map;
    private List<Version> versions;
    private List<Version> versionsShorter;
    private List<News> news;

    public static void main(String[] args) throws Exception {
        WebBuilder builder = new WebBuilder(new File(System.getProperty("user.dir")));

        builder.clean();
        System.out.println("");
        builder.copyAssets();
        System.out.println("");
        builder.createPages();
        System.out.println("");
    }

    public WebBuilder(File rootDir) throws Exception {
        File webSrcDir = new File(rootDir, "src/main/resources");

        pagesDir = new File(webSrcDir, "pages");
        resourcesDir = new File(webSrcDir, "resources");
        versionsDir = new File(webSrcDir, "versions");
        newsDir = new File(webSrcDir, "news");
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

        ObjectMapper mapper = new ObjectMapper();
        Config config = mapper.readValue(getClass().getResourceAsStream("/config.json"), Config.class);
        map.put("root", "");
        map.put("config", config);

        File[] versionFiles = versionsDir.listFiles((dir, name) -> {
            return name.endsWith(".json");
        });
        versions = new LinkedList<>();
        for (File versionFile : versionFiles) {
            versions.add(mapper.readValue(versionFile, Version.class));
        }
        Collections.sort(versions);
        map.put("versions", versions);

        versionsShorter = getVersionsShorter(versions);
        map.put("versionsShorter", versionsShorter);

        versions.get(0).setLatest(true);

        map.put("version", versions.get(0));

        File[] newsFiles = newsDir.listFiles((dir, name) -> {
            return name.endsWith(".json");
        });
        Arrays.sort(newsFiles, (o1, o2) -> o2.getName().compareTo(o1.getName()));
        news = new LinkedList<>();
        for (int i = 0; i < newsFiles.length && i < config.getMaxNews(); i++) {
            News news = mapper.readValue(newsFiles[i], News.class);

            Date date = dateIn.parse(newsFiles[i].getName());
            news.setDate(dateOut.format(date));

            this.news.add(news);
        }
        map.put("news", news);

        System.out.println("Target directory: " + targetDir.getAbsolutePath());
        System.out.println("");
    }

    public void copyAssets() throws Exception {
        System.out.println("Copying resources");
        FileUtils.copyDirectory(resourcesDir, new File(targetDir, "resources"));
    }

    public void createPages() throws Exception {
        map.put("archive", false);

        System.out.println("Creating pages");
        System.out.println("");

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
