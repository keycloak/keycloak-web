package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Guides {

    private List<Guide> guides = new LinkedList<>();

    public Guides(File guidesDir, AsciiDoctor asciiDoctor) throws IOException {
        for (File d : guidesDir.listFiles((file) -> file.isDirectory() && !file.getName().equals("includes") && !file.getName().equals("images"))) {
            for (File f: d.listFiles((dir, name) -> name.endsWith(".adoc"))) {
                Map<String, Object> attributes = asciiDoctor.parseAttributes(f);

                int priority = attributes.containsKey("priority") ? Integer.parseInt((String) attributes.get("priority")) : 1000;

                boolean community = "true".equals(attributes.get("community"));

                Guide g = new Guide(d.getName(), f.getName(), (String) attributes.get("title"), (String) attributes.get("summary"), (String) attributes.get("author"), community, priority, (String) attributes.get("external-link"));
                guides.add(g);
            }
        }

        Collections.sort(guides, (o1, o2) -> {
            if (o1.getPriority() == o2.getPriority()) {
                return o1.getName().compareTo(o2.getName());
            } else {
                return Integer.compare(o1.getPriority(), o2.getPriority());
            }
        });
    }

    public List<Guide> getGuides(GuideCategory c) {
        return guides.stream().filter(g -> g.category.equals(c)).collect(Collectors.toList());
    }

    public List<Guide> getGuides() {
        return guides;
    }

    public List<GuideCategory> getCategories() {
        return Arrays.asList(GuideCategory.values());
    }

    public class Guide {

        private GuideCategory category;
        private String name;
        private String author;
        private boolean community;
        private String template;
        private String title;
        private String summary;
        private String path;
        private int priority = -1;
        private String externalLink;

        public Guide(String category, String template, String title, String summary, String author, boolean community, int priority, String externalLink) {
            this.category = GuideCategory.valueOf(category.toUpperCase().replaceAll("-", "_"));
            this.name = template.replace(".adoc", "");
            this.author = author;
            this.community = community;
            this.template = category + "/" + template;
            this.title = title;
            this.summary = summary;
            this.path = category + "/" + name;
            this.priority = priority;
            this.externalLink = externalLink;
        }

        public String getName() {
            return name;
        }

        public String getAuthor() {
            return author;
        }

        public boolean isCommunity() {
            return community;
        }

        public GuideCategory getCategory() {
            return category;
        }

        public String getTemplate() {
            return template;
        }

        public void setTemplate(String template) {
            this.template = template;
        }

        public String getTitle() {
            return title;
        }

        public String getSummary() {
            return summary;
        }

        public String getPath() {
            return path;
        }

        public int getPriority() {
            return priority;
        }

        public String getExternalLink() {
            return externalLink;
        }

        public boolean isExternal() {
            return externalLink != null;
        }
    }

    public enum GuideCategory {

        GETTING_STARTED("Getting Started with Keycloak"),
        SECURING_APPS("Securing Applications");

        private String label;

        GuideCategory(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }

}
