<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="blog" type="org.keycloak.webbuilder.Blogs.Blog" -->

<@tmpl.page current="search" title="${blog.title}" summary="${(blog.summary)!''}" previewImage="${(blog.preview)!''}" author="${(blog.author)!''}" rss=true jsonLd="${blog.jsonLd}">

<div class="container mt-5 kc-article">
    <h1>${blog.title}</h1>
    <p class="blog-date text-muted">${blog.date?string["MMMM dd YYYY"]}<#if blog.author??> by ${blog.author}</#if></p>

    <#if blog.old>
    <div class="alert alert-warning" role="alert" data-nosnippet>
    This post is more than one year old. The content within the blog post is likely to be out of date.
    </div>
    </#if>

    <#include "../${blog.template}">
</div>

</@tmpl.page>
