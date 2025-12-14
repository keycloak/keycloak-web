package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;
import org.keycloak.webbuilder.utils.FreeMarker;
import org.keycloak.webbuilder.utils.JsonParser;
import org.keycloak.webbuilder.utils.YamlParser;

import java.io.File;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

public class Context {

    private final File webSrcDir;
    private final File pagesDir;
    private final File resourcesDir;
    private final File staticDir;
    private final File versionsDir;
    private final File extensionsDir;
    private final File casestudiesDir;
    private final File newsDir;
    private final File blogDir;
    private final File guidesDir;
    private final File targetDir;
    private final File tmpDir;
    private final File cacheDir;

    private Config config;
    private Links links;
    private ReleasesMetadata releasesMetadata;
    private GuidesMetadata guidesMetadata;
    private Map<String, Versions> versionsBySource;
    private Extensions extensions;
    private Casestudies casestudies;
    private Translations translations;
    private ProjectStars projectStars;
    private Blogs blogs;
    private Guides guides;
    private News news;
    private Sitemap sitemap;

    private FreeMarker freeMarker;
    private AsciiDoctor asciiDoctor;

    public Context(File rootDir) throws Exception {
        freeMarker = new FreeMarker(rootDir);
        asciiDoctor = new AsciiDoctor(rootDir);

        webSrcDir = rootDir;

        pagesDir = new File(webSrcDir, "pages");
        resourcesDir = new File(webSrcDir, "resources");
        staticDir = new File(webSrcDir, "static");
        versionsDir = new File(webSrcDir, "versions");
        extensionsDir = new File(webSrcDir, "extensions");
        casestudiesDir = new File(webSrcDir, "casestudies");
        newsDir = new File(webSrcDir, "news");
        blogDir = new File(webSrcDir, "blog");
        guidesDir = new File(webSrcDir, "guides");
        targetDir = new File(rootDir, "target/web").getAbsoluteFile();
        tmpDir = new File(rootDir, "target/tmp").getAbsoluteFile();
        cacheDir = new File(rootDir, "cache").getAbsoluteFile();
        sitemap = new Sitemap(rootDir);

        init();
    }

    public void init() throws Exception {
        config = loadConfig();
        links = new Links(config);
        releasesMetadata = new YamlParser().read(new File(getWebSrcDir(),"/releases.yaml"), ReleasesMetadata.class);
        guidesMetadata = new YamlParser().read(new File(getWebSrcDir(),"/guides.yaml"), GuidesMetadata.class);
        versionsBySource = new HashMap<>();

        for (ReleasesMetadata.ReleaseSource source : releasesMetadata.getSources()) {
            String sourceId = source.getId();
            File directory = new File(versionsDir, sourceId);
            Versions versions = new Versions(directory);

            versionsBySource.put(sourceId, versions);
        }

        extensions = new Extensions(extensionsDir);
        casestudies = new Casestudies(casestudiesDir);
        translations = new Translations();
        projectStars = new ProjectStars();
        blogs = new Blogs(this);
        guides = new Guides(guidesMetadata, getWebSrcDir().toPath(), asciiDoctor);
        news = new News(newsDir, blogs, config, links);

        freeMarker.init(this);
        asciiDoctor.init(this);
        sitemap.init(this);
        projectStars.init(this);
    }

    public void close() {
        asciiDoctor.close();
        sitemap.close();
    }

    private Config loadConfig() {
        Config config = JsonParser.read(new File(getWebSrcDir(),"/config.json"), Config.class);
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
        return versionsFor(ReleasesMetadata.MAIN_PROJECT_ID);
    }

    public Versions versionsFor(String sourceId) {
        Versions versions = versionsBySource.get(sourceId);

        if (versions != null) {
            return versions;
        }

        throw new IllegalArgumentException(String.format("No versions available for %s", sourceId));
    }

    public Extensions extensions() {
        return extensions;
    }

    public Casestudies casestudies() {
        return casestudies;
    }

    public Translations translations() {
        return translations;
    }

    public ProjectStars projectStars() {
        return projectStars;
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

    public FreeMarker freeMarker() {
        return freeMarker;
    }

    public AsciiDoctor asciiDoctor() {
        return asciiDoctor;
    }

    public Sitemap sitemap() { return sitemap; }

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

    public ReleasesMetadata getReleasesMetadata() {
        return releasesMetadata;
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
