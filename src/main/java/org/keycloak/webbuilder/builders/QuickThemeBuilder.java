package org.keycloak.webbuilder.builders;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class QuickThemeBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        File quickthemeDir = resolveQuickthemeDir();
        File distDir = new File(quickthemeDir, "dist");
        File targetDir = new File(context.getTargetDir(), "quick-theme");

        if (!distDir.isDirectory() || !new File(distDir, "index.html").isFile()) {
            runCommand(quickthemeDir, command("pnpm", "install", "--frozen-lockfile"));
            runCommand(quickthemeDir, command("pnpm", "build"));
        } else {
            printStep("skipped", "quicktheme build (dist already present)");
        }

        if (!distDir.isDirectory()) {
            throw new IllegalStateException("quicktheme dist/ not found after build");
        }

        if (targetDir.exists()) {
            FileUtils.deleteDirectory(targetDir);
        }
        FileUtils.copyDirectory(distDir, targetDir);
        printStep("copied", "quick-theme to " + targetDir.getPath());
    }

    private File resolveQuickthemeDir() throws Exception {
        File inRepo = new File(context.getWebSrcDir(), "quicktheme");
        if (isQuickthemeProject(inRepo)) {
            return inRepo;
        }
        File sibling = new File(context.getWebSrcDir(), "../quicktheme");
        if (isQuickthemeProject(sibling)) {
            return sibling.getCanonicalFile();
        }
        throw new IllegalStateException(
                "quicktheme project not found. Expected quicktheme/ in the website repo "
                        + "or ../quicktheme as a sibling directory.");
    }

    private boolean isQuickthemeProject(File dir) {
        return dir.isDirectory() && new File(dir, "package.json").isFile();
    }

    private String[] command(String... parts) {
        return parts;
    }

    private void runCommand(File dir, String... cmd) throws Exception {
        List<String> command = new ArrayList<>();
        for (String part : cmd) {
            command.add(part);
        }
        ProcessBuilder pb = new ProcessBuilder(command);
        pb.directory(dir);
        pb.inheritIO();
        Process process = pb.start();
        int exit = process.waitFor();
        if (exit != 0) {
            throw new RuntimeException(
                    "Command failed with exit code " + exit + ": " + String.join(" ", command));
        }
        printStep("ran", String.join(" ", command) + " in " + dir.getName());
    }

    @Override
    protected String getTitle() {
        return "Quick Theme";
    }
}
