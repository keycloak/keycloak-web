<#macro download category label file tar=true zip=true tgz=false>
<#if zip>
<span class="me-4">
<a onclick="dl('${category}', '${label}');" href="https://github.com/keycloak/keycloak/releases/download/${version.version}/${file}.zip" target="_blank">
    <i class="fa fa-download" aria-hidden="true"></i>
    ZIP
</a>
(<a href="https://github.com/keycloak/keycloak/releases/download/${version.version}/${file}.zip.sha1" target="_blank">sha1</a>)
</span>
</#if>
<#if tar>
<span>
<a onclick="dl('${category}', '${label}');" href="https://github.com/keycloak/keycloak/releases/download/${version.version}/${file}.tar.gz" target="_blank">
    <i class="fa fa-download" aria-hidden="true"></i>
    TAR.GZ
</a>
(<a href="https://github.com/keycloak/keycloak/releases/download/${version.version}/${file}.tar.gz.sha1" target="_blank">sha1</a>)
</span>
</#if>
<#if tgz>
<span>
<a onclick="dl('${category}', '${label}');" href="https://github.com/keycloak/keycloak/releases/download/${version.version}/${file}.tgz" target="_blank">
    <i class="fa fa-download" aria-hidden="true"></i>
    TGZ
</a>
</span>
</#if>
</#macro>

<h2 class="mt-4">Server</h2>

<table class="table table-bordered table-striped">
    <tbody>
    <tr>
        <td>Keycloak</td>
        <td>Distribution powered by Quarkus</td>
        <td>
            <@download category="server" label="standalone" file="keycloak-${version.version}" />
        </td>
    </tr>
    <tr>
        <td>Container image</td>
        <td>For Docker, Podman, Kubernetes and OpenShift</td>
        <td>
            <a href="https://quay.io/repository/keycloak/keycloak" target="_blank">
                <i class="fa fa-link"></i>
                Quay
            </a>
        </td>
    </tr>
    <tr>
        <td>Operator</td>
        <td>For Kubernetes and OpenShift</td>
        <td>
            <a href="https://operatorhub.io/operator/keycloak-operator" target="_blank">
                <i class="fa fa-link"></i>
                OperatorHub
            </a>
        </td>
    </tr>
    <tr>
        <td>Third-party licenses</td>
        <td>License and source code information for third-party dependencies</td>
        <td>
            <a href="https://github.com/keycloak/keycloak/releases/download/${version.version}/third-party-notice-keycloak.html" target="_blank">
                <i class="fa fa-file"></i>
                HTML
            </a>
        </td>
    </tr>
    </tbody>
</table>

<h2 class="mt-4">Quickstarts</h2>
<table class="table table-bordered table-striped">
    <tbody>

    <tr>
        <td>Quickstarts distribution</td>
        <td>
            <span class="me-4">
            <#if quickstartsTag??>
                <#assign quickstartsLink="https://github.com/keycloak/keycloak-quickstarts/tree/${version.version}"/>
            <#else>
                <#assign quickstartsLink="https://github.com/keycloak/keycloak-quickstarts"/>
            </#if>

            <a onclick="dl('examples', 'quickstarts');" href="${quickstartsLink}" target="_blank">
                <i class="fab fa-github" aria-hidden="true"></i>
                GitHub
            </a>
            </span>
            <span>
            <a onclick="dl('examples', 'quickstarts');" href="https://github.com/keycloak/keycloak-quickstarts/archive/latest.zip" target="_blank">
                <i class="fa fa-download" aria-hidden="true"></i>
                ZIP
            </a>
            </span>
        </td>
    </tr>
    </tbody>
</table>


<h2 class="mt-4">Client Adapters</h2>

<div>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active margin-top" id="oidc">
            <table class="table table-bordered table-striped">
                <#assign versionCompare=staticMethods['org.keycloak.webbuilder.Versions$Version']>
                <#if versionCompare.compareToVersions(version.version, '26.2.0') lt 0 >
                    <tr>
                        <td>JavaScript</td>
                        <td>
                        </td>
                        <td>
                            <table class="kc-table-downloads-inner">
                                <tr>
                                    <td></td>
                                    <td>
                                        <span class="me-4">
                                        <a href="https://www.npmjs.com/package/keycloak-js/v/${version.version}" target="_blank">
                                            <i class="fa fa-link"></i> NPM
                                        </a>
                                        </span>
                                        <@download category="adapter" label="js" file="keycloak-js-${version.version}" zip=false tar=false tgz=true />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </#if>
                <tr>
                    <td>JavaScript[separate release] (${jsLatestVersion.version})</td>
                    <td>
                        <a href="downloads-js-archive.html">Archived releases</a>
                    </td>
                    <td>
                        <table class="kc-table-downloads-inner">
                            <tr>
                                <td></td>
                                <td>
                                    <span class="me-4">
                                    <a href="https://www.npmjs.com/package/keycloak-js/v/${jsLatestVersion.version}" target="_blank">
                                        <i class="fa fa-link"></i> NPM
                                    </a>
                                    </span>
                                    <span>
                                    <a onclick="dl('adapter', 'js');" href="https://github.com/keycloak/keycloak-js/releases/download/${jsLatestVersion.version}/keycloak-js-${jsLatestVersion.version}.tgz" target="_blank">
                                        <i class="fa fa-download" aria-hidden="true"></i>
                                        TGZ
                                    </a>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td>Node.js <b>[DEPRECATED]</b></td>
                    <td></td>
                    <td>
                        <table class="kc-table-downloads-inner">
                            <tr>
                                <td></td>
                                <td>
                                    <a href="https://www.npmjs.com/package/keycloak-connect/v/${version.version}" target="_blank">
                                        <i class="fa fa-link"></i> NPM
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

    </div>
</div>
