<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#import "/templates/template-tailwind.ftl" as tmpl>

<@tmpl.page current="home" title="" previewImage="index.png" rss=true>

<!-- Hero Section -->
<div class="relative bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white overflow-hidden">
    <!-- Background Image -->
    <div class="absolute inset-0">
        <img src="${links.getResource('images/new-background-quality.png')}" alt="" class="w-full h-full object-cover opacity-30" />
        <div class="absolute inset-0 bg-gradient-to-br from-blue-900/80 via-blue-800/70 to-blue-900/90"></div>
    </div>

    <div class="container mx-auto px-4 pt-24 pb-16 md:pt-32 md:pb-24 relative">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <!-- Content -->
            <div class="text-center lg:text-left">
                <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold mb-2">
                    Open Source
                </h1>
                <h2 class="text-5xl md:text-6xl lg:text-7xl font-extrabold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-blue-200 to-white">
                    Identity and Access Management
                </h2>
                <p class="text-xl md:text-2xl text-blue-100 mb-8 max-w-2xl mx-auto lg:mx-0">
                    Add authentication to applications and secure services with minimum effort.<br/>
                    No need to deal with storing users or authenticating users.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                    <a href="${links.guides}" class="inline-flex items-center justify-center px-8 py-4 text-lg font-semibold text-blue-600 bg-white rounded-xl hover:bg-blue-50 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                        Get Started
                        <i class="fas fa-arrow-right ml-2"></i>
                    </a>
                    <a href="${links.downloads}" class="inline-flex items-center justify-center px-8 py-4 text-lg font-semibold text-white bg-blue-800 bg-opacity-50 backdrop-blur-sm rounded-xl hover:bg-opacity-70 transition-all duration-200 border-2 border-white border-opacity-20">
                        <i class="fas fa-download mr-2"></i>
                        Download
                    </a>
                </div>
            </div>

            <!-- Icon -->
            <div class="hidden lg:flex justify-center items-center">
                <img src="${links.getResource('images/icon.svg')}" class="w-full max-w-md animate-float" aria-hidden="true" alt="Keycloak"/>
            </div>
        </div>
    </div>
</div>

<!-- News Section -->
<div class="bg-gray-900 text-white py-4 border-y border-gray-800">
    <div class="container mx-auto px-4">
        <div class="flex flex-col lg:flex-row items-center gap-4">
            <a href="${links.blog}" class="font-bold text-lg text-blue-400 hover:text-blue-300 transition-colors flex items-center whitespace-nowrap">
                <i class="fas fa-newspaper mr-2"></i>
                News
            </a>
            <div class="flex flex-wrap items-center justify-center lg:justify-start gap-x-6 gap-y-3">
                <#list news as n>
                <div class="flex items-center gap-2">
                    <span class="inline-flex items-center px-2.5 py-1 rounded-md text-sm font-medium bg-blue-600 text-white">
                        ${n.date?string["dd MMM"]}
                    </span>
                    <a href="${n.link}" class="text-gray-300 hover:text-white transition-colors text-base">
                        ${n.title}
                    </a>
                </div>
                </#list>
            </div>
        </div>
    </div>
</div>

<!-- Features Section -->
<div class="bg-white py-16">
    <div class="container mx-auto px-4">

        <!-- Single-Sign On -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div>
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Single-Sign On</h2>
                <div class="space-y-4 text-gray-600 text-lg">
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
            </div>
            <div class="hidden md:flex justify-center">
                <img src="resources/images/screen-login.png" class="max-w-xl w-full rounded-2xl shadow-2xl hover:shadow-3xl transition-shadow duration-300" alt="Screenshot showing a user's login screen as presented by Keycloak"/>
            </div>
        </div>

        <!-- Identity Brokering -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div class="order-2 md:order-1 hidden md:flex justify-center">
                <img src="resources/images/dia-identity-brokering.png" class="max-w-xl w-full" alt="Diagram illustrating brokering"/>
            </div>
            <div class="order-1 md:order-2">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Identity Brokering and Social Login</h2>
                <div class="space-y-4 text-gray-600 text-lg">
                    <p>
                        Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the
                        social network you want to add. No code or changes to your application is required.
                    </p>
                    <p>
                        Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is
                        just a matter of configuring the Identity Provider through the admin console.
                    </p>
                </div>
            </div>
        </div>

        <!-- User Federation -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div>
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">User Federation</h2>
                <p class="text-gray-600 text-lg">
                    Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own
                    provider if you have users in other stores, such as a relational database.
                </p>
            </div>
            <div class="hidden md:flex justify-center">
                <img src="resources/images/dia-user-fed.png" class="max-w-xl w-full" alt="Diagram illustrating user federation"/>
            </div>
        </div>

        <!-- Admin Console -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div class="order-2 md:order-1 hidden md:flex justify-center">
                <img src="resources/images/screen-admin.png" class="max-w-xl w-full rounded-2xl shadow-2xl hover:shadow-3xl transition-shadow duration-300" alt="Screenshot of the admin console"/>
            </div>
            <div class="order-1 md:order-2">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Admin Console</h2>
                <div class="space-y-4 text-gray-600 text-lg">
                    <p>
                        Through the admin console administrators can centrally manage all aspects of the Keycloak server.
                    </p>
                    <p>
                        They can enable and disable various features. They can configure identity brokering and user federation.
                    </p>
                    <p>
                        They can create and manage applications and services, and define fine-grained authorization policies.
                    </p>
                    <p>
                        They can also manage users, including permissions and sessions.
                    </p>
                </div>
            </div>
        </div>

        <!-- Account Management -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div>
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Account Management Console</h2>
                <div class="space-y-4 text-gray-600 text-lg">
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
            </div>
            <div class="hidden md:flex justify-center">
                <img src="resources/images/screen-account.png" class="max-w-xl w-full rounded-2xl shadow-2xl hover:shadow-3xl transition-shadow duration-300" alt="Screenshot of the account management console"/>
            </div>
        </div>

        <!-- Standard Protocols -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center mb-20">
            <div class="order-2 md:order-1 hidden md:flex justify-center">
                <img src="resources/images/dia-protocols.png" class="max-w-sm w-full" alt="Logos of OpenID certification, SAML and OAuth 2.0" aria-hidden="true"/>
            </div>
            <div class="order-1 md:order-2">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Standard Protocols</h2>
                <p class="text-gray-600 text-lg">
                    Keycloak is based on standard protocols and provides support for OpenID Connect, OAuth 2.0, and SAML.
                </p>
            </div>
        </div>

        <!-- Authorization Services -->
        <div class="max-w-4xl">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Authorization Services</h2>
            <p class="text-gray-600 text-lg">
                If role based authorization doesn't cover your needs, Keycloak provides fine-grained authorization services as well.
                This allows you to manage permissions for all your services from the Keycloak admin console and gives you the
                power to define exactly the policies you need.
            </p>
        </div>
    </div>
</div>

<!-- Features Grid -->
<div class="bg-gradient-to-br from-gray-50 to-gray-100 py-16">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 text-center mb-12">Key Features</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

            <!-- Feature Card Macro -->
            <#macro featureCard icon title text>
            <div class="bg-white rounded-xl p-6 shadow-md hover:shadow-xl transition-all duration-200 transform hover:-translate-y-1">
                <div class="flex items-start gap-4">
                    <div class="flex-shrink-0">
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fa ${icon} text-2xl text-blue-600" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div>
                        <h3 class="font-bold text-gray-900 mb-1">${title}</h3>
                        <p class="text-sm text-gray-600">${text}</p>
                    </div>
                </div>
            </div>
            </#macro>

            <@featureCard icon="fa-key" title="Single-Sign On" text="Login once to multiple applications"/>
            <@featureCard icon="fa-exchange-alt" title="Standard Protocols" text="OpenID Connect, OAuth 2.0 and SAML 2.0"/>
            <@featureCard icon="fa-cog" title="Centralized Management" text="For admins and users"/>
            <@featureCard icon="fa-shield-alt" title="Adapters" text="Secure applications and services easily"/>
            <@featureCard icon="fa-users" title="LDAP and Active Directory" text="Connect to existing user directories"/>
            <@featureCard icon="fa-cloud" title="Social Login" text="Easily enable social login"/>
            <@featureCard icon="fa-cloud" title="Identity Brokering" text="OpenID Connect or SAML 2.0 IdPs"/>
            <@featureCard icon="fa-bolt" title="High Performance" text="Lightweight, fast and scalable"/>
            <@featureCard icon="fa-server" title="Clustering" text="For scalability and availability"/>
            <@featureCard icon="fa-eye" title="Themes" text="Customize look and feel"/>
            <@featureCard icon="fa-edit" title="Extensible" text="Customize through code"/>
            <@featureCard icon="fa-lock" title="Password Policies" text="Customize password policies"/>
        </div>
    </div>
</div>

</@tmpl.page>
