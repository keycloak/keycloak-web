<#assign title = "Blog">
<#assign includeRelease = true>
<#assign displayed = 0>

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <a class="float-right" href="${links.rss}"><img src="resources/images/rss.png"/></a>
        <#list blogs as blog>
            <#if !blog.release || includeRelease>
                <h1><a href="${root}${blog.path}/${blog.filename}">${blog.title}</a></h1>

                <p class="blog-date">${blog.date?string["EEEE, MMMM dd YYYY"]}<#if blog.author??>, posted by ${blog.author}</#if></p>

                <div class="blog blog-container">
                    <#include "../${blog.template}">
                </div>

                <#if blog.release>
                    <#assign includeRelease = false>
                </#if>

                <#assign displayed = displayed + 1>
            </#if>

            <#if displayed == config.maxBlog>
                <#break>
            </#if>
        </#list>

        <h3>For older entries go <a href="blog-archive.html">here</a>.</h3>
    </div>
</div>
<#include "../templates/footer.ftl">