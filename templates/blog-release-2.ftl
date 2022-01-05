<p>To download the release go to <a href="${home}/downloads.html">Keycloak downloads</a>.</p>

<#if version.releaseNotes??>
    <h2>Release notes</h2>
    <#include "../${version.releaseNotes}">
</#if>

<h2>Migration from ${versionPrevious.versionShorter}</h2>
<p>Before you upgrade remember to backup your database. If you are not on the previous release refer to <a href="${home}/docs/latest/upgrading/index.html#migration-changes">the documentation</a> for a complete list of migration changes.</p>

<#if version.migrationNotes??>
    <#include "../${version.migrationNotes}">
</#if>

<#if version.changes??>
<h2>All resolved issues</h2>

<#if version.changes.deprecations?has_content>
<h3>Deprecated features</h3>
<ul>
<#list version.changes.deprecations as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <span class="badge bg-secondary">${c.repository} ${c.area!}</span></li>
</#list>
</ul>
</#if>

<#if version.changes.features?has_content>
<h3>New features</h3>
<ul>
<#list version.changes.features as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <span class="badge bg-secondary">${c.repository} ${c.area!}</span></li>
</#list>
</ul>
</#if>

<#if version.changes.enhancements?has_content>
<h3>Enhancements</h3>
<ul>
<#list version.changes.enhancements as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <span class="badge bg-secondary">${c.repository} ${c.area!}</span></li>
</#list>
</ul>
</#if>

<#if version.changes.bugs?has_content>
<h3>Bugs</h3>
<ul>
<#list version.changes.bugs as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <span class="badge bg-secondary">${c.repository} ${c.area!}</span></li>
</#list>
</ul>
</#if>

</#if>

<h2>Upgrading</h2>
<p>Before you upgrade remember to backup your database and check the <a href="${home}/docs/latest/upgrading/index.html">upgrade guide</a> for anything that may have changed.</p>
