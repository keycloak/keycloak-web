<#assign title = "Downloads Archive" noindex = true>

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Downloads Archive</h1>

        <ol class="breadcrumb">
            <li><a href="downloads.html">Downloads</a></li>
            <li class="active">Archive</li>
        </ol>

        <ul>
        <#list versions as version>
            <li><a href="archive/downloads-${version.versionShort}.html">${version.versionShort}</a></li>
        </#list>
        </ul>
    </div>
</div>
<#include "../templates/footer.ftl">