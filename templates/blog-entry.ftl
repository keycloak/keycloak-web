<#assign title = "Blog - ${blog.title}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container blog">
        <h1>${blog.title}</h1>
        <p class="blog-date">${blog.date?string["EEEE, MMMM dd YYYY"]}<#if blog.author??>, posted by ${blog.author}</#if></p>

        <#include "../${blog.template}">
    </div>
</div>
<#include "../templates/footer.ftl">
