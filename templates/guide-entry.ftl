<#assign title = "Guide - ${guide.title}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container blog">
        <#if guide.community>
        <p class="community-badge text-primary">
            <i class="fa fa-users text-primary"></i> Contributed by <a href="https://github.com/${guide.author}">${guide.author}</a>
        </p>
        </#if>

        <h1>${guide.title}</h1>
        <#if guide.summary??>
        <p>${guide.summary}</p>
        </#if>

        <#include "../${guide.template}">
    </div>
</div>
<#include "../templates/footer.ftl">
