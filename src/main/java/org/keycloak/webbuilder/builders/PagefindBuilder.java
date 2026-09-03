package org.keycloak.webbuilder.builders;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PagefindBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File pagefindScript = new File(context.getWebSrcDir(), "node_modules/pagefind/lib/runner/bin.cjs");
        if (!pagefindScript.exists()) {
            System.out.println("  pagefind not found, skipping search indexing");
            return;
        }

        String localNodePath = System.getProperty("os.name").startsWith("Windows") ? "node/node.exe" : "node/node";
        File localNode = new File(context.getWebSrcDir(), localNodePath);
        String nodeCmd = localNode.exists() ? localNode.getAbsolutePath() : "node";

        ProcessBuilder pb = new ProcessBuilder(
                nodeCmd,
                pagefindScript.getAbsolutePath(),
                "--site", context.getTargetDir().getAbsolutePath()
        );
        pb.directory(context.getWebSrcDir());
        pb.redirectErrorStream(true);

        Process process = pb.start();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                printStep("pagefind", line);
            }
        }

        int exitCode = process.waitFor();
        if (exitCode != 0) {
            throw new RuntimeException("Pagefind indexing failed with exit code " + exitCode);
        }
    }

    @Override
    protected String getTitle() {
        return "Pagefind";
    }
}
