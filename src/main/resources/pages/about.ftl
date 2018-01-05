<#assign title = "About">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container about">
        <h1>About</h1>

        <p>
            Keycloak is an open source Identity and Access Management solution aimed at modern applications and services.
            It makes it easy to secure applications and services with little to no code.
        </p>

        <p>
            This page gives a brief introduction to Keycloak and some of the features. For a full list of features refer to the
            <a href="documentation.html">documentation</a>.
        </p>

        <p>
            Trying Keycloak is quick and easy. Take a look at the
            <a href="https://keycloak.gitbooks.io/documentation/getting_started/index.html">Getting Started tutorial</a>
            for details.
        </p>

        <hr class="divider"/>

        <h2>Single-Sign On</h2>

        <img src="resources/images/screen-login.png"/>

        <p>
            Users authenticate with Keycloak rather than individual applications. This means that your applications
            don't have to deal with login forms, authenticating users, and storing users. Once logged-in to
            Keycloak, users don't have to login again to access a different application.
        </p>

        <p>
            This also applied to logout. Keycloak provides single-sign out, which means users only have to logout once to be
            logged-out of all applications that use Keycloak.
        </p>

        <h3>Kerberos bridge</h3>

        <p>
            If your users authenticate to workstations with Kerberos (LDAP or active directory) they can also be
            automatically authenticated to Keycloak without having to provider their username and password again after
            they log on to the workstation.
        </p>

        <hr class="divider"/>

        <h2>Identity Brokering and Social Login</h2>

        <img src="resources/images/dia-identity-brokering.png"/>

        <p>
            Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the
            social network you want to add. No code or changes to your application is required.
        </p>

        <p>
            Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is
            just a matter of configuring the Identity Provider through the admin console.
        </p>

        <hr class="divider"/>

        <h2>User Federation</h2>

        <img src="resources/images/dia-user-fed.png"/>

        <p>
            Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own
            provider if you have users in other stores, such as a relational database.
        </p>

        <hr class="divider"/>

        <h2>Client Adapters</h2>

        <p>
            Keycloak Client Adapters makes it really easy to secure applications and services. We have adapters available for a
            number of platforms and programming languages, but if there's not one available for your chosen platform don't worry.
            Keycloak is built on standard protocols so you can use any OpenID Connect Resource Library or SAML 2.0 Service Provider
            library out there.
        </p>

        <p>
            You can also opt to use a proxy to secure your applications which removes the need to modify your application at all.
        </p>

        <hr class="divider"/>

        <h2>Admin Console</h2>

        <img src="resources/images/screen-admin.png"/>

        <p>
            Through the admin console administrators can centrally manage all aspects of the Keycloak server.
        </p>

        <p>
            They can enable and disable various features.  They can configure identity brokering and user federation.
        </p>

        <p>
            They can create and manage applications and services, and define fine-grained authorization
            policies.
        </p>

        <p>
            They can also manage users, including permissions and sessions.
        </p>

        <hr class="divider"/>

        <h2>Account Management Console</h2>

        <img src="resources/images/screen-account.png"/>

        <p>
            Through the account management console users can manage their own accounts. They can update the profile,
            change passwords, and setup two-factor authentication.
        </p>

        <p>
            Users can also manage sessions as well as view history for the account.
        </p>

        <p>
            If you've enabled social login or identity brokering users can also link their accounts with additional
            providers to allow them to authenticate to the same account with different identity providers.
        </p>

        <hr class="divider"/>

        <h2>Standard Protocols</h2>

        <img src="resources/images/dia-protocols.png"/>

        <p>
            Keycloak is based on standard protocols and provides support for OpenID Connect, OAuth 2.0, and SAML.
        </p>

        <hr class="divider"/>

        <h2>Authorization Services</h2>

        <p>
            If role based authorization doesn't cover your needs, Keycloak provides fine-grained authorization services as well.
            This allows you to manage permissions for all your services from the Keycloak admin console and gives you the
            power to define exactly the policies you need.
        </p>

    </div>
</div>

<#include "../templates/footer.ftl">
