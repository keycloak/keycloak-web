<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="search" title="${blog.title}" rss=true>

<div class="container mt-5 kc-article">
    <h1>${blog.title}</h1>
    <p class="blog-date text-muted">${blog.date?string["MMMM dd YYYY"]}<#if blog.author??> by ${blog.author}</#if></p>

    <#if blog.old>
    <div class="alert alert-warning" role="alert">
    This post is more than one year old. The contents within the blog is likely to be out of date.
    </div>
    </#if>

    <#include "../${blog.template}">
</div>

</@tmpl.page>
