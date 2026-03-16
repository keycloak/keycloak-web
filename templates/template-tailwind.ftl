<#macro page current title summary="" importMap="" previewImage="" author="" noindex=false nocsp=false rss=false jsonLd="">
<#-- @ftlvariable name="projectStars" type="org.keycloak.webbuilder.ProjectStars" -->
<!doctype html>
<html lang="en" prefix="og: https://ogp.me/ns#">
<head>
<#compress>
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-0J2P9316N6"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-0J2P9316N6');
    </script>
    <meta charset="utf-8"/>
    <title><#if (title)?has_content>${title} - </#if>Keycloak</title>

    <#if (previewImage)?has_content>
        <meta name="twitter:card" content="summary_large_image">
        <meta property="og:image" content="${links.getRoot() + '/preview/' + previewImage}">
    <#else>
        <meta name="twitter:card" content="summary_large">
    </#if>
    <meta name="twitter:site" content="@keycloak">
    <meta property="og:site_name" content="Keycloak">
    <meta property="og:title" content="<#if (title)?has_content>${title}<#else>Keycloak</#if>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" property="og:description" content="<#if (summary)?has_content>${summary}<#else>Keycloak - the open source identity and access management solution. Add single-sign-on and authentication to applications and secure services with minimum effort.</#if>">
    <meta name="author" content="<#if (author)?has_content>${author}<#else>Keycloak Team</#if>">
    <meta name="keywords" content="sso,idm,openid connect,saml,kerberos,ldap">

    <#if noindex?? && noindex><meta name="robots" content="noindex"></#if>

    <#if !nocsp??><meta http-equiv='Content-Security-Policy' content="default-src 'none'; style-src 'self'; img-src 'self' https://www.google-analytics.com; font-src 'self'; script-src 'self' https://www.google-analytics.com; connect-src 'self' https://www.google-analytics.com; base-uri 'none'; form-action 'none';"></#if>

    <!-- Tailwind CSS (Modern) -->
    <link href="${links.getResource('css/tailwind.css')}" rel="stylesheet">

    <!-- Font Awesome (Icons) -->
    <link href="${links.getResource('@fortawesome/fontawesome-free/css/all.min.css')}" rel="stylesheet">

    <!-- Legacy CSS for compatibility (optional - can be removed gradually) -->
    <link href="${links.getResource('css/keycloak.css')}" rel="stylesheet">

    <link rel="canonical" href="${canonical}">
    <meta property="og:url" content="${canonical}">

    <link rel="icon" type="image/x-icon" href="${links.getResource('favicon.ico')}">
    <link rel="icon" type="image/vnd.microsoft.icon" href="${links.getResource('favicon.ico')}">
    <link rel="icon" type="image/svg+xml" href="${links.getResource('favicon.svg')}">

    <#if importMap?has_content><script type="importmap">${importMap}</script></#if>
    <#if rss><link rel="alternate" type="application/rss+xml" title="Keycloak's Blog" href="${links.getRss()}"></#if>
    <#if jsonLd?has_content>
    <script type="application/ld+json">
        ${jsonLd}
    </script>
    </#if>
</#compress>
</head>
<body class="bg-gray-50" x-data="{ mobileMenuOpen: false }">

<!-- Modern Tailwind Navbar -->
<header class="bg-transparent absolute top-0 left-0 right-0 z-50">
<nav class="container mx-auto px-4 py-4" data-nosnippet>
    <div class="flex items-center justify-between">
        <a class="flex items-center" href="${links.home}">
            <img class="h-10" src="${links.getResource('images/logo.svg')}" alt="Keycloak"/>
        </a>

        <!-- Mobile menu button -->
        <button
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="lg:hidden p-2 rounded-lg hover:bg-white/20 text-white"
            aria-label="Toggle navigation"
        >
            <i class="fas fa-bars text-xl"></i>
        </button>

        <!-- Desktop Navigation -->
        <div class="hidden lg:flex items-center gap-6">
            <a class="text-white/90 hover:text-white transition-colors px-3 py-2 font-medium <#if current = 'guides'>text-white</#if>" href="${links.guides}">Guides</a>
            <a class="text-white/90 hover:text-white transition-colors px-3 py-2 font-medium <#if current = 'docs'>text-white</#if>" href="${links.docs}">Docs</a>
            <a class="text-white/90 hover:text-white transition-colors px-3 py-2 font-medium <#if current = 'downloads'>text-white</#if>" href="${links.downloads}">Downloads</a>
            <a class="text-white/90 hover:text-white transition-colors px-3 py-2 font-medium <#if current = 'community'>text-white</#if>" href="${links.community}">Community</a>
            <a class="text-white/90 hover:text-white transition-colors px-3 py-2 font-medium <#if current = 'blog'>text-white</#if>" href="${links.blog}">Blog</a>
            <a class="flex items-center" href="https://github.com/keycloak/keycloak">
                <img src="${links.getResource('images/stars-large.svg')}" class="h-6" alt="GitHub stars"/>
            </a>
        </div>
    </div>

    <!-- Mobile Navigation -->
    <div x-show="mobileMenuOpen" class="lg:hidden mt-4 pb-4 border-t border-white/20 bg-white/10 backdrop-blur-sm rounded-lg">
        <div class="flex flex-col gap-2 pt-4 px-2">
            <a class="block px-3 py-2 rounded-lg hover:bg-white/20 text-white <#if current = 'guides'>bg-white/20 font-semibold</#if>" href="${links.guides}">Guides</a>
            <a class="block px-3 py-2 rounded-lg hover:bg-white/20 text-white <#if current = 'docs'>bg-white/20 font-semibold</#if>" href="${links.docs}">Docs</a>
            <a class="block px-3 py-2 rounded-lg hover:bg-white/20 text-white <#if current = 'downloads'>bg-white/20 font-semibold</#if>" href="${links.downloads}">Downloads</a>
            <a class="block px-3 py-2 rounded-lg hover:bg-white/20 text-white <#if current = 'community'>bg-white/20 font-semibold</#if>" href="${links.community}">Community</a>
            <a class="block px-3 py-2 rounded-lg hover:bg-white/20 text-white <#if current = 'blog'>bg-white/20 font-semibold</#if>" href="${links.blog}">Blog</a>
            <a class="block px-3 py-2" href="https://github.com/keycloak/keycloak">
                <img src="${links.getResource('images/stars-large.svg')}" class="h-6" alt="GitHub stars"/>
            </a>
        </div>
    </div>
</nav>
</header>

<#nested>

<!-- Modern Footer -->
<footer class="bg-white border-t border-gray-200 mt-16" data-nosnippet>
    <div class="container mx-auto px-4 py-8">
        <p class="text-center text-gray-600">Keycloak is a Cloud Native Computing Foundation incubation project</p>
        <div class="flex justify-center mt-4">
            <img class="h-12" alt="Cloud Native Computing Foundation" src="${links.getResource('images/cncf_logo.png')}" loading="lazy"/>
        </div>
        <p class="mt-6 text-center text-sm text-gray-500">
            &copy; Keycloak Authors 2025. &copy; 2025 The Linux Foundation. All rights reserved.
            The Linux Foundation has registered trademarks and uses trademarks.
            For a list of trademarks of The Linux Foundation, please see our
            <a href="https://www.linuxfoundation.org/trademark-usage" class="link">Trademark Usage page</a>.
        </p>
    </div>
</footer>

<!-- Alpine.js for interactivity -->
<script defer src="${links.getResource('alpinejs/dist/cdn.min.js')}"></script>
<script src="${links.getResource('tocbot/dist/tocbot.min.js')}" type="text/javascript"></script>

</body>
</html>
</#macro>
