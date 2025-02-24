<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="docs" title="Documentation archive" noindex=true summary="Documentation for Keycloak release ${version.versionShorter}">

<div class="container mt-5 kc-article">
    <h1>Documentation archive</h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="documentation.html">Documentation</a></li>
        <li class="breadcrumb-item active">Archive</li>
    </ol>
    </nav>

    <ul>
    <#list versionsMajorMinor as version>
        <#if !version.latest>
            <li><a href="archive/documentation-${version.versionShorter}.html">${version.versionShorter}</a></li>
        </#if>
    </#list>
    </ul>
</div>

</@tmpl.page>