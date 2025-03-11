<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="downloads" title="Downloads of Keycloak JS archive" noindex=true summary="Archive of Keycloak JS downloads for earlier releases.">

<div class="container mt-5 kc-article">
    <h1>Downloads of Keycloak JS archive</h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="downloads.html">Downloads</a></li>
        <li class="breadcrumb-item active">Archive</li>
    </ol>
    </nav>

    <ul>
    <#list jsVersions as version>
        <li><a href="https://github.com/keycloak/keycloak-js/releases/download/${version.version}/keycloak-js-${version.version}.tgz">${version.version}</a></li>
    </#list>
    </ul>
</div>

</@tmpl.page>