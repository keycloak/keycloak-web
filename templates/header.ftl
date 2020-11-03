<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Keycloak<#if (title)??> - ${title}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Keycloak is an open source identity and access management solution">
    <meta name="author" content="Keycloak Team">
    <meta name="keywords" content="sso,idm,openid connect,saml,kerberos,ldap">

    <#if noindex?? && noindex><meta name="robots" content="noindex"></#if>

    <#if !nocsp??><meta http-equiv='Content-Security-Policy' content="default-src 'none'; style-src 'self'; img-src 'self' https://www.google-analytics.com; font-src 'self'; script-src 'self' https://www.google-analytics.com; connect-src 'self' https://www.google-analytics.com; base-uri 'none'; form-action 'none';"></#if>

    <link href="${links.getResource('css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${links.getResource('font-awesome/css/font-awesome.min.css')}" rel="stylesheet">
    <link href="${links.getResource('css/keycloak.css')}" rel="stylesheet">

    <link rel="shortcut icon" href="${links.getResource('favicon.ico')}">

    <script src="${links.getResource('js/ga.js')}" type="text/javascript"></script>
    <script src="${links.getResource('js/jquery-1.11.1.min.js')}" type="text/javascript"></script>
    <script src="${links.getResource('js/bootstrap.min.js')}" type="text/javascript"></script>
</head>
<body>
<div id="wrap">
