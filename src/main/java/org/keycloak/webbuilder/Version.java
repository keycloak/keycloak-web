package org.keycloak.webbuilder;

import java.util.Date;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class Version implements  Comparable<Version> {

    private Date date;

    private String version;

    private String documentationTemplate;

    private String downloadTemplate;

    private String wildflyVersionAdapter;

    private String wildflyVersionAdapterDeprecated;

    private boolean latest;

    public boolean isFinal() {
        return version.endsWith(".Final");
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

    public String getDocumentationTemplate() {
        return documentationTemplate;
    }

    public void setDocumentationTemplate(String documentationTemplate) {
        this.documentationTemplate = documentationTemplate;
    }

    public String getDownloadTemplate() {
        return downloadTemplate;
    }

    public void setDownloadTemplate(String downloadTemplate) {
        this.downloadTemplate = downloadTemplate;
    }

    public String getWildflyVersionAdapter() {
        return wildflyVersionAdapter;
    }

    public void setWildflyVersionAdapter(String wildflyVersionAdapter) {
        this.wildflyVersionAdapter = wildflyVersionAdapter;
    }

    public String getWildflyVersionAdapterDeprecated() {
        return wildflyVersionAdapterDeprecated;
    }

    public void setWildflyVersionAdapterDeprecated(String wildflyVersionAdapterDeprecated) {
        this.wildflyVersionAdapterDeprecated = wildflyVersionAdapterDeprecated;
    }

    public String getDocumentationVersion() {
        return latest ? "" : "v/" + version + "/";
    }

    public void setLatest(boolean latest) {
        this.latest = latest;
    }

    @Override
    public int compareTo(Version o) {
        String[] v1 = version.split("\\.");
        String[] v2 = o.getVersion().split("\\.");

        if (!v2[0].equals(v1[0])) {
            return v2[0].compareTo(v1[0]);
        }

        if (!v2[1].equals(v1[1])) {
            return v2[1].compareTo(v1[1]);
        }

        if (!v2[2].equals(v1[2])) {
            return v2[2].compareTo(v1[2]);
        }

        return v2[3].compareTo(v1[3]);
    }
}
