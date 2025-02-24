<#macro page current title summary="" importMap="" previewImage="" noindex=false nocsp=false rss=false>
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
    <meta name="author" content="Keycloak Team">
    <meta name="keywords" content="sso,idm,openid connect,saml,kerberos,ldap">

    <#if noindex?? && noindex><meta name="robots" content="noindex"></#if>

    <#if !nocsp??><meta http-equiv='Content-Security-Policy' content="default-src 'none'; style-src 'self'; img-src 'self' https://www.google-analytics.com; font-src 'self'; script-src 'self' https://www.google-analytics.com; connect-src 'self' https://www.google-analytics.com; base-uri 'none'; form-action 'none';"></#if>

    <link href="${links.getResource('bootstrap/dist/css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${links.getResource('@fortawesome/fontawesome-free/css/all.min.css')}" rel="stylesheet">
    <link href="${links.getResource('css/keycloak.css')}" rel="stylesheet">
    <link rel="canonical" href="${canonical}">
    <meta property="og:url" content="${canonical}">

    <link rel="shortcut icon" href="${links.getResource('favicon.ico')}">

    <#if importMap?has_content><script type="importmap">${importMap}</script></#if>
    <script src="${links.getResource('bootstrap/dist/js/bootstrap.min.js')}" type="text/javascript"></script>
    <script src="${links.getResource('tocbot/dist/tocbot.min.js')}" type="text/javascript"></script>
    <#if rss><link rel="alternate" type="application/rss+xml" title="Keycloak's Blog" href="${links.getRss()}"></#if>
</#compress>
</head>
<body>

<header class="navbar navbar-expand-md bg-light shadow-sm">
<nav class="container-xxl flex-wrap flex-md-no-wrap navbar-light" data-nosnippet>
    <a class="navbar-brand me-3 me-md-4 me-lg-5" href="${links.home}">
        <img class="img-fluid" src="${links.getResource('images/logo.svg')}" width="240" alt="Keycloak"/>
    </a>
    <a class="nav-link d-none d-sm-block d-md-none d-lg-block" href="https://github.com/keycloak/keycloak"><img src="https://img.shields.io/github/stars/keycloak/keycloak?label=GitHub%20Stars" style="height: 25px" alt="GitHub stars"/></a>
    <a class="nav-link d-block d-sm-none d-md-block d-lg-none" href="https://github.com/keycloak/keycloak"><img src="https://img.shields.io/github/stars/keycloak/keycloak?label=" style="height: 25px" alt="GitHub stars"/></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="fa fa-bars fa-lg px-1 py-2"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav flex-row flex-wrap bd-navbar-nav pt-2 py-md-0">
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'guides'>active</#if>" href="${links.guides}">Guides</a>
        </li>
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'docs'>active</#if>" href="${links.docs}">Docs</a>
        </li>
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'downloads'>active</#if>" href="${links.downloads}">Downloads</a>
        </li>
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'community'>active</#if>" href="${links.community}">Community</a>
        </li>
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'blog'>active</#if>" href="${links.blog}">Blog</a>
        </li>
      </ul>
    </div>
</nav>
</header>

<#nested>

<div class="container mt-5" data-nosnippet>
    <footer class="py-3 my-4 border-top">
        <p class="text-center text-muted">Keycloak is a Cloud Native Computing Foundation incubation project</p>
        <div class="text-center">
            <img alt="Cloud Native Computing Foundation" src="${links.getResource('images/cncf_logo.png')}"/>
        </div>
        <p class="mt-4 text-center small text-muted">&copy; Keycloak Authors 2025. &copy; 2025 The Linux Foundation. All rights reserved. The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation, please see our <a href="https://www.linuxfoundation.org/trademark-usage">Trademark Usage page</a>.</p>
    </footer>
</div>

</body>
</html>
</#macro>
