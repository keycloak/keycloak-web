package org.keycloak.webbuilder.builders;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveInputStream;
import org.apache.commons.compress.compressors.gzip.GzipCompressorInputStream;
import org.apache.commons.io.IOUtils;
import org.keycloak.webbuilder.misc.NpmPackageInfo;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URL;

public class AppBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        NpmPackageInfo npmPackageInfo = context.json().read(new URL("https://registry.npmjs.org/keycloak-js/"), NpmPackageInfo.class);

        File f = new File(context.getTargetDir(), "app/keycloak.js");
        if (!f.isFile()) {
            URL u = new URL("https://registry.npmjs.org/keycloak-js/-/keycloak-js-" + npmPackageInfo.getDistTags().getLatest() + ".tgz");
            try (ArchiveInputStream i = new TarArchiveInputStream(new GzipCompressorInputStream(new BufferedInputStream(u.openStream())))) {
                for (ArchiveEntry e = i.getNextEntry(); e != null; e = i.getNextEntry()) {
                    if (e.getName().equals("package/dist/keycloak.js")) {
                        try (OutputStream o = new FileOutputStream(f)) {
                            IOUtils.copy(i, o);
                        }
                    }
                }
            }
        }
    }

    @Override
    protected String getTitle() {
        return "App";
    }
}
