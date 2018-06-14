<#assign title = "Documentation">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Documentation</h1>

        <p>${version.version} - <a href="${root}docs/latest/release_notes/index.html">Release notes</a></p>

        <#include "../templates/documentation-${version.documentationTemplate}.ftl">

        <p>
        <#if !version.final>
            This is a <b>release candidate</b>. The latest final release is <a href="archive/documentation-${versions[1].versionShorter}.html">${versions[1].versionShorter}</a>.
        </#if>
            For older releases go <a href="documentation-archive.html">here</a>.
        </p>
    </div>
</div>

<#include "../templates/footer.ftl">