package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class Guides {

    private List<GuideCategory> categories = new LinkedList<>();
    private List<Guide> guides = new LinkedList<>();

    public Guides(File tmpDir, File guidesDir, AsciiDoctor asciiDoctor) throws IOException {
        for (File d : guidesDir.listFiles((file) -> file.isDirectory())) {
            GuideCategory category = getCategory(d);
            if (category == null) {
                continue;
            }

            loadGuides(asciiDoctor, d, category);
        }

        Arrays.stream(tmpDir.getParentFile().listFiles((f, s) -> s.startsWith("keycloak-guides"))).findFirst().ifPresent(f -> {
            try {
                loadGuides(asciiDoctor, new File(f, "generated-guides/server"), GuideCategory.SERVER);
                loadGuides(asciiDoctor, new File(f, "generated-guides/operator"), GuideCategory.OPERATOR);
                loadGuides(asciiDoctor, new File(f, "generated-guides/migration"), GuideCategory.MIGRATION);
                loadGuides(asciiDoctor, new File(f, "generated-guides/getting-started"), GuideCategory.GETTING_STARTED);
                loadGuides(asciiDoctor, new File(f, "generated-guides/securing-apps"), GuideCategory.SECURING_APPS);
                loadGuides(asciiDoctor, new File(f, "generated-guides/high-availability"), GuideCategory.HIGH_AVAILABILITY);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        Collections.sort(guides, (o1, o2) -> {
            if (o1.getPriority() == o2.getPriority()) {
                return o1.getTitle().compareTo(o2.getTitle());
            } else {
                return Integer.compare(o1.getPriority(), o2.getPriority());
            }
        });

        for (GuideCategory c : GuideCategory.values()) {
            if (getGuides(c).size() > 0) {
                categories.add(c);
            }
        }
    }

    public Guide getGuide(String category, String name) {
        Optional<Guide> o = guides.stream().filter(g -> g.getCategory().getId().equals(category) && g.getName().equals(name)).findFirst();
        return o.isPresent() ? o.get() : null;
    }

    private void loadGuides(AsciiDoctor asciiDoctor, File d, GuideCategory category) throws IOException {
        if (!d.isDirectory()) {
            return;
        }

        Map<String, Integer> guidePriorities = loadPinnedGuides(new File(d, "pinned-guides"));

        File sharedAttributesFile = new File(d.getParentFile(), "attributes.adoc");
        Map<String, Object> sharedAttributes = sharedAttributesFile.isFile() ? asciiDoctor.parseAttributes(sharedAttributesFile) : Collections.emptyMap();

        for (File f: d.listFiles((dir, name) -> name.endsWith(".adoc") && !name.equals("index.adoc"))) {
            Map<String, Object> attributes = asciiDoctor.parseAttributes(f, sharedAttributes);

            boolean community = "true".equals(attributes.get("community"));

            Object isTileVisibileAttribute = attributes.get("guide-tile-visible");
            boolean isTileVisibile = isTileVisibileAttribute == null || "true".equals(isTileVisibileAttribute);
            try {
                Guide g = new Guide(category, f, (String) attributes.get("guide-title"), (String) attributes.get("guide-summary"), (String) attributes.get("guide-tags"), (String) attributes.get("author"), community,
                        (String) attributes.get("external-link"), isTileVisibile);

                if (guidePriorities != null) {
                    Integer priority = guidePriorities.get(g.getName());
                    if (priority != null) {
                        g.priority = priority;
                    }
                } else if (attributes.containsKey("guide-priority")) {
                    g.priority = Integer.parseInt((String) attributes.get("guide-priority"));
                }

                guides.add(g);
            } catch (IllegalArgumentException e) {
            }
        }
    }

    private Map<String, Integer> loadPinnedGuides(File pinnedGuides) throws IOException {
        if (!pinnedGuides.isFile()) {
            return null;
        }
        Map<String, Integer> priorities = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(pinnedGuides))) {
            int c = 1;
            for (String l = br.readLine(); l != null; l = br.readLine()) {
                l = l.trim();
                if (!l.isEmpty()) {
                    priorities.put(l, c);
                }
                c++;
            }
            return priorities;
        }
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
        return categories;
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
        private List<String> tags;
        private int priority = Integer.MAX_VALUE;
        private String externalLink;
        private boolean tileVisible;

        public Guide(GuideCategory category, File source, String title, String summary, String tags, String author, boolean community, String externalLink, boolean tileVisible) {
            this.category = category;
            this.name = source.getName().replace(".adoc", "");
            this.author = author;
            this.community = community;
            this.source = source;
            this.template = "guide-" + name + ".html";
            this.title = title;
            this.summary = summary;
            if (tags != null) {
                this.tags = Arrays.stream(tags.split(",")).map(s -> s.toLowerCase().trim()).sorted().collect(Collectors.toList());
            }
            this.path = category.getId() + "/" + name;
            this.externalLink = externalLink;
            this.tileVisible = tileVisible;
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

        public List<String> getTags() {
            return tags;
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

        public boolean isTileVisible() {
            return tileVisible;
        }
    }

    public enum GuideCategory {

        MIGRATION("migration", "Migration"),
        GETTING_STARTED("getting-started", "Getting started"),
        SERVER("server", "Server"),
        OPERATOR("operator", "Operator"),
        SECURING_APPS("securing-apps", "Securing applications"),
        HIGH_AVAILABILITY("high-availability", "High availability");

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
