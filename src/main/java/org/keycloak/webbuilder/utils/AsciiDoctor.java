package org.keycloak.webbuilder.utils;

import org.apache.commons.io.IOUtils;
import org.asciidoctor.Asciidoctor;
import org.asciidoctor.AttributesBuilder;
import org.asciidoctor.OptionsBuilder;
import org.asciidoctor.SafeMode;
import org.asciidoctor.ast.Document;
import org.keycloak.webbuilder.Context;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Writer;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class AsciiDoctor {

    private Asciidoctor asciidoctor;
    private File rootDir;
    private Map<String, Object> globalAttributes;

    public AsciiDoctor(File rootDir) {
        this.rootDir = rootDir;
        this.asciidoctor = Asciidoctor.Factory.create();
    }

    public void writeFile(Map<String, Object> attr, URL url, File targetDir, String output) throws Exception {
        writeFile(rootDir, attr, new InputStreamReader(url.openStream()), new FileWriter(new File(targetDir, output)));
    }

    public void writeFile(Map<String, Object> attr, File file, File targetDir, String output) throws Exception {
        writeFile(file.getParentFile(), attr, new FileReader(file), new FileWriter(new File(targetDir, output)));
    }

    private void writeFile(File baseDir, Map<String, Object> attr, Reader reader, Writer writer) throws Exception {
        Map<String, Object> a = new HashMap<>(globalAttributes);
        a.putAll(attr);

        Map<String, Object> options = OptionsBuilder.options()
                .baseDir(baseDir)
                .docType("article")
                .headerFooter(false)
                .attributes(a)
                .safe(SafeMode.UNSAFE)
                .asMap();

        asciidoctor.convert(reader, writer, options);

        writer.close();
    }

    public Map<String, Object> parseAttributes(File file) throws IOException {
        return parseAttributes(file, null);
    }

    public Map<String, Object> parseAttributes(File file, Map<String, Object> attributes) throws IOException {
        return parseAttributes(IOUtils.toString(new FileInputStream(file), StandardCharsets.UTF_8), attributes);
    }

    public Map<String, Object> parseAttributes(URL url, Map<String, Object> attributes) throws IOException {
        return parseAttributes(IOUtils.toString(url, StandardCharsets.UTF_8), attributes);
    }

    private Map<String, Object> parseAttributes(String content, Map<String, Object> attributes) {
        AttributesBuilder ab = AttributesBuilder.attributes().backend("html5");
        if (attributes != null) {
            ab.attributes(attributes);
        }

        Map<String, Object> options = OptionsBuilder.options()
                .inPlace(true)
                .attributes(ab.asMap())
                .asMap();

        Document document = asciidoctor.load(content, options);
        return document.getAttributes();
    }

    public void init(Context contex) {
        globalAttributes = new HashMap<>();
        globalAttributes.put("version", contex.versions().getLatest().getVersion());
    }

    public void close() {
        asciidoctor.shutdown();
    }

}