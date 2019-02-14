<#assign title = "Blog">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <#list blogs as blog>
            <h1>${blog.title}</h1>
            <p class="blog-date">${blog.date?string["EEEE, MMMM dd, YYYY"]}</p>

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