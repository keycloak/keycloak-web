<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="docs" title="Downloads ${version.versionShorter}" noindex=true>

<div class="container mt-5">
    <h1>Documentation <span class="badge bg-primary">${version.versionShorter}</span></h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../downloads.html">Downloads</a></li>
        <li class="breadcrumb-item"><a href="../downloads-archive.html">Archive</a></li>
        <li class="breadcrumb-item active">${version.versionShorter}</li>
    </ol>
    </nav>

    <#assign quickstartsTag=true/>
    <#include "downloads-${version.downloadTemplate}.ftl">
</div>
</@tmpl.page>