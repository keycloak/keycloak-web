package org.keycloak.webbuilder.builders;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.regex.Pattern;

/**
 * @author Alexander Schwartz
 */
public class RedirectBuilder extends AbstractBuilder {

    Pattern REGEX_CHARS = Pattern.compile("[()+?]");

    @Override
    protected void build() throws Exception {
        try (BufferedReader br = new BufferedReader(new FileReader("resources/redirects"))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) {
                    continue;
                }
                if (line.startsWith("#")) {
                    continue;
                }
                String[] parts = line.split("=");
                if (parts.length != 2) {
                    continue;
                }

                String file = parts[0].trim();

                // Remove "^" from the start
                if (!file.startsWith("^/")) {
                    continue;
                }
                file = file.substring(2);

                // We have a custom 404 page with JavaScript on it, don't overwrite it
                if (file.startsWith("404")) {
                    continue;
                }

                // If there are any regex characters, ignore as we can't create a file name from it
                if (REGEX_CHARS.matcher(file).find()) {
                    continue;
                }

                file = file + ".html";
                String url = parts[1].trim();
                url = context.getLinks().getLink(url);
                String canonicalUrl = url;
                // The canonical URL must not contain the anchor
                canonicalUrl = canonicalUrl.replaceAll("#.*", "");

                Files.createDirectories(new File(context.getTargetDir(), file).getParentFile().toPath());

                try (PrintWriter writer = new PrintWriter(new File(context.getTargetDir(), file))) {
                    writer.printf("""
                            <!DOCTYPE HTML>
                            <html lang="en">
                                <head>
                                    <meta charset="utf-8">
                                    <meta http-equiv="refresh" content="0; url=%s">
                                    <title>Page Redirection</title>
                                </head>
                                <body>
                                     If you are not redirected automatically, follow this <a href="%s">link</a>.
                                </body>
                            </html>
                            """, url, url);
                }

                printStep("created", file);

            }
        }
    }

    @Override
    protected String getTitle() {
        return "Redirect";
    }
}
