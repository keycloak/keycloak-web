<p>To download the release go to <a href="${home}/downloads.html">Keycloak downloads</a>.</p>

<#if version.releaseNotes??>
    <#include "../${version.releaseNotes}">
</#if>

<h2>All resolved issues</h2>
<p>The full list of resolved issues are available in <a href="https://issues.jboss.org/issues/?jql=project%20%3D%20keycloak%20and%20fixVersion%20%3D%20${version.version}">JIRA</a></p>

<h2>Upgrading</h2>
<p>Before you upgrade remember to backup your database and check the <a href="${home}/docs/latest/upgrading/index.html">upgrade guide</a> for anything that may have changed.</p>