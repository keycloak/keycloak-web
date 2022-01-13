package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Guides;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class GuideBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        for (Guides.Guide guide : context.guides().getGuides()) {
            if (guide.isExternal()) {
                continue;
            }
            Map<String, Object> attributes = new HashMap<>();
            attributes.put("guide", guide);
            attributes.put("guideImages", context.getLinks().getRoot() + "/resources/images/guides");

            File dir = new File(context.getTargetDir(), "guides");
            dir.mkdirs();

            context.getTmpDir().mkdirs();

            context.asciiDoctor().writeFile(attributes, guide.getSource(), context.getTmpDir(), guide.getTemplate());

            File target = new File(context.getTargetDir(), guide.getCategory().getId());
            target.mkdirs();

            context.freeMarker().writeFile(attributes, "templates/guide-entry.ftl", target, guide.getName() + ".html");
            printStep("created", guide.getTemplate());
        }

    }

    @Override
    protected String getTitle() {
        return "Guides";
    }
}
