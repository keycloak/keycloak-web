package org.keycloak.webbuilder;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.keycloak.webbuilder.utils.AsciiDoctor;

public class Guides {

    private final List<GuidesMetadata.GuideMetadata> categories = new ArrayList<>();
    private final List<Guide> guides = new ArrayList<>();

    public Guides(GuidesMetadata guidesMetadata, Path webSrcDir, AsciiDoctor asciiDoctor) throws IOException {

        for (GuidesMetadata.GuideSource guideSource : guidesMetadata.getSources()) {
            Path srcPath = webSrcDir.resolve(guideSource.getDir());
            String srcDirectoryName = srcPath.getFileName().toString();
            List<Path> guidePaths;
            if (srcDirectoryName.contains("$$VERSION$$")) {
                try (Stream<Path> paths = Files.list(srcPath.getParent())) {
                    guidePaths = paths
                          .filter(p -> p.getFileName().toString().matches(srcDirectoryName.replace("$$VERSION$$", ".*")))
                          .toList();
                }
            } else {
                guidePaths = List.of(srcPath);
            }

            for (GuidesMetadata.GuideMetadata guideMetadata : guidesMetadata.getGuides()) {
                for (Path guide : guidePaths)
                    loadGuides(asciiDoctor, guide, guideSource, guideMetadata);
            }
        }

        Collections.sort(guides);
        for (GuidesMetadata.GuideMetadata guideMetadata : guidesMetadata.getGuides()) {
            if (!getGuides(guideMetadata).isEmpty()) {
                categories.add(guideMetadata);
            }
        }
    }

    public Guide getGuide(String category, String name) {
        Optional<Guide> o = guides.stream().filter(g -> g.getMetadata().getId().equals(category) && g.getName().equals(name)).findFirst();
        return o.orElse(null);
    }

    private void loadGuides(AsciiDoctor asciiDoctor, Path root, GuidesMetadata.GuideSource guideSource, GuidesMetadata.GuideMetadata guideMetadata) throws IOException {
        if (!Files.isDirectory(root)) {
            return;
        }

        boolean snapshot = root.getFileName().toString().endsWith("-SNAPSHOT");
        Path guideRoot = root;
        Path generatedGuides = root.resolve("generated-guides");
        if (Files.isDirectory(generatedGuides)) {
            guideRoot = generatedGuides;
        }

        Path sharedAttributesPath = guideRoot.resolve("attributes.adoc");
        guideRoot = guideRoot.resolve(guideMetadata.getId());
        if (!Files.isDirectory(guideRoot)) {
            return;
        }

        Map<String, Integer> guidePriorities = loadPinnedGuides(guideRoot);
        Map<String, Object> sharedAttributes = Files.isRegularFile(sharedAttributesPath) ? asciiDoctor.parseAttributes(sharedAttributesPath) : Collections.emptyMap();

        Path partials = guideRoot.resolve("partials");
        Path templates = guideRoot.resolve("templates");
        List<Path> guidePaths;
        try (Stream<Path> files = Files.walk(guideRoot)) {
            guidePaths = files
                  .filter(Files::isRegularFile)
                  .filter(p -> !p.startsWith(partials))
                  .filter(p -> !p.startsWith(templates))
                  .filter(p -> p.toString().endsWith(".adoc"))
                  .filter(p -> !p.getFileName().toString().equals("index.adoc"))
                  .toList();
        } catch (IOException e) {
            throw new RuntimeException("Failed to load guides from " + guideRoot, e);
        }

        for (Path path : guidePaths) {
            Map<String, Object> attributes = asciiDoctor.parseAttributes(path, sharedAttributes);

            boolean community = "true".equals(attributes.get("community"));

            Object isTileVisibileAttribute = attributes.get("guide-tile-visible");
            boolean isTileVisibile = isTileVisibileAttribute == null || "true".equals(isTileVisibileAttribute);
            Guide g = new Guide(guideSource, guideMetadata, path, (String) attributes.get("guide-parent"),
                  (String) attributes.get("guide-title"), (String) attributes.get("guide-summary"), (String) attributes.get("guide-tags"),
                  (String) attributes.get("author"), community, (String) attributes.get("external-link"), isTileVisibile, snapshot);

            if (guidePriorities != null) {
                Integer priority = guidePriorities.get(g.getFQName());
                if (priority != null) {
                    g.priority = priority;
                }
            } else if (attributes.containsKey("guide-priority")) {
                g.priority = Integer.parseInt((String) attributes.get("guide-priority"));
            }

            guides.add(g);
        }
    }

    private Map<String, Integer> loadPinnedGuides(Path src) throws IOException {
        Path pinnedGuides = src.resolve("pinned-guides");
        if (Files.notExists(pinnedGuides) || Files.isDirectory(pinnedGuides)) {
            return null;
        }
        Map<String, Integer> priorities = new HashMap<>();
        try (BufferedReader br = Files.newBufferedReader(pinnedGuides)) {
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

    public List<GuidesMetadata.GuideMetadata> getCategories(boolean wantSnapshots) {
        return categories.stream().filter(filterEmptyCategories(wantSnapshots)).collect(Collectors.toList());
    }

    private Predicate<GuidesMetadata.GuideMetadata> filterEmptyCategories(boolean wantSnapshots) {
        return cat -> getGuides(cat).stream().anyMatch(guide-> guide.isSnapshot() == wantSnapshots);
    }

    public static class Guide implements Comparable<Guide> {

        private final GuidesMetadata.GuideSource guideSource;
        private final GuidesMetadata.GuideMetadata metadata;
        private final String name;
        private final String parent;
        private final String fqn;
        private final String author;
        private final boolean community;
        private final Path source;
        private final boolean snapshot;
        private final String template;
        private final String title;
        private final String summary;
        private final String path;
        private List<String> tags;
        private int priority = Integer.MAX_VALUE;
        private final String externalLink;
        private final boolean tileVisible;

        public Guide(GuidesMetadata.GuideSource guideSource, GuidesMetadata.GuideMetadata metadata, Path source, String parent, String title, String summary, String tags, String author, boolean community, String externalLink, boolean tileVisible, boolean snapshot) {
            this.guideSource = guideSource;
            this.metadata = metadata;
            this.name = source.getFileName().toString().replace(".adoc", "");
            this.parent = parent;
            this.fqn = hasParent() ? parent + "/" + name : name;
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
            this.path = metadata.getId() + "/" + fqn;
            this.externalLink = externalLink;
            this.tileVisible = tileVisible;
        }

        public String getName() {
            return name;
        }

        public String getParent() {
            return parent;
        }

        public boolean hasParent() {
            return parent != null && !parent.isBlank();
        }

        public String getFQName() {
            return fqn;
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

        public Path getSource() {
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

        @Override
        public int compareTo(Guide o2) {
            return priority == o2.priority ?
                  title.compareTo(o2.title) :
                  Integer.compare(priority, o2.priority);
        }
    }
}
