package org.keycloak.webbuilder.builders;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.keycloak.webbuilder.npm.Package;
import org.keycloak.webbuilder.npm.Registry;
import org.keycloak.webbuilder.npm.Version;
import org.keycloak.webbuilder.utils.JsonParser;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class AppBuilder extends AbstractBuilder {
    private final Set<String> ALLOWED_EXTENSIONS = Set.of("js");

    private final Map<String, String> imports = new HashMap<>();

    @Override
    protected void build() throws Exception {
        // Install packages.
        installPackage("keycloak-js", "latest");
        // Render page template to HTML.
        renderPage();
    }

    private void installPackage(String name, String version) throws Exception {
        // Resolve installation path and create directories.
        Path installationPath = context.getTargetDir().toPath().resolve("vendor").resolve(name);
        Files.createDirectories(installationPath);

        // Get package contents as tarball stream.
        Package packageInfo = Registry.getPackage(name);
        Version latestVersion = packageInfo.getVersionByTag(version);
        ArchiveInputStream<TarArchiveEntry> tarball = latestVersion.getDist().getTarballStream();

        // Copy package contents to installation path.
        ArchiveEntry entry;
        while ((entry = tarball.getNextEntry()) != null) {
            // Skip any files not part of the package contents.
            String packagePrefix = "package";
            if (!entry.getName().startsWith(packagePrefix)) {
                continue;
            }

            // Resolve path without 'package' prefix.
            Path entryPath = Path.of(packagePrefix).relativize(Path.of(entry.getName()));

            // Skip file if it's extension is not permitted.
            String extension = getFileExtension(entryPath.getFileName().toString());
            if(!ALLOWED_EXTENSIONS.contains(extension)) {
                continue;
            }

            // Resolve target path and copy file.
            Path targetPath = installationPath.resolve(entryPath);
            Files.createDirectories(targetPath.getParent());
            Files.copy(tarball, targetPath);
        }

        // Add package to the imports so it can be written to the import map later.
        Path importPath = Path.of("/vendor", name, latestVersion.resolveEntryPoint()).normalize();
        imports.put(name, importPath.toString());
    }

    private void renderPage() throws Exception {
        // Build import map from installed packages.
        Map<String, Map<String, String>> importMap = new HashMap<>();
        importMap.put("imports", imports);

        // Ad the import map to the template attributes.
        Map<String, Object> attributes = new HashMap<>();
        attributes.put("importMap", JsonParser.writeValueAsString(importMap));

        // Render the template.
        File targetDir = new File(context.getTargetDir(), "app");
        context.freeMarker().writeFile(attributes, "templates/app.ftl", targetDir, "index.html");
    }

    private String getFileExtension(String filename) {
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex >= 0) {
            return filename.substring(dotIndex + 1);
        }
        return "";
    }

    @Override
    protected String getTitle() {
        return "Vendor";
    }
}
