package org.keycloak.webbuilder.utils;

import freemarker.cache.NullCacheStorage;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.keycloak.webbuilder.Context;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

public class FreeMarker {

    private Configuration cfg;
    private Map<String, Object> globalAttributes;
    private boolean isPublish;
    private File targetDir;

    public FreeMarker(File webSrcDir) throws IOException {
        cfg = new Configuration(Configuration.VERSION_2_3_24);
        cfg.setDirectoryForTemplateLoading(webSrcDir);
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setCacheStorage(new NullCacheStorage());
    }

    public Map<String, Object> parseAttributes(File file) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(file));
        String l = br.readLine();
        if (!l.trim().equals("<#--")) {
            throw new IOException("Invalid starting line " + l);
        }
        Map<String, Object> attributes = new HashMap<>();
        for (l = br.readLine(); l != null && !l.trim().equals("-->"); l = br.readLine()) {
            String[] split = l.split("=");
            attributes.put(split[0].trim(), split[1].trim());
        }
        return attributes;
    }

    public void writeFile(String template, File targetDir, String output) throws Exception {
        writeFile(null, template, targetDir, output);
    }

    public void writeFile(Map<String, Object> attr, String template, File targetDir, String output) throws Exception {
        Map<String, Object> attributes = new HashMap<>();
        attributes.putAll(globalAttributes);
        if (attr != null) {
            attributes.putAll(attr);
        }
        String canonical = new File(targetDir, output).toURI().toString().substring(this.targetDir.toURI().toString().length());
        if (isPublish) {
            canonical = canonical.replaceAll("\\.html$", "");
            canonical = canonical.replaceAll("/index$", "");
            canonical = canonical.replaceAll("^index$", "");
        }
        attributes.put("canonical", attributes.get("root") + canonical);

        Template downloadTemplate = cfg.getTemplate(template);

        Writer out = new FileWriter(new File(targetDir, output));
        downloadTemplate.process(attributes, out);
    }

    public void init(Context context) {
        globalAttributes = new HashMap<>();

        String root = context.config().isPublish() ? context.config().getUrls().getHome() : context.getTargetDir().toURI().toString();
        if (!root.endsWith("/")) {
            root += "/";
        }
        globalAttributes.put("root", root);

        globalAttributes.put("config", context.config());
        globalAttributes.put("home", context.config().getUrls().getHome());

        globalAttributes.put("versions", context.versions());
        globalAttributes.put("versionsMajorMinor", context.versions().getMajorMinor());

        globalAttributes.put("extensions", context.extensions());

        globalAttributes.put("version", context.versions().getLatest());

        globalAttributes.put("news", context.news());
        globalAttributes.put("blogs", context.blogs());
        globalAttributes.put("guides", context.guides());
        globalAttributes.put("blogImages", context.config().getUrls().getHome() + "/resources/images/blog");

        globalAttributes.put("archive", false);

        globalAttributes.put("links", context.getLinks());

        isPublish = context.config().isPublish();
        targetDir = context.getTargetDir();
    }

}
