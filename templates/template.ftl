<#macro page current title noindex=false nocsp=false>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Keycloak<#if (title)?has_content> - ${title}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Keycloak is an open source identity and access management solution">
    <meta name="author" content="Keycloak Team">
    <meta name="keywords" content="sso,idm,openid connect,saml,kerberos,ldap">

    <#if noindex?? && noindex><meta name="robots" content="noindex"></#if>

    <#if !nocsp??><meta http-equiv='Content-Security-Policy' content="default-src 'none'; style-src 'self'; img-src 'self' https://www.google-analytics.com; font-src 'self'; script-src 'self' https://www.google-analytics.com; connect-src 'self' https://www.google-analytics.com; base-uri 'none'; form-action 'none';"></#if>

    <link href="${links.getResource('bootstrap/dist/css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${links.getResource('@fortawesome/fontawesome-free/css/fontawesome.min.css')}" rel="stylesheet">
    <link href="${links.getResource('@fortawesome/fontawesome-free/css/solid.min.css')}" rel="stylesheet">
    <link href="${links.getResource('css/keycloak.css')}" rel="stylesheet">

    <link rel="shortcut icon" href="${links.getResource('favicon.ico')}">

    <script src="${links.getResource('js/ga.js')}" type="text/javascript"></script>
    <script src="${links.getResource('bootstrap/dist/js/bootstrap.min.js')}" type="text/javascript"></script>
</head>
<body>

<header class="navbar navbar-expand-md bg-light shadow-sm">
<nav class="container-xxl flex-wrap flex-md-no-wrap navbar-light">
    <a class="navbar-brand me-5" href="${links.home}">
        <img class="img-fluid" src="${links.getResource('images/keycloak_logo_200px.svg')}" width="240" alt="Keycloak"/>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="fa fa-bars fa-lg px-1 py-2"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav flex-row flex-wrap bd-navbar-nav pt-2 py-md-0">
        <li class="nav-item col-6 col-md-auto">
          <a class="nav-link <#if current = 'get-started'>active</#if>" href="${links.guides}">Get Started</a>
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

<div class="container">
    <footer class="d-flex flex-wrap justify-content-between align-items-center pt-2 mt-3 mb-3">
        <div class="col-md-4 d-flex align-items-center">
            <span class="text-muted me-3">Sponsored by</span>
            <a href="http://www.redhat.com/" target="_blank" class="">
                <img alt="Red Hat" src="${links.getResource('images/Logo-RedHat-A-Standard-RGB.svg')}" width="100">
            </a>
        </div>
    </footer>
</div>

</body>
</html>
</#macro>
