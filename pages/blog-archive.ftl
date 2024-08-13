<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="blog" title="Blog archive" noindex=true rss=true>

<div class="container mt-5 kc-article">
    <h1>Blog Archive</h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="blog.html">Blog</a></li>
        <li class="breadcrumb-item active">Archive</li>
    </ol>
    </nav>

    <#assign currentYear = "">
    <#assign currentMonth = "">

    <#list blogs as blog>
        <#if currentYear != blog.date?string["YYYY"]>
            <#assign currentYear = blog.date?string["YYYY"]>
            <h2>${currentYear}</h2>
        </#if>

        <#if currentMonth != blog.date?string["MMMM"]>
            <#assign currentMonth = blog.date?string["MMMM"]>
            <h3>${currentMonth}</h3>
        </#if>

        <ul>
            <li><a href="${blog.path}/${blog.filename}">${blog.title}</a></li>
        </ul>
    </#list>
</div>

</@tmpl.page>