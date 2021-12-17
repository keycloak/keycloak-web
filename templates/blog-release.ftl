<p>To download the release go to <a href="${home}/downloads.html">Keycloak downloads</a>.</p>

<#if version.releaseNotes??>
    <#include "../${version.releaseNotes}">
</#if>

<h2>All resolved issues</h2>
<p>The full list of resolved issues are available in <a href="https://github.com/issues?q=is%3Aissue+user%3Akeycloak+is%3Aclosed+milestone%3A${version.version}">GitHub Issues</a></p>

<h2>Upgrading</h2>
<p>Before you upgrade remember to backup your database and check the <a href="${home}/docs/latest/upgrading/index.html">upgrade guide</a> for anything that may have changed.</p>
