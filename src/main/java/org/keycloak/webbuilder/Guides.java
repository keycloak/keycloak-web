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

    private List<GuidesMetadata.GuideMetadata> categories = new LinkedList<>();
    private List<Guide> guides = new LinkedList<>();

    public Guides(GuidesMetadata guidesMetadata, File tmpDir, File webSrcDir, AsciiDoctor asciiDoctor) throws IOException {

        for (GuidesMetadata.GuideSource guideSource : guidesMetadata.getSources()) {
            final File d = new File(webSrcDir, guideSource.getDir());
            File[] sourceDirs;
            if (d.getName().contains("$$VERSION$$")) {
                sourceDirs = d.getParentFile().listFiles(f -> f.getName().matches(d.getName().replace("$$VERSION$$", ".*")));
            } else {
                sourceDirs = new File[] { d };
            }

            for (GuidesMetadata.GuideMetadata guideMetadata : guidesMetadata.getGuides()) {
                for (File sourceDir : sourceDirs) {
                    loadGuides(asciiDoctor, sourceDir, guideSource, guideMetadata);
                }
            }
        }

        Collections.sort(guides, (o1, o2) -> {
            if (o1.getPriority() == o2.getPriority()) {
                return o1.getTitle().compareTo(o2.getTitle());
            } else {
                return Integer.compare(o1.getPriority(), o2.getPriority());
            }
        });

        for (GuidesMetadata.GuideMetadata guideMetadata : guidesMetadata.getGuides()) {
            if (getGuides(guideMetadata).size() > 0) {
                categories.add(guideMetadata);
            }
        }
    }

    public Guide getGuide(String category, String name) {
        Optional<Guide> o = guides.stream().filter(g -> g.getMetadata().getId().equals(category) && g.getName().equals(name)).findFirst();
        return o.isPresent() ? o.get() : null;
    }

    private void loadGuides(AsciiDoctor asciiDoctor, File d, GuidesMetadata.GuideSource guideSource, GuidesMetadata.GuideMetadata guideMetadata) throws IOException {
        if (!d.isDirectory()) {
            return;
        }

        boolean snapshot = d.getName().endsWith("-SNAPSHOT");

        File generatedGuides = new File(d, "generated-guides");
        if (generatedGuides.isDirectory()) {
            d = generatedGuides;
        }

        d = new File(d, guideMetadata.getId());
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
                Guide g = new Guide(guideSource, guideMetadata, f, (String) attributes.get("guide-title"), (String) attributes.get("guide-summary"), (String) attributes.get("guide-tags"), (String) attributes.get("author"), community,
                        (String) attributes.get("external-link"), isTileVisibile, snapshot);

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

    public List<Guide> getGuides(GuidesMetadata.GuideMetadata c) {
        return guides.stream().filter(g -> g.getMetadata().equals(c)).collect(Collectors.toList());
    }

    public List<Guide> getGuides() {
        return guides;
    }

    public List<GuidesMetadata.GuideMetadata> getCategories() {
        return categories;
    }

    public class Guide {

        private GuidesMetadata.GuideSource guideSource;
        private GuidesMetadata.GuideMetadata metadata;
        private String name;
        private String author;
        private boolean community;
        private File source;
        private final boolean snapshot;
        private String template;
        private String title;
        private String summary;
        private String path;
        private List<String> tags;
        private int priority = Integer.MAX_VALUE;
        private String externalLink;
        private boolean tileVisible;

        public Guide(GuidesMetadata.GuideSource guideSource, GuidesMetadata.GuideMetadata metadata, File source, String title, String summary, String tags, String author, boolean community, String externalLink, boolean tileVisible, boolean snapshot) {
            this.guideSource = guideSource;
            this.metadata = metadata;
            this.name = source.getName().replace(".adoc", "");
            this.author = author;
            this.community = community;
            this.source = source;
            this.snapshot = snapshot;
            this.template = "guide-" + name + ".html";
            this.title = title;
            this.summary = summary;
            if (tags != null) {
                this.tags = Arrays.stream(tags.split(",")).map(s -> s.toLowerCase().trim()).sorted().collect(Collectors.toList());
            }
            this.path = metadata.getId() + "/" + name;
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

        public GuidesMetadata.GuideSource getGuideSource() {
            return guideSource;
        }

        public GuidesMetadata.GuideMetadata getMetadata() {
            return metadata;
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

        public boolean isSnapshot() {
            return snapshot;
        }
    }

}
