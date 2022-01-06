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

            String template = guide.getTemplate();

            String guideInclude = "guide-" + guide.getName() + ".ftl";
            context.asciiDoctor().writeFile(attributes, new File(context.getGuidesDir(), guide.getTemplate()), context.getTmpDir(), guideInclude);
            guide.setTemplate("target/tmp/" + guideInclude);

            File target = new File(context.getTargetDir(), template).getParentFile();
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
