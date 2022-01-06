<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="docs" title="Documentation ${version.versionShorter}" noindex=true>

<div class="container mt-5">
    <h1>Documentation <span class="badge bg-primary">${version.versionShorter}</span></h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../documentation.html">Documentation</a></li>
        <li class="breadcrumb-item"><a href="../documentation-archive.html">Archive</a></li>
        <li class="breadcrumb-item active">${version.versionShorter}</li>
    </ol>
    </nav>

    <#include "documentation-${version.documentationTemplate}.ftl">
</div>
</@tmpl.page>