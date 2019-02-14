<#assign title = "Downloads Archive - ${version.versionShort}">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Downloads - ${version.version}</h1>

        <ol class="breadcrumb">
            <li><a href="${root}downloads.html">Downloads</a></li>
            <li><a href="${root}downloads-archive.html">Archive</a></li>
            <li class="active">${version.versionShort}</li>
        </ol>

        <#include "downloads-${version.downloadTemplate}.ftl">
    </div>
</div>
<#include "../templates/footer.ftl">