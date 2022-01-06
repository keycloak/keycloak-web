<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="docs" title="Documentation">

<div class="container mt-5">
    <h1>Documentation <span class="badge bg-primary">${version.version}</span></h1>

    <#include "../templates/documentation-${version.documentationTemplate}.ftl">

    <h4 class="mt-4">For previous releases go <a href="documentation-archive.html">here</a>.</h4>
</div>

</@tmpl.page>