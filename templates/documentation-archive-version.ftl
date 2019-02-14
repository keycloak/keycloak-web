<#assign title = "Documentation Archive - ${version.versionShort}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Documentation - ${version.versionShorter}</h1>

        <ol class="breadcrumb">
            <li><a href="${root}documentation.html">Documentation</a></li>
            <li><a href="${root}documentation-archive.html">Archive</a></li>
            <li class="active">${version.versionShorter}</li>
        </ol>

        <#include "documentation-${version.documentationTemplate}.ftl">
    </div>
</div>
<#include "../templates/footer.ftl">