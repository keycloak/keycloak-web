<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="home" title="" previewImage="index.png" rss=true>

<#-- Hero Section -->
<section class="relative overflow-hidden bg-background">
    <#-- Animated Background Elements -->
    <div class="absolute inset-0 pointer-events-none overflow-hidden">
        <div class="absolute -top-24 -left-24 w-96 h-96 bg-primary/10 rounded-full blur-[120px]"></div>
        <div class="absolute top-1/2 -right-24 w-[30rem] h-[30rem] bg-primary-container/5 rounded-full blur-[150px]"></div>
        <div class="grid-pattern absolute inset-0"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto px-6 md:px-8 pt-32 pb-20 lg:pt-48 lg:pb-32 grid lg:grid-cols-12 gap-16 items-center">
        <div class="lg:col-span-7 space-y-8">
            <div class="secure-chip">
                <i class="fas fa-shield-alt"></i>
                CNCF Incubation Project
            </div>
            <h1 class="headline-display">
                The Open Source <br/>
                <span class="text-primary">Identity</span> and <span class="text-primary">Access</span> <br/>
                Management
            </h1>
            <p class="text-xl text-on-surface-variant max-w-xl font-medium leading-relaxed font-body">
                Add authentication to applications and secure services with minimum effort. No need to deal with storing users or authenticating users.
            </p>
            <div class="flex flex-wrap gap-4 pt-4">
                <a class="btn-kc-primary" href="${links.guides}">Get Started</a>
                <a class="btn-kc-secondary" href="${links.downloads}">Download ${version.version}</a>
            </div>
        </div>
        
        <div class="lg:col-span-5 relative hidden lg:block">
            <div class="w-full aspect-square bg-surface-container-low rounded-[3rem] overflow-hidden p-10 flex items-center justify-center relative">
                <div class="absolute inset-0 opacity-5 pointer-events-none">
                    <div class="absolute top-12 left-12 w-24 h-24 border-t-4 border-l-4 border-primary"></div>
                    <div class="absolute bottom-12 right-12 w-24 h-24 border-b-4 border-r-4 border-primary"></div>
                </div>
                <div class="w-full h-full bg-surface-container-highest rounded-3xl flex flex-col p-8">
                    <div class="flex items-center justify-between mb-10">
                        <div class="flex gap-2.5">
                            <div class="w-3.5 h-3.5 rounded-full bg-error/30"></div>
                            <div class="w-3.5 h-3.5 rounded-full bg-tertiary/30"></div>
                            <div class="w-3.5 h-3.5 rounded-full bg-primary/30"></div>
                        </div>
                        <div class="h-2.5 w-28 bg-outline-variant/40 rounded-full"></div>
                    </div>
                    <div class="space-y-6">
                        <div class="h-14 w-full bg-white rounded-xl flex items-center px-5 gap-4">
                            <i class="fas fa-lock text-primary"></i>
                            <div class="h-2.5 w-36 bg-surface-container rounded-full"></div>
                        </div>
                        <div class="h-14 w-full bg-white rounded-xl flex items-center px-5 gap-4">
                            <i class="fas fa-fingerprint text-primary"></i>
                            <div class="h-2.5 w-52 bg-surface-container rounded-full"></div>
                        </div>
                        <div class="pt-6 flex justify-end">
                            <div class="h-12 w-28 bg-primary rounded-xl"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<#-- News Bar -->
<section class="bg-surface-container-low py-6">
    <div class="max-w-7xl mx-auto px-6 md:px-8">
        <div class="flex flex-col md:flex-row md:items-center gap-4 md:gap-8">
            <span class="text-xs font-bold text-primary tracking-widest uppercase font-headline">Latest News</span>
            <div class="flex flex-wrap gap-6">
                <#list news as n>
                <a href="${n.link}" class="flex items-center gap-3 group">
                    <span class="bg-primary-fixed text-on-primary-fixed text-xs font-bold px-3 py-1 rounded-full">${n.date?string["dd MMM"]}</span>
                    <span class="text-on-surface-variant group-hover:text-primary transition-colors text-sm">${n.title}</span>
                </a>
                </#list>
            </div>
        </div>
    </div>
</section>

<#-- Core Features Section -->
<section class="py-32 px-6 md:px-8 bg-surface-container-low">
    <div class="max-w-7xl mx-auto">
        <div class="flex flex-col md:flex-row justify-between items-end mb-20 gap-8">
            <div class="max-w-xl">
                <h2 class="headline-section mb-6">
                    Built for the Enterprise. <br/>Open for Everyone.
                </h2>
                <p class="text-on-surface-variant text-lg font-body leading-relaxed">
                    Scale your security infrastructure without compromising on developer experience or open standards.
                </p>
            </div>
            <div class="text-xs font-bold text-primary tracking-widest uppercase font-headline">
                Core Capabilities
            </div>
        </div>
        <div class="grid md:grid-cols-3 gap-8">
            <div class="feature-card">
                <div class="icon-container mb-10">
                    <i class="fas fa-code text-2xl"></i>
                </div>
                <h3 class="font-headline text-2xl font-bold mb-4">Open Source</h3>
                <p class="text-on-surface-variant text-base leading-relaxed font-body">Community-driven and transparent security that you can trust, modify, and audit at any time.</p>
            </div>
            <div class="feature-card">
                <div class="icon-container mb-10">
                    <i class="fas fa-shield-alt text-2xl"></i>
                </div>
                <h3 class="font-headline text-2xl font-bold mb-4">High Security</h3>
                <p class="text-on-surface-variant text-base leading-relaxed font-body">Enterprise-grade security features like 2FA, social login, and fine-grained authorization out of the box.</p>
            </div>
            <div class="feature-card">
                <div class="icon-container mb-10">
                    <i class="fas fa-server text-2xl"></i>
                </div>
                <h3 class="font-headline text-2xl font-bold mb-4">Scalability</h3>
                <p class="text-on-surface-variant text-base leading-relaxed font-body">Architected for the cloud. Scale from a few users to millions across global clusters with ease.</p>
            </div>
        </div>
    </div>
</section>

<#-- Detailed Features -->
<section class="py-24 bg-background">
    <div class="max-w-7xl mx-auto px-6 md:px-8">
        
        <#-- Single-Sign On -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="space-y-6">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Single-Sign On</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Users authenticate with Keycloak rather than individual applications. This means your applications
                    don't have to deal with login forms, authenticating users, and storing users.
                </p>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Once logged-in to Keycloak, users don't have to login again to access a different application.
                    Keycloak provides single-sign out, which means users only have to logout once.
                </p>
            </div>
            <div class="bg-surface-container-low rounded-3xl p-8 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/screen-login.png" alt="Screenshot showing a user's login screen as presented by Keycloak"/>
            </div>
        </div>

        <#-- Identity Brokering -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="bg-surface-container-low rounded-3xl p-8 order-2 lg:order-1 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/dia-identity-brokering.png" alt="Diagram illustrating brokering"/>
            </div>
            <div class="space-y-6 order-1 lg:order-2">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Identity Brokering and Social Login</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the
                    social network you want to add. No code or changes to your application is required.
                </p>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers.
                </p>
            </div>
        </div>

        <#-- User Federation -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="space-y-6">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">User Federation</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own
                    provider if you have users in other stores, such as a relational database.
                </p>
            </div>
            <div class="bg-surface-container-low rounded-3xl p-8 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/dia-user-fed.png" alt="Diagram illustrating user federation"/>
            </div>
        </div>

        <#-- Admin Console -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="bg-surface-container-low rounded-3xl p-8 order-2 lg:order-1 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/screen-admin.png" alt="Screenshot of the admin console"/>
            </div>
            <div class="space-y-6 order-1 lg:order-2">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Admin Console</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Through the admin console administrators can centrally manage all aspects of the Keycloak server.
                    They can enable and disable various features, configure identity brokering and user federation.
                </p>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    They can create and manage applications and services, and define fine-grained authorization policies.
                    They can also manage users, including permissions and sessions.
                </p>
            </div>
        </div>

        <#-- Account Management -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="space-y-6">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Account Management Console</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Through the account management console users can manage their own accounts. They can update the profile,
                    change passwords, and setup two-factor authentication.
                </p>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Users can also manage sessions as well as view history for the account. If you've enabled social login
                    or identity brokering, users can also link their accounts with additional providers.
                </p>
            </div>
            <div class="bg-surface-container-low rounded-3xl p-8 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/screen-account.png" alt="Screenshot of the account management console"/>
            </div>
        </div>

        <#-- Standard Protocols -->
        <div class="grid lg:grid-cols-2 gap-16 items-center py-16">
            <div class="bg-surface-container-low rounded-3xl p-8 order-2 lg:order-1 hidden md:block">
                <img class="w-full rounded-2xl" src="resources/images/dia-protocols.png" alt="Logos of OpenID certification, SAML and OAuth 2.0"/>
            </div>
            <div class="space-y-6 order-1 lg:order-2">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Standard Protocols</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    Keycloak is based on standard protocols and provides support for OpenID Connect, OAuth 2.0, and SAML.
                </p>
            </div>
        </div>

        <#-- Authorization Services -->
        <div class="py-16">
            <div class="max-w-3xl space-y-6">
                <h2 class="font-headline text-3xl md:text-4xl font-bold tracking-tight">Authorization Services</h2>
                <p class="text-on-surface-variant text-lg leading-relaxed">
                    If role based authorization doesn't cover your needs, Keycloak provides fine-grained authorization services as well.
                    This allows you to manage permissions for all your services from the Keycloak admin console and gives you the
                    power to define exactly the policies you need.
                </p>
            </div>
        </div>
    </div>
</section>

<#-- Features Grid -->
<#macro featureCard icon title text>
<div class="bg-surface-container p-8 rounded-2xl hover:bg-surface-container-high transition-all duration-200">
    <div class="flex items-start gap-4">
        <div class="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center text-primary flex-shrink-0">
            <i class="fas ${icon}"></i>
        </div>
        <div>
            <h3 class="font-headline font-bold text-lg mb-1">${title}</h3>
            <p class="text-on-surface-variant text-sm">${text}</p>
        </div>
    </div>
</div>
</#macro>

<section class="py-24 bg-surface-container-low">
    <div class="max-w-7xl mx-auto px-6 md:px-8">
        <div class="text-center mb-16">
            <h2 class="headline-section mb-4">Everything You Need</h2>
            <p class="text-on-surface-variant text-lg max-w-2xl mx-auto">Comprehensive identity and access management features built for modern applications.</p>
        </div>
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <@featureCard icon="fa-key" title="Single-Sign On" text="Login once to multiple applications"/>
            <@featureCard icon="fa-exchange-alt" title="Standard Protocols" text="OpenID Connect, OAuth 2.0 and SAML 2.0"/>
            <@featureCard icon="fa-cog" title="Centralized Management" text="For admins and users"/>
            <@featureCard icon="fa-shield-alt" title="Adapters" text="Secure applications and services easily"/>
            <@featureCard icon="fa-users" title="LDAP and Active Directory" text="Connect to existing user directories"/>
            <@featureCard icon="fa-cloud" title="Social Login" text="Easily enable social login"/>
            <@featureCard icon="fa-link" title="Identity Brokering" text="OpenID Connect or SAML 2.0 IdPs"/>
            <@featureCard icon="fa-bolt" title="High Performance" text="Lightweight, fast and scalable"/>
            <@featureCard icon="fa-server" title="Clustering" text="For scalability and availability"/>
            <@featureCard icon="fa-palette" title="Themes" text="Customize look and feel"/>
            <@featureCard icon="fa-code" title="Extensible" text="Customize through code"/>
            <@featureCard icon="fa-lock" title="Password Policies" text="Customize password policies"/>
        </div>
    </div>
</section>

<#-- CTA Section -->
<section class="py-32 bg-background">
    <div class="max-w-4xl mx-auto px-6 md:px-8 text-center">
        <h2 class="headline-section mb-6">Ready to Get Started?</h2>
        <p class="text-on-surface-variant text-xl mb-10 max-w-2xl mx-auto">
            Join thousands of organizations securing their applications with Keycloak.
        </p>
        <div class="flex flex-wrap justify-center gap-4">
            <a class="btn-kc-primary" href="${links.guides}">Read the Guides</a>
            <a class="btn-kc-secondary" href="${links.community}">Join the Community</a>
        </div>
    </div>
</section>

</@tmpl.page>
