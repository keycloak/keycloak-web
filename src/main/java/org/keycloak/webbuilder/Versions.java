package org.keycloak.webbuilder;

import org.keycloak.webbuilder.misc.ChangeLogEntry;
import org.keycloak.webbuilder.utils.JsonParser;

import java.io.File;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Versions extends LinkedList<Versions.Version> {

    public Versions(File versionsDir, JsonParser json) {
        for (File versionFile : versionsDir.listFiles((dir, name) -> name.endsWith(".json"))) {
            add(json.read(versionFile, Version.class));
        }
        Collections.sort(this);

        get(0).setLatest(true);
    }

    public Version getLatest() {
        return get(0);
    }

    public List<Version> getMajorMinor() {
        Map<String, Version> map = new HashMap<>();
        for (Version v : this) {
            if (!map.containsKey(v.getVersionShorter())) {
                map.put(v.getVersionShorter(), v);
            }
        }
        LinkedList<Version> l = new LinkedList<>(map.values());
        Collections.sort(l);
        return l;
    }

    public static class Version implements  Comparable<Version> {

        private Date date;

        private String version;

        private int documentationTemplate;

        private int downloadTemplate;

        private int blogTemplate;

        private boolean latest;

        private String releaseNotes;

        private String migrationNotes;

        private ChangeLog changes;

        public boolean isFinal() {
            return true;
        }

        public String getVersionShort() {
            String[] split = version.split("\\.");
            return split[0] + "." + split[1] + "." + split[2];
        }

        public String getVersionShorter() {
            String[] split = version.split("\\.");
            return split[0] + "." + split[1];
        }

        public Date getDate() {
            return date;
        }

        public void setDate(Date date) {
            this.date = date;
        }

        public String getVersion() {
            return version;
        }

        public void setVersion(String version) {
            this.version = version;
        }

        public int getBlogTemplate() {
            return blogTemplate;
        }

        public void setBlogTemplate(int blogTemplate) {
            this.blogTemplate = blogTemplate;
        }

        public int getDocumentationTemplate() {
            return documentationTemplate;
        }

        public void setDocumentationTemplate(int documentationTemplate) {
            this.documentationTemplate = documentationTemplate;
        }

        public int getDownloadTemplate() {
            return downloadTemplate;
        }

        public void setDownloadTemplate(int downloadTemplate) {
            this.downloadTemplate = downloadTemplate;
        }

        public String getDocumentationVersion() {
            return latest ? "" : "v/" + version + "/";
        }

        public void setLatest(boolean latest) {
            this.latest = latest;
        }

        public String getReleaseNotes() {
            return releaseNotes;
        }

        public void setReleaseNotes(String releaseNotes) {
            this.releaseNotes = releaseNotes;
        }

        public String getMigrationNotes() {
            return migrationNotes;
        }

        public void setMigrationNotes(String migrationNotes) {
            this.migrationNotes = migrationNotes;
        }

        public ChangeLog getChanges() {
            return changes;
        }

        public void setChanges(ChangeLog changes) {
            this.changes = changes;
        }

        @Override
        public int compareTo(Version o) {
            return compareTo(o.getVersion());
        }

        public int compareTo(String o) {
            String[] v1 = version.split("\\.");
            String[] v2 = o.split("\\.");

            int r = stringNumberCompareTo(v2[0], v1[0]);
            if (r != 0) {
                return r;
            }

            r = stringNumberCompareTo(v2[1], v1[1]);
            if (r != 0) {
                return r;
            }

            r = stringNumberCompareTo(v2[2], v1[2]);
            return r;
        }

        private int stringNumberCompareTo(String a, String b) {
            return Integer.valueOf(a).compareTo(Integer.valueOf(b));
        }
    }

    public static class ChangeLog {

        private List<ChangeLogEntry> entries;

        public ChangeLog(List<ChangeLogEntry> entries) {
            this.entries = entries;
        }

        public List<ChangeLogEntry> getAll() {
            return entries;
        }

        public List<ChangeLogEntry> getBugs() {
            return entries.stream().filter(e -> e.getKind().equals("bug")).collect(Collectors.toList());
        }

        public List<ChangeLogEntry> getFeatures() {
            return entries.stream().filter(e -> e.getKind().equals("feature")).collect(Collectors.toList());
        }

        public List<ChangeLogEntry> getEnhancements() {
            return entries.stream().filter(e -> e.getKind().equals("enhancement")).collect(Collectors.toList());
        }

        public List<ChangeLogEntry> getDeprecations() {
            return entries.stream().filter(e -> e.getKind().equals("deprecation")).collect(Collectors.toList());
        }
    }

}
