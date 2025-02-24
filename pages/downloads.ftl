<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->

<@tmpl.page current="downloads" title="downloads" summary="Download the latest release of Keycloak from this page.">

<div class="container mt-5">
    <h1>Downloads <span class="badge bg-primary">${version.version}</span></h1>

    <p>
        For a list of community maintained extensions check out the <a href="${links.extensions}">Extensions</a> page.
    </p>

    <#include "../templates/downloads-${version.downloadTemplate}.ftl">

    <#if !version.final>
        <p>This is a <b>release candidate</b>. The latest final release is <a href="archive/downloads-${versions[1].versionShort}.html">${versions[1].versionShort}</a>.</p>
    </#if>

    <p><a href="downloads-archive.html">Archived releases</a> | <a href="${links.nightly}">Nightly release</a> | <a href="${links.getLink('keys')}">Signing keys</a></p>
</div>

<script>
    window.kc_version = '${version.version}';
</script>
<script src="${root}resources/js/downloads.js" type="text/javascript"></script>

</@tmpl.page>