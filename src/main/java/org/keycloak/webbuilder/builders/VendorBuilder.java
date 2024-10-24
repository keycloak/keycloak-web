package org.keycloak.webbuilder.builders;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.keycloak.webbuilder.npm.Package;
import org.keycloak.webbuilder.npm.Registry;
import org.keycloak.webbuilder.npm.Version;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public class VendorBuilder extends AbstractBuilder {

    private final Map<String, String> imports = new HashMap<>();

    @Override
    protected void build() throws Exception {
        // Install packages.
        installPackage("keycloak-js", "latest");
        // Write import map to disk.
        context.getImportMap().writeValue(imports);
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

            // Resolve target path without 'package' prefix and create directories.
            Path entryPath = Path.of(packagePrefix).relativize(Path.of(entry.getName()));
            Path targetPath = installationPath.resolve(entryPath);
            Files.createDirectories(targetPath.getParent());

            // Copy file contents.
            Files.copy(tarball, targetPath);
        }

        // Add package to the imports so it can be written to the import map later.
        Path importPath = Path.of("/vendor", name, latestVersion.resolveEntryPoint()).normalize();
        imports.put(name, importPath.toString());
    }

    @Override
    protected String getTitle() {
        return "Vendor";
    }
}
