package org.keycloak.webbuilder;

import org.keycloak.webbuilder.utils.AsciiDoctor;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
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
                int orderOffset = 50;
                for (File guide: Arrays.stream(new File(f, "generated-guides")
                        .listFiles(d -> d.isDirectory()))
                        .sorted((c1, c2) -> Integer.compare(c2.listFiles().length, c1.listFiles().length)) // Ordered by number of entries
                        .collect(Collectors.toList())) {
                    String id = guide.getName();
                    String label = guide.getName().substring(0, 1).toUpperCase() + guide.getName().substring(1);
                    GuideCategory guideCategory = new GuideCategory(id, label, orderOffset, true);
                    orderOffset = orderOffset + 10;
                    GUIDE_CATEGORIES.add(guideCategory);
                    loadGuides(asciiDoctor, guide, guideCategory);
                }
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

        Collections.sort(GUIDE_CATEGORIES, Comparator.comparingInt(c -> c.getOrder()));
        for (GuideCategory c : GUIDE_CATEGORIES) {
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
        Map<String, Integer> guidePriorities = loadPinnedGuides(new File(d, "pinned-guides"));

        for (File f: d.listFiles((dir, name) -> name.endsWith(".adoc") && !name.equals("index.adoc"))) {
            Map<String, Object> attributes = asciiDoctor.parseAttributes(f);

            boolean community = "true".equals(attributes.get("community"));
            try {
                Guide g = new Guide(category, f, (String) attributes.get("guide-title"), (String) attributes.get("guide-summary"), (String) attributes.get("guide-tags"), (String) attributes.get("author"), community, (String) attributes.get("external-link"));

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
        String name = d.getName().toLowerCase(Locale.ROOT);
        for (GuideCategory c : GUIDE_CATEGORIES) {
            if (c.getId().equals(name)) {
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

        public Guide(GuideCategory category, File source, String title, String summary, String tags, String author, boolean community, String externalLink) {
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
    }

    private final static List<GuideCategory> GUIDE_CATEGORIES = new ArrayList<>();

    static {
        GUIDE_CATEGORIES.add(new GuideCategory("migration", "Migration", 10));
        GUIDE_CATEGORIES.add(new GuideCategory("getting-started", "Getting started", 20));
        GUIDE_CATEGORIES.add(new GuideCategory("securing-apps", "Securing applications", 1000));
    }

    public static class GuideCategory {

        private final String label;
        private final String id;
        private final int order;
        private final boolean dynamic;

        GuideCategory(String id, String label, int order) {
            this.id = id;
            this.label = label;
            this.order = order;
            this.dynamic = false;
        }

        GuideCategory(String id, String label, int order, boolean dynamic) {
            this.id = id;
            this.label = label;
            this.order = order;
            this.dynamic = dynamic;
        }

        public String getId() {
            return id;
        }

        public String getLabel() {
            return label;
        }

        public int getOrder() {
            return order;
        }

        public boolean getDynamic() {
            return dynamic;
        }
    }

}
