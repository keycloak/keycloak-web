package org.keycloak.webbuilder;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.asciidoctor.Asciidoctor;
import org.asciidoctor.AttributesBuilder;
import org.asciidoctor.OptionsBuilder;
import org.asciidoctor.ast.Document;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

public class ReleaseNotes {

    private static final String BASE_URL = "https://raw.githubusercontent.com/keycloak/keycloak-documentation/master/";
    private static final String DOCUMENT_ATTRIBUTES_URL = BASE_URL + "topics/templates/document-attributes-community.adoc";

    private Asciidoctor asciidoctor;

    private Map<String, Object> attributes;

    public ReleaseNotes() throws IOException {
        asciidoctor = Asciidoctor.Factory.create();
        attributes = loadAttributes();
    }

    public void close() {
        asciidoctor.shutdown();
    }

    public void createReleaseNotes(File webSrcDir, List<Version> versions) {
        File releaseNotesDir = new File(webSrcDir, "target/release-notes");
        if (!releaseNotesDir.isDirectory()) {
            releaseNotesDir.mkdir();
        }

        for (Version v : versions) {
            try {
                String fileName = v.getVersion().replace(".", "_");
                URL url = new URL(BASE_URL + "release_notes/topics/" + fileName + ".adoc");

                Map<String, Object> options = OptionsBuilder.options()
                        .docType("article")
                        .headerFooter(false)
                        .attributes(attributes)
                        .asMap();

                String html = asciidoctor.convert(IOUtils.toString(url, StandardCharsets.UTF_8), options);

                File f = new File(releaseNotesDir, fileName + ".ftl");

                FileUtils.write(f, html, StandardCharsets.UTF_8);

                v.setReleaseNotes("../target/release-notes/" + fileName + ".ftl");

                System.out.println("\t- created: " + v.getVersion());
            } catch (FileNotFoundException e) {
                System.out.println("\t- missing: " +  v.getVersion());
            } catch (Exception e) {
                System.out.println("\t- error:   " +  v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

    private Map<String, Object> loadAttributes() throws IOException {
        Map<String, Object> options = OptionsBuilder.options()
                .inPlace(true)
                .attributes(
                        AttributesBuilder.attributes()
                                .backend("html5")
                                .attribute("project_buildType", "latest")
                                .attribute("leveloffset", "1")
                                .asMap())
                .asMap();

        Document document = asciidoctor.load(IOUtils.toString(new URL(DOCUMENT_ATTRIBUTES_URL), StandardCharsets.UTF_8), options);
        return document.getAttributes();
    }

}
