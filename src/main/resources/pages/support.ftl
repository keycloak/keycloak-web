<#assign title = "Commercial Support">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Commercial Support</h1>

        <p>
            Red Hat does not provide commercial support for community open source projects directly.  Red Hat instead
            derives product offerings from community projects which are branded and maintained separately.  There are many reasons for
            this, but the bottom line is that Red Hat maintains and supports its products much longer than the lifespan
            of any particular version of an open source community project.
        </p>
        <p>
            The Red Hat product derived from the community Keycloak project is called
            <b>RH-SSO</b> (<i>Red Hat Single Sign On</i>).  Each release of <b>RH-SSO</b> derives from a specific Keycloak
            community version.  The following table describes this relationship.
        </p>
        <table class="table table-bordered table-striped">
            <tbody>
            <tr>
                <td>
                    RH-SSO 7.2.0.GA
                </td>
                <td>
                    Derived from Keycloak 3.4.3.Final
                </td>
            </tr>
            <tr>
                <td>
                    RH-SSO 7.1.0.GA
                </td>
                <td>
                    Derived from Keycloak 2.5.5.Final
                </td>
            </tr>
            <tr>
                <td>
                    RH-SSO 7.0.0.GA
                </td>
                <td>
                    Derived from Keycloak 1.9.8.Final
                </td>
            </tr>
            </tbody>
        </table>

        <h2>Buying Support</h2>

        <p>
            If you already have a JBoss Middleware support contract for one of the JBoss Middleware products (i.e. JBoss EAP, JBoss Data Grid, JBoss BRMS, etc.)
            you already have support for RH-SSO as it is covered under the <a href="https://access.redhat.com/collections/red-hat-jboss-core-services-collection">JBoss Core Services Collection</a>.  Each JBoss Middleware product, except JBoss Web Service, comes with support for RH-SSO automatically.
        </p>
        <p>
	    If you are not already a JBoss Middleware customer you have to buy a subscription to one of the JBoss Middleware products as RH-SSO does not have its own SKU.
	    You can purchase an online subscription for JBoss EAP <b><a href="https://www.redhat.com/en/store/red-hat-jboss-enterprise-application-platform#?sku=MW0196814">here</a></b>, which include support for RH-SSO, 
            or you can <a href="https://www.redhat.com/en/about/contact/sales">contact sales</a> if you are interested in something more comprehensive or need more information.
        </p>
        <p>
            Why can't you buy an RH-SSO subscription directly?
            RH-SSO is built on top of the JBoss EAP platform and leverages it extensively (JTA, JAX-RS, JPA, Infinispan).  If you have developed
            extensions to RH-SSO you may have leveraged parts of the JBoss EAP platform to write your extensions.  Many products
            under the RHEL umbrella are supported in a similar fashion.
        </p>

        <h2>Community vs. Product</h2>
        <p>
            The RH-SSO
            product derives from a specific version of the Keycloak community and is maintained, patched, and supported by Red Hat
            commercially for as long as the terms of your support contract.  The Keycloak community project, on the other hand, is <i>never</i>
            patched.  There are no point releases of the community project and each release may break backward compatibility.  New features
            are developed, experimented with, and baked in community then brought down to be supported in product if they are popular enough
            in community.  Think of Keycloak as bleeding edge with quick releases, unpatched, and limited community support, while RH-SSO is stable, supported
            for a long time, and patched as bugs and security vulnerabilities are found.
        </p>
    </div>
</div>

<#include "../templates/footer.ftl">
