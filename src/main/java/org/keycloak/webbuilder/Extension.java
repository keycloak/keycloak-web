package org.keycloak.webbuilder;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class Extension implements  Comparable<Extension> {

    private String name;
    private String description;
    private String[] maintainers;
    private String website;
    private String download;
    private String documentation;
    private String source;

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

    @Override
    public int compareTo(Extension o) {
        return name.compareTo(o.name);
    }
}
