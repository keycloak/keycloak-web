<#assign title = "Extensions">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<#macro extension name description maintainers website download documentation source>

    <h2>${name}</h2>

    <p>${description}</p>

    <table class="table-extensions">
        <#if maintainers?has_content><tr><th>Maintainers</th><td><#list maintainers as maintainer><a href="https://github.com/${maintainer}">${maintainer}</a></#list></td></#if>
        <#if website?has_content><tr><th>Website</th><td><a href="${website}">${website}</a></td></#if>
        <#if download?has_content><tr><th>Download</th><td><a href="${download}">${download}</a></td></#if>
        <#if documentation?has_content><tr><th>Documentation</th><td><a href="${documentation}">${documentation}</a></td></#if>
        <#if source?has_content><tr><th>Source</th><td><a href="${source}">${source}</a></td></#if>
    </table>

</#macro>



<div class="page-section">
    <div class="container">
        <h1>Extensions</h1>

        <@extension
            name="Japanse documentation translation"
            description="Complete Japanse translation of the original Keycloak documentation"
            maintainers=["missing"]
            website="http://keycloak-documentation.openstandia.jp/"
            download=""
            documentation=""
            source=""
        />
    </div>
</div>

<#include "../templates/footer.ftl">
