<#assign title = "Blog Archive">
<#assign currentYear = "">
<#assign currentMonth = "">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Blog Archive</h1>

        <ol class="breadcrumb">
            <li><a href="blog.html">Blog</a></li>
            <li class="active">Archive</li>
        </ol>

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
                <li><a href="blog/${blog.filename}">${blog.title}</a></li>
            </ul>
        </#list>
    </div>
</div>
<#include "../templates/footer.ftl">