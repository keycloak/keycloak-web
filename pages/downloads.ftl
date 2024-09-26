<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="downloads" title="downloads">

<div class="container mt-5">
    <h1>Downloads <span class="badge bg-primary">${version.version}</span></h1>

    <p>
        For a list of community maintained extensions check out the <a href="extensions.html">Extensions</a> page.
    </p>

    <#include "../templates/downloads-${version.downloadTemplate}.ftl">

    <#if !version.final>
        <p>This is a <b>release candidate</b>. The latest final release is <a href="archive/downloads-${versions[1].versionShort}.html">${versions[1].versionShort}</a>.</p>
    </#if>

    <p><a href="downloads-archive.html">Archived releases</a> | <a href="${links.nightly}">Nightly release</a></h4>
</div>

<script src="${root}resources/js/downloads.js" type="text/javascript"></script>

</@tmpl.page>