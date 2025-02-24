<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="keys" title="Keycloak Signing Keys">

<div class="container mt-5">
    <h1>Keycloak Signing Keys</h1>

    <p>
        We use a number of keys to sign artifacts. At the moment we are only signing Maven artifacts and
        the Terraform provider, but are looking to expanding this to downloads from the website and containers
        in the future.
    </p>

    <table class="table table-bordered table-striped">
        <tr>
            <th>ID</th>
            <th>UID</th>
            <th>Usage</th>
            <th>Key</th>
        </tr>
        <tr>
            <td>861ab50e8cc6611fb6bc01a6b8f12ea26fd6eeba</td>
            <td>Keycloak Bot<br/>keycloak.bot@gmail.com</td>
            <td>Maven artifacts after January 2024</td>
            <td>
                <a href="${links.root}/keys/keycloak-2.asc">
                    <i class="fa fa-download" aria-hidden="true"></i>
                    asc
                </a>
            </td>
        </tr>
        <tr>
            <td>d77f6183986627e454951a5ca63faed146e27e2a</td>
            <td>Keycloak Terraform Team<br/>keycloak-maintainers@googlegroups.com</td>
            <td>Terraform provider</td>
            <td>
                <a href="${links.root}/keys/keycloak-terraform-1.asc">
                    <i class="fa fa-download" aria-hidden="true"></i>
                    asc
                </a>
            </td>
        </tr>
    </table>
</div>

</@tmpl.page>
