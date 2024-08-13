<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="home" title="" rss=true>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles">
  <div class="container pt-4 pb-4">
    <div class="row">
        <div class="col">
            <h1 class="fs-xlarge">Open Source Identity and Access Management</h1>
            <p class="fs-4">
                Add authentication to applications and secure services with minimum effort.<br/>
                No need to deal with storing users or authenticating users.
            </p>
            <p class="fs-4">
                Keycloak provides user federation, strong authentication, user management, fine-grained authorization, and more.
            </p>
            <div class="mt-5">
                <a class="btn btn-primary btn-lg" href="${links.guides}">Get Started</a>
                <a class="btn btn-light btn-lg" href="${links.downloads}">Download</a>
            </div>
            <div class="mt-1">
                Latest release ${version.version}
            </div>
        </div>
        <div class="col col-4 d-none d-lg-block">
            <img class="img-fluid" src="${links.getResource('images/icon.svg')}" width="550" aria-hidden="true" alt="Keycloak"/>
        </div>
    </div>
  </div>
</div>

<div class="jumbotron jumbotron-fluid bg-dark text-white">
<div class="container bg-dark p-3">
    <div class="row">
        <div class="col-md-1 col-sm-12 fw-bold">News</div>
        <#list news as n>
        <div class="col">
            <span class="badge bg-secondary">${n.date?string["dd MMM"]}</span> <a href="${n.link}">${n.title}</a>
        </div>
        </#list>
    </div>
</div>
</div>

<div class="container mt-5">
    <div class="row mt-5">
        <div class="col">
            <h2>Single-Sign On</h2>
            <p>
                Users authenticate with Keycloak rather than individual applications. This means that your applications
                don't have to deal with login forms, authenticating users, and storing users. Once logged-in to
                Keycloak, users don't have to login again to access a different application.
            </p>
            <p>
                This also applies to logout. Keycloak provides single-sign out, which means users only have to logout once to be
                logged-out of all applications that use Keycloak.
            </p>
        </div>
        <div class="col-5 text-end d-none d-md-block">
            <img class="img-fluid" src="resources/images/screen-login.png" alt="Screenshot showing a user's login screen as presented by Keycloak"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>Identity Brokering and Social Login</h2>
            <p>
                Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the
                social network you want to add. No code or changes to your application is required.
            </p>
            <p>
                Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is
                just a matter of configuring the Identity Provider through the admin console.
            </p>
        </div>
        <div class="col-5 text-end d-none d-md-block">
             <img class="img-fluid" src="resources/images/dia-identity-brokering.png" alt="Diagram illustrating brokering"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>User Federation</h2>
            <p>
                Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own
                provider if you have users in other stores, such as a relational database.
            </p>
        </div>
        <div class="col-5 text-end d-none d-md-block">
             <img class="img-fluid" src="resources/images/dia-user-fed.png" alt="Diagram illustrating user federation"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>Admin Console</h2>
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
        </div>
        <div class="col-5 text-end d-none d-md-block">
             <img class="img-fluid border" src="resources/images/screen-admin.png" alt="Screenshot of the admin console"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>Account Management Console</h2>
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
        </div>
        <div class="col-5 text-end d-none d-md-block">
             <img class="img-fluid border" src="resources/images/screen-account.png" alt="Screenshot of the account management console"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>Standard Protocols</h2>
            <p>
                Keycloak is based on standard protocols and provides support for OpenID Connect, OAuth 2.0, and SAML.
            </p>
        </div>
        <div class="col-5 text-end d-none d-md-block">
             <img class="img-fluid" src="resources/images/dia-protocols.png" alt="Logos of OpenID certification, SAML and OAuth 2.0" aria-hidden="true"/>
        </div>
    </div>

    <div class="row mt-5 border-top pt-5">
        <div class="col">
            <h2>Authorization Services</h2>
            <p>
                If role based authorization doesn't cover your needs, Keycloak provides fine-grained authorization services as well.
                This allows you to manage permissions for all your services from the Keycloak admin console and gives you the
                power to define exactly the policies you need.
            </p>
        </div>
    </div>
</div>

<#macro featuresEntry icon title text>
<div class="col d-flex align-items-start">
    <div class="row m-3">
        <span class="fw-bold"><i class="fa ${icon} pe-2" aria-hidden="true"></i> ${title}</span>
        <span>${text}</span>
    </div>
</div>
</#macro>

<div class="container bg-light mt-5 py-4">
    <div class="row row-cols-1 row-cols-lg-4">
        <@featuresEntry icon="fa-key" title="Single-Sign On" text="Login once to multiple applications"/>
        <@featuresEntry icon="fa-exchange-alt" title="Standard Protocols" text="OpenID Connect, OAuth 2.0 and SAML 2.0"/>
        <@featuresEntry icon="fa-cog" title="Centralized Management" text="For admins and users"/>
        <@featuresEntry icon="fa-shield-alt" title="Adapters" text="Secure applications and services easily"/>
        <@featuresEntry icon="fa-users" title="LDAP and Active Directory" text="Connect to existing user directories"/>
        <@featuresEntry icon="fa-cloud" title="Social Login" text="Easily enable social login"/>
        <@featuresEntry icon="fa-cloud" title="Identity Brokering" text="OpenID Connect or SAML 2.0 IdPs"/>
        <@featuresEntry icon="fa-bolt" title="High Performance" text="Lightweight, fast and scalable"/>
        <@featuresEntry icon="fa-server" title="Clustering" text="For scalability and availability"/>
        <@featuresEntry icon="fa-eye" title="Themes" text="Customize look and feel"/>
        <@featuresEntry icon="fa-edit" title="Extensible" text="Customize through code"/>
        <@featuresEntry icon="fa-lock" title="Password Policies" text="Customize password policies"/>
    </div>
</div>

</@tmpl.page>
