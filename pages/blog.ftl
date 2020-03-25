<#assign title = "Blog">
<#assign includeRelease = true>
<#assign displayed = 0>

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section cards-section">
    <div class="container">
        <div class="row">
            <#list blogs as blog>
                <#if !blog.release || includeRelease>
                    <div class="col-sm-12">
                        <a href="${links.get(blog)}">
                        <div class="card">
                            <div class="card-body">
                                <h2 class="card-title">${blog.title}</h2>
                                <p class="card-date">${blog.date?string["EEEE, MMMM dd YYYY"]}<#if blog.author??>, posted by ${blog.author}</#if></p>

                                <#if blog.summary??>
                                <p class="card-text">${blog.summary}</p>
                                </#if>
                            </div>
                        </div>
                        </a>
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
        </div>

        <div class="row">
        <div class="col-sm-6">
        <h3>For older entries go <a href="blog-archive.html">here</a></h3>
        </div>
        <div class="col-sm-6">
        <h3><a class="float-right" href="${links.rss}"><img src="resources/images/rss.png"/></a></h3>
        </div>
        </div>
    </div>
</div>

<#include "../templates/footer.ftl">