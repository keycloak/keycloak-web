package org.keycloak.webbuilder;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Attribute;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.*;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Pattern;

public class Sitemap {
    private XMLStreamWriter sitemap;
    private Context context;
    private final Map<String, UrlEntry> oldSitemap = new HashMap<>();
    private String now;

    public Sitemap(File rootDir) {
    }

    public void init(Context context) {
        this.context = context;

        initCurrentDate();

        readExistingSitemap();

        initNewSitemap();

    }

    /**
     * Read existing sitemap so we can use the last modified dates if the content hasn't changed. This should speed up Google indexing.
     */
    private void readExistingSitemap() {
        try {
            DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
            documentBuilderFactory.setValidating(false);
            documentBuilderFactory.setNamespaceAware(true);
            DocumentBuilder builder = documentBuilderFactory.newDocumentBuilder();
            // org.w3c.dom.Document doc = builder.parse(new File("sitemap.xml"));
            org.w3c.dom.Document doc = builder.parse("https://www.keycloak.org/sitemap.xml");
            NodeList url = doc.getElementsByTagName("url");

            for (int i = 0; i < url.getLength(); i++) {
                Node node = url.item(i);

                String hash = null, lastmod = null, loc = null;
                NodeList childNodes = node.getChildNodes();
                for (int j = 0; j < childNodes.getLength(); ++j) {
                    Node childNode = childNodes.item(j);
                    switch (childNode.getNodeName()) {
                        case "lastmod":
                            lastmod = childNode.getTextContent();
                            break;
                        case "loc":
                            loc = new URI(childNode.getTextContent()).getPath();
                            break;
                        case "kc:hash":
                            hash = childNode.getTextContent();
                            break;
                    }
                }

                if (hash == null) {
                    continue;
                }
                oldSitemap.put(loc, new UrlEntry(hash, lastmod));
            }

        } catch (FileNotFoundException e) {
            // ignored, file doesn't exist yet
        } catch (ParserConfigurationException | SAXException | IOException | URISyntaxException e) {
            throw new RuntimeException("Can't read old sitemap", e);
        }
    }

    private void initNewSitemap() {
        File sitemapFile = new File(context.getTargetDir(), "sitemap.xml");

        XMLOutputFactory output = XMLOutputFactory.newInstance();
        output.setProperty(XMLOutputFactory.IS_REPAIRING_NAMESPACES, true);
        try {
            sitemap = output.createXMLStreamWriter(
                    new FileOutputStream(sitemapFile));
            sitemap.setDefaultNamespace("http://www.sitemaps.org/schemas/sitemap/0.9");

            sitemap.writeStartDocument();

            sitemap.writeStartElement("urlset");
        } catch (XMLStreamException | FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void initCurrentDate() {
        Instant ts = Instant.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'+00:00'")
                .withZone(ZoneOffset.UTC);
        now = formatter.format(ts);
    }

    public void addFile(File file) {
        try {
            Document doc = Jsoup.parse(file);

            if (noIndex(doc)) return;

            String hash = getContentHash(doc);

            String canonical = getCanonical(file, doc);

            String lastmod = getLastmod(canonical, hash);

            writeUrl(canonical, hash, lastmod);
        } catch (XMLStreamException | IOException | NoSuchAlgorithmException e) {
            throw new RuntimeException("When adding " + file.getAbsolutePath(), e);
        }
    }

    private static boolean noIndex(Document doc) {
        Element robotsElement = doc.selectFirst("head > meta[name=robots]");
        Attribute robotsAttribute = robotsElement != null ? robotsElement.attribute("content") : null;
        String robots = robotsAttribute != null ? robotsAttribute.getValue() : null;
        return Objects.equals(robots, "noindex");
    }

    private static String getCanonical(File file, Document doc) {
        Element canonicalElement = doc.selectFirst("head > link[rel=canonical]");
        if (canonicalElement == null) {
            throw new RuntimeException("Can't find canonical URL in " + file.getAbsolutePath());
        }
        Attribute canonicalAttribute = canonicalElement.attribute("href");
        if (canonicalAttribute == null) {
            throw new RuntimeException("Can't find canonical URL in " + file.getAbsolutePath());
        }
        return canonicalAttribute.getValue();
    }

    private String getLastmod(String canonical, String hash) {
        String date = null;
        UrlEntry urlEntry = oldSitemap.get(canonical.replaceAll("^" + Pattern.quote(context.getLinks().getRoot()), ""));
        if (urlEntry != null) {
            if (urlEntry.getHash().equals(hash) && urlEntry.getLastmod() != null) {
                date = urlEntry.getLastmod();
            } else {
                date = now;
            }
        } else {
            date = now;
        }
        return date;
    }

    private void writeUrl(String canonical, String hash, String lastmod) throws XMLStreamException {
        sitemap.writeStartElement("url");

        sitemap.writeStartElement("loc");
        sitemap.writeCharacters(canonical);
        sitemap.writeEndElement();

        if (hash != null) {
            sitemap.writeStartElement("kc", "hash", "https://www.keycloak.org/1.0");
            sitemap.writeCharacters(hash);
            sitemap.writeEndElement();
        }
        if (lastmod != null) {
            sitemap.writeStartElement("lastmod");
            sitemap.writeCharacters(lastmod);
            sitemap.writeEndElement();
        }

        sitemap.writeEndElement();
    }

    private static String getContentHash(Document doc) throws NoSuchAlgorithmException {
        String hash = null;

        Element contents = doc.selectFirst(".kc-article");
        if (contents == null) {
            contents = doc.selectFirst(".jumbotron");
        }
        if (contents == null) {
            contents = doc.selectFirst(".container");
        }

        Element titleElement = doc.selectFirst("head > title");
        if (titleElement == null) {
            throw new RuntimeException("Can't find title");
        }
        String title = titleElement.text();

        Element descriptionElement = doc.selectFirst("head > meta[name=description]");
        String description = null;
        if (descriptionElement != null) {
            Attribute descriptionAttribute = descriptionElement.attribute("content");
            description = descriptionAttribute != null ? descriptionAttribute.getValue() : null;
        }

        if (contents != null) {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest((title + "." + description + "." + contents.text()).getBytes(StandardCharsets.UTF_8));
            hash = Base64.getEncoder().encodeToString(encodedhash);
        }
        return hash;
    }

    public void close() {
        try {
            sitemap.writeEndElement();
            sitemap.writeEndDocument();
            sitemap.flush();
            sitemap.close();
        } catch (XMLStreamException e) {
            throw new RuntimeException(e);
        }
    }

    private static class UrlEntry {
        private final String hash;
        private final String lastMod;

        public UrlEntry(String hash, String lastMod) {
            this.hash = hash;
            this.lastMod = lastMod;
        }

        public String getHash() {
            return hash;
        }

        public String getLastmod() {
            return lastMod;
        }
    }
}
