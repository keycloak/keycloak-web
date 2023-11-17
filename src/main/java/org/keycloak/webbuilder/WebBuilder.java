package org.keycloak.webbuilder;

import org.keycloak.webbuilder.builders.AbstractBuilder;
import org.keycloak.webbuilder.builders.AppBuilder;
import org.keycloak.webbuilder.builders.BlogBuilder;
import org.keycloak.webbuilder.builders.ChangelogBuilder;
import org.keycloak.webbuilder.builders.DocumentationArchiveBuilder;
import org.keycloak.webbuilder.builders.DownloadsArchiveBuilder;
import org.keycloak.webbuilder.builders.GitHubReleaseNotesBuilder;
import org.keycloak.webbuilder.builders.GuideBuilder;
import org.keycloak.webbuilder.builders.PageBuilder;
import org.keycloak.webbuilder.builders.ReleaseNotesBuilder;
import org.keycloak.webbuilder.builders.ResourcesBuilder;
import org.keycloak.webbuilder.builders.RssFeedBuilder;

import java.io.File;

/**
 * @author <a href="mailto:sthorger@redhat.com">Stian Thorgersen</a>
 */
public class WebBuilder {

    private AbstractBuilder[] builders = new AbstractBuilder[] {
//            new Cleaner(),
            new ChangelogBuilder(),
            new ResourcesBuilder(),
            new ReleaseNotesBuilder(),
            new GitHubReleaseNotesBuilder(),
            new BlogBuilder(),
            new GuideBuilder(),
            new PageBuilder(),
            new DocumentationArchiveBuilder(),
            new DownloadsArchiveBuilder(),
            new RssFeedBuilder(),
            new AppBuilder()
    };

    public static void main(String[] args) throws Exception {
        new WebBuilder(new File(System.getProperty("user.dir"))).build();
    }

    private File rootDir;

    public WebBuilder(File rootDir) {
        this.rootDir = rootDir;
    }

    public void build() throws Exception {
        Context context = new Context(rootDir);

        for (AbstractBuilder b : builders) {
            b.init(context);
            b.execute();
            b.close();
        }

        System.out.println("Build completed");
        System.out.println();
        System.out.println(new File(context.getTargetDir(), "index.html").toURI().toString());
        System.out.println();

        context.close();
    }

}
