package org.keycloak.webbuilder.builders;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.io.IOUtils;
import org.keycloak.webbuilder.npm.Package;
import org.keycloak.webbuilder.npm.Registry;
import org.keycloak.webbuilder.npm.Version;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Path;

public class AppBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        Package packageInfo = Registry.getPackage("keycloak-js");
        Version latestVersion = packageInfo.getVersionByTag("latest");
        File targetFile = new File(context.getTargetDir(), "app/keycloak.js");

        // Skip if target file already exists.
        if (targetFile.isFile()) {
            return;
        }

        boolean useLegacy = latestVersion.getSemanticVersion().getMajor() < 26;
        String entryPoint = latestVersion.resolveEntryPoint(useLegacy);
        String sourcePath = Path.of("package", entryPoint).normalize().toString();
        ArchiveInputStream<TarArchiveEntry> tarball = latestVersion.getDist().getTarballStream();

        for (ArchiveEntry entry = tarball.getNextEntry(); entry != null; entry = tarball.getNextEntry()) {
            // Loop trough until we find a file that matches the package entrypoint.
            if (!entry.getName().equals(sourcePath)) {
                continue;
            }

            // Copy the file over when found.
            try (OutputStream outputStream = new FileOutputStream(targetFile)) {
                IOUtils.copy(tarball, outputStream);
            }
        }
    }

    @Override
    protected String getTitle() {
        return "App";
    }
}
