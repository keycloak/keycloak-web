<#macro download category label file tar>
<a onclick="dl('${category}', '${label}');" href="https://downloads.jboss.org/keycloak/${version.version}/${file}.zip" target="_blank">
    <i class="fa fa-download" aria-hidden="true"></i>
    ZIP
</a>
(<a href="https://downloads.jboss.org/keycloak/${version.version}/${file}.zip.md5" target="_blank">md5</a>)
<#if tar>
<span class="space"></span>
<a onclick="dl('${category}', '${label}');" href="https://downloads.jboss.org/keycloak/${version.version}/${file}.tar.gz" target="_blank">
    <i class="fa fa-download" aria-hidden="true"></i>
    TAR.GZ
</a>
(<a href="https://downloads.jboss.org/keycloak/${version.version}/${file}.tar.gz.md5" target="_blank">md5</a>)
</#if>
</#macro>

<h2>Server</h2>

<table class="table table-bordered table-striped">
    <tbody>
    <tr>
        <td>Server</td>
        <td>Standalone server distribution</td>
        <td>
            <@download category="server" label="standalone" file="keycloak-${version.version}" tar=true />
        </td>
    </tr>
    <tr>
        <td>Overlay</td>
        <td>Server add-on for WildFly. Not recommended in production.</td>
        <td>
            <@download category="overlay" label="standalone" file="keycloak-overlay-${version.version}" tar=true />
        </td>
    </tr>
    <tr>
        <td>Demo</td>
        <td>Demo distribution. Not recommended in production.</td>
        <td>
            <@download category="demo" label="demo" file="keycloak-demo-${version.version}" tar=true />
        </td>
    </tr>
    </tbody>
</table>


<h2>Examples</h2>

<table class="table table-bordered table-striped">
    <tbody>

    <tr>
        <td>Quickstarts distribution</td>
        <td>
            <a onclick="dl('examples', 'quickstarts');" href="https://github.com/keycloak/keycloak-quickstarts" target="_blank">
                <i class="fa fa-github" aria-hidden="true"></i>
                GitHub
            </a>
            <span class="space"></span>
            <a onclick="dl('examples', 'quickstarts');" href="https://github.com/keycloak/keycloak-quickstarts/archive/latest.zip" target="_blank">
                <i class="fa fa-download" aria-hidden="true"></i>
                ZIP
            </a>
        </td>
    </tr>
    <tr>
        <td>Old examples</td>
        <td>
            <@download category="examples" label="examples" file="keycloak-examples-${version.version}" tar=false />
        </td>
    </tr>
    </tbody>
</table>


<h2>Client Adapters</h2>

<div>
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#oidc" aria-controls="oidc" role="tab" data-toggle="tab">OpenID Connect</a></li>
        <li role="presentation"><a href="#saml" aria-controls="saml" role="tab" data-toggle="tab">SAML 2.0</a></li>
    </ul>

    <div class="tab-content">

        <div role="tabpanel" class="tab-pane active margin-top" id="oidc">
            <table class="table table-bordered table-striped">
                <tr>
                    <td>Keycloak Proxy</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <@download category="proxy" label="proxy" file="keycloak-proxy-${version.version}" tar=false />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>WildFly</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>10, 9</td>
                                <td>
                                    <@download category="adapter" label="wildfly" file="adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td>
                                    <@download category="adapter" label="wf8" file="adapters/keycloak-oidc/keycloak-wf8-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JBoss EAP</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>7</td>
                                <td>
                                    <@download category="adapter" label="eap7" file="adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>
                                    <@download category="adapter" label="eap6" file="adapters/keycloak-oidc/keycloak-eap6-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JBoss AS</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>7.1</td>
                                <td>
                                    <@download category="adapter" label="as7" file="adapters/keycloak-oidc/keycloak-as7-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JBoss Fuse</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>6.2, 6.3</td>
                                <td>
                                    <@download category="adapter" label="fuse" file="adapters/keycloak-oidc/keycloak-fuse-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JavaScript</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td></td>
                                <td>
                                    <@download category="adapter" label="js" file="adapters/keycloak-oidc/keycloak-js-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>Jetty</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>9.4</td>
                                <td>
                                    <@download category="adapter" label="jetty9.4" file="adapters/keycloak-oidc/keycloak-jetty94-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>9.3</td>
                                <td>
                                    <@download category="adapter" label="jetty9.3" file="adapters/keycloak-oidc/keycloak-jetty93-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>9.2</td>
                                <td>
                                    <@download category="adapter" label="jetty9.2" file="adapters/keycloak-oidc/keycloak-jetty92-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>9.1</td>
                                <td>
                                    <@download category="adapter" label="jetty9.1" file="adapters/keycloak-oidc/keycloak-jetty91-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>8.1</td>
                                <td>
                                    <@download category="adapter" label="jetty8.1" file="adapters/keycloak-oidc/keycloak-jetty81-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>Tomcat</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>8</td>
                                <td>
                                    <@download category="adapter" label="tomcat8" file="adapters/keycloak-oidc/keycloak-tomcat8-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>
                                    <@download category="adapter" label="tomcat7" file="adapters/keycloak-oidc/keycloak-tomcat7-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>
                                    <@download category="adapter" label="tomcat6" file="adapters/keycloak-oidc/keycloak-tomcat6-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div role="tabpanel" class="tab-pane margin-top" id="saml">
            <table class="table table-bordered table-striped">
                <tbody>
                <tr>
                    <td>WildFly</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>10, 9</td>
                                <td>
                                    <@download category="adapter-saml" label="wildfly" file="adapters/saml/keycloak-saml-wildfly-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JBoss EAP</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>7</td>
                                <td>
                                    <@download category="adapter-saml" label="eap7" file="adapters/saml/keycloak-saml-wildfly-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>
                                    <@download category="adapter-saml" label="eap6" file="adapters/saml/keycloak-saml-eap6-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>JBoss AS</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>7.1</td>
                                <td>
                                    <@download category="adapter-saml" label="as7" file="adapters/saml/keycloak-saml-as7-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>Jetty</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>9.4</td>
                                <td>
                                    <@download category="adapter-saml" label="jetty9.4" file="adapters/saml/keycloak-saml-jetty94-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>9.3</td>
                                <td>
                                    <@download category="adapter-saml" label="jetty9.3" file="adapters/saml/keycloak-saml-jetty93-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>9.2</td>
                                <td>
                                    <@download category="adapter-saml" label="jetty9.2" file="adapters/saml/keycloak-saml-jetty92-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>8.1</td>
                                <td>
                                    <@download category="adapter-saml" label="jetty8.1" file="adapters/saml/keycloak-saml-jetty81-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>Tomcat</td>
                    <td>
                        <table class="table-downloads-inner">
                            <tr>
                                <td>8</td>
                                <td>
                                    <@download category="adapter-saml" label="tomcat8" file="adapters/saml/keycloak-saml-tomcat8-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>
                                    <@download category="adapter-saml" label="tomcat7" file="adapters/saml/keycloak-saml-tomcat7-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>
                                    <@download category="adapter-saml" label="tomcat6" file="adapters/saml/keycloak-saml-tomcat6-adapter-dist-${version.version}" tar=true />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
