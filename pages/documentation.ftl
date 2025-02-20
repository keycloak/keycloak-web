<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->

<@tmpl.page current="docs" title="Documentation">

<div class="container mt-5">
    <h1>Documentation <span class="badge bg-primary">${version.version}</span></h1>

    <#include "../templates/documentation-${version.documentationTemplate}.ftl">

    <p><a href="documentation-archive.html">Archived releases</a></p>
</div>

</@tmpl.page>