package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Blogs;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class BlogBuilder extends AbstractBuilder {

    @Override
    protected void build() throws Exception {
        for (Blogs.Blog blog : context.blogs()) {
            Map<String, Object> attributes = new HashMap<>();

            attributes.putAll(blog.getMap());
            attributes.put("blog", blog);

            File dir = new File(context.getTargetDir(), blog.getPath());
            dir.mkdirs();

            context.getTmpDir().mkdirs();

            if (Blogs.BlogFormat.FREEMARKER.equals(blog.getFormat())) {
                attributes.put("blogInclude", blog.getTemplate());
            } else {
                String blogInclude = "blog-" + blog.getFilename();
                context.asciiDoctor().writeFile(blog.getMap(), new File(context.getWebSrcDir(), blog.getTemplate()), context.getTmpDir(), blogInclude);
                blog.setTemplate("target/tmp/" + blogInclude);
            }

            context.freeMarker().writeFile(attributes, "templates/blog-entry.ftl", dir, blog.getFilename());
            printStep("created", blog.getFilename());
        }
    }

    @Override
    protected String getTitle() {
        return "Blog";
    }

}
