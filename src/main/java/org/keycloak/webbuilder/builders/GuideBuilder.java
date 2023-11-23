package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Guides;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class GuideBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        Map<String, Object> attributes = new HashMap<>();
        setCommonAttributes(attributes);

        for (Guides.Guide guide : context.guides().getGuides()) {
            buildGuide(attributes, guide);
        }
    }

    private void buildGuide(Map<String, Object> attributes, Guides.Guide guide) throws Exception {
        if (guide.isExternal()) {
            return;
        }
        attributes.put("guide", guide);

        File dir = new File(context.getTargetDir(), "guides");
        dir.mkdirs();

        context.getTmpDir().mkdirs();

        context.asciiDoctor().writeFile(attributes, guide.getSource(), context.getTmpDir(), guide.getTemplate());

        File target = new File(context.getTargetDir(), guide.getCategory().getId());
        target.mkdirs();

        context.freeMarker().writeFile(attributes, "templates/guide-entry.ftl", target, guide.getName() + ".html");
        printStep("created", guide.getTemplate());
    }

    private void setCommonAttributes(Map<String, Object> attributes) {
        attributes.put("imagesdir", context.getLinks().getRoot() + "/resources/images/guides");
        attributes.put("leveloffset", "0");
        attributes.put("fragment", "yes");
        attributes.put("notitle", "yes");
        attributes.put("icons", "font");

        setGuideLinkAttributes(attributes);
    }

    private void setGuideLinkAttributes(Map<String, Object> attributes) {
        for (Guides.Guide guide : context.guides().getGuides()) {
            String linkKeyPrefix = "links_" + guide.getCategory().getId() + "_" + guide.getName();
            attributes.put(linkKeyPrefix + "_name", guide.getTitle());
            attributes.put(linkKeyPrefix + "_url", context.getLinks().get(guide));
        }
    }

    @Override
    protected String getTitle() {
        return "Guides";
    }
}
