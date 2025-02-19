package org.keycloak.webbuilder;

import org.apache.commons.lang3.StringUtils;
import org.keycloak.webbuilder.utils.GitHubApi;
import org.keycloak.webbuilder.utils.JsonParser;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.EnumMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class Extensions {
    private static final String GITHUB_URL = "https://github.com/";
    private static final int LESS_ACTIVE_OLDER_THAN_MONTHS = 12;
    private final Map<LivenessCategory, List<Extension>> extensionsMap = new EnumMap<>(LivenessCategory.class);

    public enum LivenessCategory {
        ACTIVE,
        LESS_ACTIVE;
    }

    public List<LivenessCategory> getLivenessCategories() {
        return Arrays.stream(LivenessCategory.values()).toList();
    }

    public List<Extension> getByLivenessCategory(LivenessCategory category) {
        List<Extension> result = extensionsMap.get(category);
        result.sort(Comparator.comparing(Extension::getName));
        return result;
    }

    public Extensions(File extensionsDir) {
        var lessActiveDayThreshold = Date.from(LocalDate.now(ZoneOffset.UTC)
                .minusMonths(LESS_ACTIVE_OLDER_THAN_MONTHS)
                .atStartOfDay(ZoneId.systemDefault())
                .toInstant());

        for (LivenessCategory category : LivenessCategory.values()) {
            extensionsMap.put(category, new LinkedList<>());
        }

        try (GitHubApi ghApi = GitHubApi.getInstance()) {
            var gh = ghApi.get();
            if (gh == null) {
                return;
            }
            for (File extensionFile : extensionsDir.listFiles((dir, name) -> name.endsWith(".json"))) {
                var extension = JsonParser.read(extensionFile, Extension.class);
                var ghSource = Optional.ofNullable(extension.getSource())
                        .or(() -> Optional.ofNullable(extension.getWebsite()))
                        .filter(StringUtils::isNotEmpty)
                        .filter(f -> f.startsWith(GITHUB_URL));

                Date updatedAt = null;
                if (ghSource.isPresent()) {
                    String repoName = ghSource.get().replace(GITHUB_URL, "").split("\\?")[0];
                    if (StringUtils.isNotEmpty(repoName)) {
                        var repository = gh.getRepository(repoName);
                        if (repository != null) {
                            extension.setStars(repository.getStargazersCount());
                            updatedAt = repository.getPushedAt();
                        }
                    }
                }

                if (updatedAt != null && updatedAt.before(lessActiveDayThreshold)) {
                    extensionsMap.get(LivenessCategory.LESS_ACTIVE).add(extension);
                } else {
                    extensionsMap.get(LivenessCategory.ACTIVE).add(extension);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        setTopExtensions();
    }

    private void setTopExtensions() {
        List<Extension> topExtensions = extensionsMap.get(LivenessCategory.ACTIVE)
                .stream()
                .filter(f -> f.getStars() != null)
                .sorted(Comparator.comparingInt(Extension::getStars).reversed())
                .limit(3)
                .toList();

        for (int i = 0; i < topExtensions.size(); i++) {
            topExtensions.get(i).setRank(i + 1);
        }
    }

    private static String getFormattedStarsCount(int stars) {
        if (stars >= 1000) {
            return String.format("%.1fk", stars / 1000.0);
        } else {
            return String.valueOf(stars);
        }
    }

    public static class Extension implements  Comparable<Extension> {

        private String name;
        private String description;
        private String[] maintainers;
        private String website;
        private String download;
        private String documentation;
        private String source;

        private Integer stars;

        private Integer rank;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String[] getMaintainers() {
            return maintainers;
        }

        public void setMaintainers(String[] maintainers) {
            this.maintainers = maintainers;
        }

        public String getWebsite() {
            return website;
        }

        public void setWebsite(String website) {
            this.website = website;
        }

        public String getDownload() {
            return download;
        }

        public void setDownload(String download) {
            this.download = download;
        }

        public String getDocumentation() {
            return documentation;
        }

        public void setDocumentation(String documentation) {
            this.documentation = documentation;
        }

        public String getSource() {
            return source;
        }

        public void setSource(String source) {
            this.source = source;
        }

        public Integer getStars() {
            return stars;
        }

        public String printStars() {
            return getFormattedStarsCount(getStars());
        }

        public void setStars(Integer stars) {
            this.stars = stars;
        }

        public Integer getRank() {
            return rank;
        }

        public void setRank(Integer rank) {
            this.rank = rank;
        }

        @Override
        public int compareTo(Extension o) {
            return name.compareTo(o.name);
        }
    }
}
