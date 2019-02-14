<#assign title = "Extensions">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Extensions</h1>

        <#list extensions as extension>
            <h2>${extension.name}</h2>

            <p>${extension.description}</p>

            <table class="table-extensions">
                <#if extension.maintainers?has_content><tr><th>Maintainers</th><td><#list extension.maintainers as maintainer><a href="https://github.com/${maintainer}">${maintainer}</a><#sep>, </#sep></#list></td></#if>
                <#if extension.website?has_content><tr><th>Website</th><td><a href="${extension.website}">${extension.website}</a></td></#if>
                <#if extension.download?has_content><tr><th>Download</th><td><a href="${extension.download}">${extension.download}</a></td></#if>
                <#if extension.documentation?has_content><tr><th>Documentation</th><td><a href="${extension.documentation}">${extension.documentation}</a></td></#if>
                <#if extension.source?has_content><tr><th>Source</th><td><a href="${extension.source}">${extension.source}</a></td></#if>
            </table>
        </#list>
    </div>
</div>

<#include "../templates/footer.ftl">
