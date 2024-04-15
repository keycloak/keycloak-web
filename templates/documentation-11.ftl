<h2 class="mt-4">Guides</h2>

<#if archive>
    <#assign docRoot = "${root}docs/${version.version}">
    <#assign docApiRoot = "${root}docs-api/${version.version}">
<#else>
    <#assign docRoot = "${root}docs/latest">
    <#assign docApiRoot = "${root}docs-api/latest">
</#if>

<table class="table table-bordered table-striped">
    <tbody>
    <tr>
        <td>
            <a href="${docRoot}/release_notes/index.html" target="_blank">
                Release Notes
            </a>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td>
            <a href="${links.guides}#getting-started">
                Getting Started
            </a>
        </td>
        <td>
            How to get started with Keycloak
        </td>
    </tr>
    <tr>
        <td>
            <a href="${links.guides}#server">
                Server Installation and Configuration
            </a>
        </td>
        <td>
            Installation and offline configuration of the Keycloak server
        </td>
    </tr>
    <tr>
        <td>
            <a href="${links.get(guides.getGuide('server', 'containers'))}">
                Server Container Image
            </a>
        </td>
        <td>
            Documentation specific to the server container image
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docRoot}/securing_apps/index.html" target="_blank">
                Securing Applications and Services
            </a>
        </td>
        <td>
            How to secure applications and services with Keycloak
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docRoot}/server_admin/index.html" target="_blank">
                Server Administration
            </a>
        </td>
        <td>
            Management and runtime configuration of the Keycloak server
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docRoot}/server_development/index.html" target="_blank">
                Server Developer
            </a>
        </td>
        <td>
            Creating themes and providers to customize the Keycloak server
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docRoot}/authorization_services/index.html" target="_blank">
                Authorization Services
            </a>
        </td>
        <td>
            Centrally manage fine-grained permissions for applications and services
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docRoot}/upgrading/index.html" target="_blank">
                Upgrading
            </a>
        </td>
        <td>
            Upgrading Keycloak server and adapters
        </td>
    </tr>
    </tbody>
</table>

<h2 class="mt-4">API Documentation</h2>

<table class="table table-bordered table-striped">
    <tbody>
    <tr>
        <td>
            <a href="${docApiRoot}/javadocs/index.html" target="_blank">
                JavaDoc
            </a>
        </td>
        <td>
            Documentation for Java API
        </td>
    </tr>
    <tr>
        <td>
            <a href="${docApiRoot}/rest-api/index.html" target="_blank">
                Administration REST API
            </a>
        </td>
        <td>
            Documentation for the Adminstration RESTful API
        </td>
    </tr>
    </tbody>
</table>
