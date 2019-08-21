<#assign title = "Documentation Archive" noindex = true>

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Documentation Archive</h1>

        <ol class="breadcrumb">
            <li><a href="documentation.html">Documentation</a></li>
            <li class="active">Archive</li>
        </ol>

        <ul>
        <#list versionsShorter as version>
            <li><a href="archive/documentation-${version.versionShorter}.html">${version.versionShorter}</a></li>
        </#list>
        </ul>
    </div>
</div>

<#include "../templates/footer.ftl">