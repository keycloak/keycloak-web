<#macro page current title summary="" importMap="" previewImage="" author="" noindex=false nocsp=false rss=false jsonLd="">
<#-- @ftlvariable name="projectStars" type="org.keycloak.webbuilder.ProjectStars" -->
<!doctype html>
<html lang="en" prefix="og: https://ogp.me/ns#">
<head>
<#compress>
    <script>
        (function() {
            var theme = localStorage.getItem('theme');
            var prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            // If no explicit preference saved, follow system
            if (!theme) {
                if (prefersDark) {
                    document.documentElement.classList.add('dark');
                }
            } else if (theme === 'dark') {
                document.documentElement.classList.add('dark');
            }
            // theme === 'light' means user explicitly chose light, so don't add dark class
        })();
    </script>
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

    <#if !nocsp??><meta http-equiv='Content-Security-Policy' content="default-src 'none'; style-src 'self' https://fonts.googleapis.com; img-src 'self' https://www.google-analytics.com https://img.shields.io; font-src 'self' https://fonts.gstatic.com; script-src 'self' https://www.google-analytics.com https://www.googletagmanager.com; connect-src 'self' https://www.google-analytics.com; base-uri 'none'; form-action 'none';"></#if>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <link href="${links.getResource('css/styles.css')}" rel="stylesheet">
    <link href="${links.getResource('bootstrap/dist/css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${links.getResource('@fortawesome/fontawesome-free/css/all.min.css')}" rel="stylesheet">
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
<body class="bg-background text-on-surface font-body antialiased">

<header class="fixed top-0 w-full z-50 glass border-b border-outline-variant/10">
<nav class="flex justify-between items-center max-w-7xl mx-auto px-6 md:px-8 h-20" data-nosnippet>
    <a class="text-2xl font-extrabold tracking-tighter text-primary font-headline" href="${links.home}">
        Keycloak
    </a>
    <div class="hidden md:flex items-center gap-8 font-headline font-bold tracking-tight text-sm">
        <a class="text-on-surface-variant hover:text-primary transition-colors <#if current = 'guides'>text-primary</#if>" href="${links.guides}">Guides</a>
        <a class="text-on-surface-variant hover:text-primary transition-colors <#if current = 'docs'>text-primary</#if>" href="${links.docs}">Docs</a>
        <a class="text-on-surface-variant hover:text-primary transition-colors <#if current = 'downloads'>text-primary</#if>" href="${links.downloads}">Downloads</a>
        <a class="text-on-surface-variant hover:text-primary transition-colors <#if current = 'community'>text-primary</#if>" href="${links.community}">Community</a>
        <a class="text-on-surface-variant hover:text-primary transition-colors <#if current = 'blog'>text-primary</#if>" href="${links.blog}">Blog</a>
    </div>
    <div class="flex items-center gap-4">
        <a href="https://github.com/keycloak/keycloak" class="hidden sm:flex items-center gap-2 text-on-surface-variant hover:text-primary transition-colors">
            <i class="fab fa-github text-xl"></i>
            <span class="text-sm font-bold font-headline">GitHub</span>
        </a>
        <button id="theme-toggle" class="p-2.5 rounded-xl bg-surface-container hover:bg-surface-container-high text-on-surface-variant transition-all active:scale-95 border border-outline-variant/10" aria-label="Toggle dark mode">
            <i class="fas fa-sun icon-sun"></i>
            <i class="fas fa-moon icon-moon"></i>
        </button>
        <a class="bg-primary text-on-primary px-5 py-2.5 rounded-xl font-bold text-sm hover:bg-primary-container transition-all" href="${links.guides}">Get Started</a>
        <button class="navbar-toggler md:hidden p-2.5 rounded-xl bg-surface-container hover:bg-surface-container-high text-on-surface-variant transition-all" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fa fa-bars fa-lg"></i>
        </button>
    </div>
</nav>
<div class="collapse md:hidden bg-surface-container-lowest/95 backdrop-blur-lg" id="navbarCollapse">
    <div class="max-w-7xl mx-auto px-6 py-4 flex flex-col gap-2 font-headline font-bold text-sm">
        <a class="py-2 text-on-surface-variant hover:text-primary transition-colors <#if current = 'guides'>text-primary</#if>" href="${links.guides}">Guides</a>
        <a class="py-2 text-on-surface-variant hover:text-primary transition-colors <#if current = 'docs'>text-primary</#if>" href="${links.docs}">Docs</a>
        <a class="py-2 text-on-surface-variant hover:text-primary transition-colors <#if current = 'downloads'>text-primary</#if>" href="${links.downloads}">Downloads</a>
        <a class="py-2 text-on-surface-variant hover:text-primary transition-colors <#if current = 'community'>text-primary</#if>" href="${links.community}">Community</a>
        <a class="py-2 text-on-surface-variant hover:text-primary transition-colors <#if current = 'blog'>text-primary</#if>" href="${links.blog}">Blog</a>
    </div>
</div>
</header>

<div class="pt-20">
<#nested>
</div>

<footer class="w-full bg-[#0a0a0a] py-20" data-nosnippet>
    <div class="max-w-7xl mx-auto px-6 md:px-8 flex flex-col gap-12">
        <div class="flex flex-col md:flex-row justify-between items-center gap-12">
            <div class="flex flex-col gap-4 items-center md:items-start">
                <div class="text-2xl font-extrabold text-white font-headline tracking-tighter">Keycloak</div>
                <p class="text-white/60 text-sm">A Cloud Native Computing Foundation incubation project</p>
            </div>
            <div class="flex flex-wrap justify-center gap-x-10 gap-y-6 font-headline text-xs font-bold uppercase tracking-widest">
                <a class="text-white/50 hover:text-primary-fixed transition-colors duration-300 flex items-center gap-2" href="https://twitter.com/keycloak">
                    <i class="fab fa-twitter"></i> Twitter
                </a>
                <a class="text-white/50 hover:text-primary-fixed transition-colors duration-300 flex items-center gap-2" href="https://github.com/keycloak/keycloak">
                    <i class="fab fa-github"></i> GitHub
                </a>
                <a class="text-white/50 hover:text-primary-fixed transition-colors duration-300 flex items-center gap-2" href="https://www.keycloak.org/community">
                    <i class="fas fa-comments"></i> Community
                </a>
                <a class="text-white/50 hover:text-primary-fixed transition-colors duration-300 flex items-center gap-2" href="https://www.keycloak.org/security">
                    <i class="fas fa-shield-alt"></i> Security
                </a>
            </div>
        </div>
        <div class="flex flex-col items-center gap-6 pt-8 border-t border-white/10">
            <img alt="Cloud Native Computing Foundation" src="${links.getResource('images/cncf-white-logo.png')}" class="h-12" loading="lazy"/>
            <p class="text-center text-white/40 text-xs max-w-3xl">&copy; Keycloak Authors 2025. &copy; 2025 The Linux Foundation. All rights reserved. The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation, please see our <a href="https://www.linuxfoundation.org/trademark-usage" class="text-white/60 hover:text-primary-fixed transition-colors">Trademark Usage page</a>.</p>
        </div>
    </div>
</footer>

<script src="${links.getResource('bootstrap/dist/js/bootstrap.min.js')}" type="text/javascript"></script>
<script src="${links.getResource('tocbot/dist/tocbot.min.js')}" type="text/javascript"></script>
<script>
    (function() {
        var toggle = document.getElementById('theme-toggle');
        var html = document.documentElement;
        
        // Toggle theme on click
        toggle.addEventListener('click', function() {
            if (html.classList.contains('dark')) {
                html.classList.remove('dark');
                localStorage.setItem('theme', 'light');
            } else {
                html.classList.add('dark');
                localStorage.setItem('theme', 'dark');
            }
        });
        
        // Double-click to reset to system preference
        toggle.addEventListener('dblclick', function(e) {
            e.preventDefault();
            localStorage.removeItem('theme');
            var prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            if (prefersDark) {
                html.classList.add('dark');
            } else {
                html.classList.remove('dark');
            }
        });
        
        // Listen for system preference changes (when no explicit preference set)
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function(e) {
            if (!localStorage.getItem('theme')) {
                if (e.matches) {
                    html.classList.add('dark');
                } else {
                    html.classList.remove('dark');
                }
            }
        });
    })();
</script>

</body>
</html>
</#macro>
