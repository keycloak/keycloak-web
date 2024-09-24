package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;
import org.keycloak.webbuilder.utils.FreeMarker;
import org.keycloak.webbuilder.utils.JsonParser;
import org.keycloak.webbuilder.utils.YamlParser;

import java.io.File;

public class Context {

    private Links links;

    private final File webSrcDir;
    private final File pagesDir;
    private final File resourcesDir;
    private final File staticDir;
    private final File versionsDir;
    private final File extensionsDir;
    private final File newsDir;
    private final File blogDir;
    private final File guidesDir;
    private final File targetDir;
    private final File tmpDir;
    private final File cacheDir;

    private Config config;
    private Versions versions;
    private Extensions extensions;
    private Blogs blogs;
    private Guides guides;
    private GuidesMetadata guidesMetadata;
    private News news;

    private FreeMarker freeMarker;
    private AsciiDoctor asciiDoctor;
    private JsonParser jsonParser;

    public Context(File rootDir) throws Exception {
        jsonParser = new JsonParser();
        freeMarker = new FreeMarker(rootDir);
        asciiDoctor = new AsciiDoctor(rootDir);

        webSrcDir = rootDir;

        pagesDir = new File(webSrcDir, "pages");
        resourcesDir = new File(webSrcDir, "resources");
        staticDir = new File(webSrcDir, "static");
        versionsDir = new File(webSrcDir, "versions");
        extensionsDir = new File(webSrcDir, "extensions");
        newsDir = new File(webSrcDir, "news");
        blogDir = new File(webSrcDir, "blog");
        guidesDir = new File(webSrcDir, "guides");
        targetDir = new File(rootDir, "target/web").getAbsoluteFile();
        tmpDir = new File(rootDir, "target/tmp").getAbsoluteFile();
        cacheDir = new File(rootDir, "cache").getAbsoluteFile();

        init();
    }

    public void init() throws Exception {
        config = loadConfig();
        links = new Links(config);

        versions = new Versions(versionsDir, jsonParser);
        extensions = new Extensions(extensionsDir, jsonParser);
        blogs = new Blogs(blogDir, versions, config, freeMarker, asciiDoctor);
        guidesMetadata = new YamlParser().read(new File(getWebSrcDir(),"/guides.yaml"), GuidesMetadata.class);
        guides = new Guides(guidesMetadata, tmpDir, getWebSrcDir(), asciiDoctor);
        news = new News(newsDir, blogs, jsonParser, config);

        freeMarker.init(this);
        asciiDoctor.init(this);
    }

    public void close() {
        asciiDoctor.close();
    }

    private Config loadConfig() {
        Config config = jsonParser.read(new File(getWebSrcDir(),"/config.json"), Config.class);
        config.setPublish(System.getProperties().containsKey("publish"));

        if (System.getenv().containsKey("KC_URL")) {
            config.getUrls().setHome(System.getenv("KC_URL"));
        } else if (!config.isPublish()) {
            config.getUrls().setHome(getTargetDir().toURI().toString());
        }
        return config;
    }

    public Config config() {
        return config;
    }

    public Versions versions() {
        return versions;
    }

    public Extensions extensions() {
        return extensions;
    }

    public Blogs blogs() {
        return blogs;
    }

    public Guides guides() {
        return guides;
    }

    public News news() {
        return news;
    }

    public JsonParser json() {
        return jsonParser;
    }

    public FreeMarker freeMarker() {
        return freeMarker;
    }

    public AsciiDoctor asciiDoctor() {
        return asciiDoctor;
    }

    public Links getLinks() {
        return links;
    }

    public File getWebSrcDir() {
        return webSrcDir;
    }

    public File getPagesDir() {
        return pagesDir;
    }

    public File getResourcesDir() {
        return resourcesDir;
    }

    public File getStaticDir() {
        return staticDir;
    }

    public File getVersionsDir() {
        return versionsDir;
    }

    public File getExtensionsDir() {
        return extensionsDir;
    }

    public File getNewsDir() {
        return newsDir;
    }

    public File getBlogDir() {
        return blogDir;
    }

    public GuidesMetadata getGuidesMetadata() {
        return guidesMetadata;
    }

    public File getGuidesDir() {
        return guidesDir;
    }

    public File getTargetDir() {
        return targetDir;
    }

    public File getTmpDir() {
        return tmpDir;
    }

    public File getCacheDir() {
        return cacheDir;
    }
}
