<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="nightly" title="Nightly Release" noindex=true summary="Keycloak's nightly release which contains the very latest developments. Use it for testing only.">

<div class="container mt-5">
    <h1>Nightly release</h1>

    <div class="alert alert-warning" role="alert">
      <h4>Do not use nightly releases in production environments.</h4>

      Migration is not supported for nightly releases. Always use an empty database, or a copy of the database, when deploying a nightly release.
      Nightly releases may also contain regressions or features that are not ready for usage.
    </div>

    <p>
        We provide a nightly release of Keycloak that serves of a preview of what is coming in the next release. The aim
        is to get early feedback from the community on new features, on bug fixes, or other enhancements. We also
        encourage extension developers to continuously test their extensions with the nightly release.
    </p>

    <p>
        The nightly release is built every night from main branches, and will overwrite the previous nightly release.
    </p>

    <h2 class="mt-4">Server</h2>

    <table class="table table-bordered table-striped">
        <tbody>
        <tr>
            <td>Keycloak</td>
            <td>
                <span class="me-4">
                    <a href="https://github.com/keycloak/keycloak/releases/download/nightly/keycloak-999.0.0-SNAPSHOT.zip" target="_blank">
                        <i class="fa fa-download" aria-hidden="true"></i>ZIP
                    </a>
                </span>
                <span class="me-4">
                    <a href="https://github.com/keycloak/keycloak/releases/download/nightly/keycloak-999.0.0-SNAPSHOT.tar.gz" target="_blank">
                        <i class="fa fa-download" aria-hidden="true"></i>TAR.GZ
                    </a>
                </span>
            </td>
        </tr>
        <tr>
            <td>Container image</td>
            <td>
                <a href="https://quay.io/repository/keycloak/keycloak" target="_blank">
                    <i class="fa fa-link"></i>
                    quay.io/keycloak/keycloak:nightly
                </a>
            </td>
        </tr>
        <tr>
            <td>Operator</td>
            <td>
                <a href="https://quay.io/repository/keycloak/keycloak-operator" target="_blank">
                    <i class="fa fa-link"></i>
                    quay.io/keycloak/keycloak-operator:nightly
                </a>
            </td>
        </tr>
        </tbody>
    </table>

    <h2 class="mt-4">Documentation</h2>

    <table class="table table-bordered table-striped">
        <tbody>
        <tr>
            <td>
                <a href="${links.getLink('nightly/guides')}">Guides</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.keycloak.org/docs/nightly/">Documentation</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.keycloak.org/docs-api/nightly/">JavaDoc</a>
            </td>
        </tr>
        </tbody>
    </table>

    <h2 class="mt-4">Maven</h2>

    <p>
        For extension development and client adapters all Maven artifacts are included in the nightly release. Use the
        version <code>999.0.0-SNAPSHOT</code> to the nightly release artifacts.
    </p>

    <p>
        You also need to enable Sonatype Snapshots repository by adding the following to the <code>pom.xml</code> file:
    </p>

<pre>
&lt;repositories&gt;
    &lt;repository&gt;
        &lt;id&gt;sonatype-snapshots&lt;/id&gt;
        &lt;name&gt;Sonatype Snapshots&lt;/name&gt;
        &lt;url&gt;https://s01.oss.sonatype.org/content/repositories/snapshots/&lt;/url&gt;
        &lt;snapshots&gt;
            &lt;enabled&gt;true&lt;/enabled&gt;
            &lt;updatePolicy&gt;daily&lt;/updatePolicy&gt;
        &lt;/snapshots&gt;
    &lt;/repository&gt;
&lt;/repositories&gt;
</pre>
</div>


</@tmpl.page>