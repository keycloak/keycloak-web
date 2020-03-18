<#assign title = "Guide - ${guide.title}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container blog">
        <h1>${guide.title}</h1>
        <p>${guide.summary}</p>

        <#include "../${guide.template}">
    </div>
</div>
<#include "../templates/footer.ftl">
