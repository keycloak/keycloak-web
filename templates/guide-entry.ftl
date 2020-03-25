<#assign title = "Guide - ${guide.title}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container blog">
        <h1>${guide.title}</h1>
        <#if guide.summary??>
        <p>${guide.summary}</p>
        </#if>

        <#include "../${guide.template}">
    </div>
</div>
<#include "../templates/footer.ftl">
