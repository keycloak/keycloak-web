<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Keycloak<#if (title)??> - ${title}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Keycloak is an open source identity and access management solution">
    <meta name="author" content="Keycloak Team">
    <meta name="keywords" content="sso,idm,openid connect,saml,kerberos,ldap">

    <link href="${root}resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${root}resources/css/prettify.css" rel="stylesheet">
    <link href="${root}resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${root}resources/css/keycloak.css" rel="stylesheet">
    <link href="${root}resources/css/tabzilla.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="${root}resources/js/html5shiv.min.js"></script>
    <![endif]-->

    <link rel="shortcut icon" href="${root}resources/favicon.ico">

    <script src="${root}resources/js/jquery-1.11.1.min.js"></script>
    <script src="${root}resources/js/bootstrap.min.js"></script>
    <script src="${root}resources/js/prettify.js"></script>
    <script src="${root}resources/js/jbossorg-tabzilla.js"></script>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-79404298-1', 'auto');
        ga('send', 'pageview');

    </script>
    <script id="dpal" src=“https://www.redhat.com/dtm.js" type="text/javascript"></script>
</head>
<body onload="prettyPrint()">
<div id="wrap">

<div class="dropup">
    <a class="tabnav-closed" href="#" id="tab">Red Hat</a>
    <script>
        window.addEventListener('load', function() {
            renderTabzilla("Keycloak", "http://www.keycloak.org", true );
        }, false);
    </script>
</div>