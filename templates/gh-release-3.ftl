<div>
<#if version.releaseNotes??>
    <h2>Highlights</h2>
    <#include "../${version.releaseNotes}">
</#if>

<h2>Upgrading</h2>
<p>Before upgrading refer to <a href="${home}/docs/latest/upgrading/index.html#migration-changes">the migration guide</a> for a complete list of changes.</p>

<#if version.changes?? && version.changes.all?has_content>
<h2>All resolved issues</h2>

<#if version.changes.deprecations?has_content>
<h3>Deprecated features</h3>
<ul>
<#list version.changes.deprecations as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <#if c.area?has_content><code>${c.area}</code></#if></li>
</#list>
</ul>
</#if>

<#if version.changes.features?has_content>
<h3>New features</h3>
<ul>
<#list version.changes.features as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <#if c.area?has_content><code>${c.area}</code></#if></li>
</#list>
</ul>
</#if>

<#if version.changes.enhancements?has_content>
<h3>Enhancements</h3>
<ul>
<#list version.changes.enhancements as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <#if c.area?has_content><code>${c.area}</code></#if></li>
</#list>
</ul>
</#if>

<#if version.changes.bugs?has_content>
<h3>Bugs</h3>
<ul>
<#list version.changes.bugs as c>
<li><a href="${c.url}">#${c.number?string("#####")}</a> ${c.title} <#if c.area?has_content><code>${c.area}</code></#if></li>
</#list>
</ul>
</#if>

</#if>
</div>