package org.keycloak.webbuilder.builders;

public class RssFeedBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        context.freeMarker().writeFile("templates/rss.ftl", context.getTargetDir(), "rss.xml");
        printStep("created", "rss.xml");
    }

    @Override
    protected String getTitle() {
        return "RSS Feed";
    }

}
