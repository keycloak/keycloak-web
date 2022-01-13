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
        for (File d : guidesDir.listFiles((file) -> file.isDirectory())) {
            GuideCategory category = getCategory(d);
            if (category == null) {
                break;
            }

            for (File f: d.listFiles((dir, name) -> name.endsWith(".adoc"))) {
                Map<String, Object> attributes = asciiDoctor.parseAttributes(f);

                int priority = attributes.containsKey("priority") ? Integer.parseInt((String) attributes.get("priority")) : 1000;

                boolean community = "true".equals(attributes.get("community"));

                try {
                    Guide g = new Guide(category, f, (String) attributes.get("title"), (String) attributes.get("summary"), (String) attributes.get("author"), community, priority, (String) attributes.get("external-link"));
                    guides.add(g);
                } catch (IllegalArgumentException e) {
                }
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

    private GuideCategory getCategory(File d) {
        String name = d.getName().toUpperCase().replaceAll("-", "_");
        for (GuideCategory c : GuideCategory.values()) {
            if (c.name().equals(name)) {
                return c;
            }
        }
        return null;
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
        private File source;
        private String template;
        private String title;
        private String summary;
        private String path;
        private int priority = -1;
        private String externalLink;

        public Guide(GuideCategory category, File source, String title, String summary, String author, boolean community, int priority, String externalLink) {
            this.category = category;
            this.name = source.getName().replace(".adoc", "");
            this.author = author;
            this.community = community;
            this.source = source;
            this.template = "guide-" + name + ".html";
            this.title = title;
            this.summary = summary;
            this.path = category.getId() + "/" + name;
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

        public File getSource() {
            return source;
        }

        public String getTemplate() {
            return template;
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

        GETTING_STARTED("getting-started", "Getting started"),
        SECURING_APPS("securing-apps", "Securing applications");

        private String label;

        private String id;

        GuideCategory(String id, String label) {
            this.id = id;
            this.label = label;
        }

        public String getId() {
            return id;
        }

        public String getLabel() {
            return label;
        }
    }

}
