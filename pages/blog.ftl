<#assign title = "Blog">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <#list blogs as blog>
            <h1><a href="${root}${blog.path}/${blog.filename}">${blog.title}</a></h1>
            <p class="blog-date">${blog.date?string["EEEE, MMMM dd YYYY"]}<#if blog.author??>, posted by ${blog.author}</#if></p>

            <#include "../${blog.template}">

            <hr/>

            <#if blog?counter == config.maxBlog>
                <#break>
            </#if>
        </#list>
        For older entries go <a href="blog-archive.html">here</a>.
    </div>
</div>
<#include "../templates/footer.ftl">