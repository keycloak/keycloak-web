package org.keycloak.webbuilder.builders;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.keycloak.webbuilder.ReleasesMetadata;
import org.keycloak.webbuilder.Versions;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.StringWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReleaseNotesBuilder extends AbstractBuilder {

    @Override
    protected String getTitle() {
        return "Release Notes";
    }

    @Override
    protected void build() throws Exception {
        ReleasesMetadata metadata = context.getReleasesMetadata();

        for (ReleasesMetadata.ReleaseSource source : metadata.getSources()) {
            buildForSource(source);
        }
    }

    private void buildForSource(ReleasesMetadata.ReleaseSource source) throws Exception {
        File releasesCache = new File(context.getCacheDir(), "releases/" + source.getId());
        Versions versions = context.versionsFor(source.getId());

        for (Versions.Version v : versions) {
            try {
                File releaseCacheDir = new File(releasesCache, v.getVersion());
                releaseCacheDir.mkdirs();

                File releaseNotesFile = new File(releaseCacheDir, "release-notes.html");
                File releaseNotesMissingFile = new File(releaseCacheDir, "release-notes.empty");

                if (releaseNotesFile.isFile()) {
                    printStep("exists", source.getId() + " " + v.getVersion());
                } else if (releaseNotesMissingFile.isFile()) {
                    printStep("missing",  source.getId() + " " + v.getVersion());
                } else {
                    Map<String, Object> attributes = new HashMap<>();

                    attributes.put("project_buildType", "latest");
                    attributes.put("leveloffset", "2");
                    attributes.put("fragment", "yes");

                    List<String> attributeSources = source.getAttributeSources();

                    if (attributeSources != null) {
                        for (String attributeSource : source.getAttributeSources()) {
                            URL templateUrl = buildTemplateUrl(source, v, attributeSource);
                            Map<String, Object> templateAttributes = context.asciiDoctor().parseAttributes(templateUrl, attributes);
                            attributes.putAll(templateAttributes);
                        }
                    }

                    URL releaseNotesURL = buildTemplateUrl(source, v, source.getReleaseNotes());

                    try {
                        context.asciiDoctor().writeFile(attributes, releaseNotesURL, releaseNotesFile.getParentFile(), releaseNotesFile.getName());
                        printStep("created", source.getId() + " " + v.getVersion());
                    } catch (FileNotFoundException e) {
                        printStep("notfound",  source.getId() + " " + v.getVersion());
                        releaseNotesMissingFile.createNewFile();
                    }
                }

                if (releaseNotesFile.isFile()) {
                    v.setReleaseNotes("cache/releases/"  + source.getId() + "/" + v.getVersion() + "/release-notes.html");
                }
            } catch (Exception e) {
                printStep("error", source.getId() + " " + v.getVersion() + " (" + e.getClass().getSimpleName() + ")");
            }
        }
    }

    private URL buildTemplateUrl(ReleasesMetadata.ReleaseSource source, Versions.Version version, String pathTemplate) throws Exception {
        Configuration configuration = new Configuration(Configuration.VERSION_2_3_31);
        Template template = new Template("template", pathTemplate, configuration);
        StringWriter writer = new StringWriter();
        Map<String, Object> attributes = new HashMap<>();

        attributes.put("version", version);
        template.process(attributes, writer);

        String path = writer.toString();

        return new URL(String.format("https://raw.githubusercontent.com/%s/%s", source.getRepo(), path));
    }
}
