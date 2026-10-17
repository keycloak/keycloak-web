package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Guides;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class GuideBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        for (File directory : context.getTargetDir().listFiles(f -> f.isDirectory() && f.getName().matches("\\d+\\.\\d+"))) {
            FileUtils.deleteDirectory(directory);
        }
        Map<String, Object> attributes = new HashMap<>();
        setCommonAttributes(attributes);

        for (Guides.Guide guide : context.guides().getGuides()) {
            buildGuide(new HashMap<>(attributes), guide);
        }
    }

    private void buildGuide(Map<String, Object> attributes, Guides.Guide guide) throws Exception {
        if (guide.isExternal()) {
            return;
        }
        attributes.put("guide", guide);
        attributes.put("guideVersion", guide.getVersion());
        String imagePrefix = guide.getVersion().getPrefix();
        attributes.put("imagesdir", context.getLinks().getRoot() + "/resources/images/guides"
                + (imagePrefix.isEmpty() ? "" : "/" + imagePrefix.substring(0, imagePrefix.length() - 1)));
        if (guide.getGuideSource().getId().equals("keycloak")) {
            attributes.put("version", guide.getVersion().getVersion());
            attributes.put("majorMinorVersion", guide.getVersion().getMinor());
        }
        if (guide.getVersion().isArchived()) {
            attributes.put("project_doc_base_url", "https://www.keycloak.org/docs/" + guide.getVersion().getVersion());
            attributes.put("securing_apps_link", context.getLinks().getGuides() + "#securing-apps");
        }

        setGuideLinkAttributes(attributes, guide);

        context.getTmpDir().mkdirs();

        context.asciiDoctor().writeFile(attributes, guide.getSource().toFile(), context.getTmpDir(), "guide.html");

        File target = new File(context.getTargetDir(), guide.getVersion().getPrefix() + guide.getMetadata().getId());

        String file = guide.getName() + ".html";
        if (guide.hasParent()) {
            target = new File(target, guide.getParent());
        }
        target.mkdirs();

        context.freeMarker().writeFile(attributes, "templates/guide-entry.ftl", target, file);
        context.sitemap().addFile(new File(target, file));

        printStep("created", guide.getTemplate());
    }

    private void setCommonAttributes(Map<String, Object> attributes) {
        // making this soft-set allows using level offsets when including content in the guides
        attributes.put("leveloffset", "0@");

        attributes.put("fragment", "yes");
        attributes.put("notitle", "yes");
        attributes.put("icons", "font");
        attributes.put("sectanchors", "yes");
    }

    private void setGuideLinkAttributes(Map<String, Object> attributes, Guides.Guide current) {
        for (Guides.Guide guide : context.guides().getGuides()) {
            boolean sameVersion = guide.getVersion() == current.getVersion();
            boolean independentSource = current.getVersion().isArchived()
                    && guide.getVersion() == context.guideVersions().getCurrent()
                    && !guide.getGuideSource().getId().equals("keycloak");
            if (sameVersion || independentSource) {
                String linkKeyPrefix = "links_" + guide.getMetadata().getId() + "_" + guide.getFQName().replaceAll("/", "-");
                attributes.put(linkKeyPrefix + "_name", guide.getTitle());
                attributes.put(linkKeyPrefix + "_url", context.getLinks().get(guide));
            }
        }
    }

    @Override
    protected String getTitle() {
        return "Guides";
    }
}
