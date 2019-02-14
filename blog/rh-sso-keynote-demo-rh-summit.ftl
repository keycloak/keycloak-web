<#--
title = Red Hat Single Sign-On in Keynote demo on Red Hat Summit!
date = 2018-06-17
publish = true
-->

<p>Red Hat Summit is one of the most important events during the year. Many geeks, Red Hat employees and customers have great opportunity to meet, learn new things and attend lots of interesting presentations and trainings. During the summit this year, there were few breakout sessions, which were solely about Keycloak and Red Hat SSO. You can take a look at this blogpost for more details.</p>

<h2>Red Hat SSO setup details</h2>

<p>The frontend of the demo was the simple mobile game. RH-SSO was used at the very first stage to authenticate users to the mobile game. Each attendee had an opportunity to try it by yourself. In total, we had 1200 players of the game.</p>

<p>The frontend of the demo was the simple mobile game. RH-SSO was used at the very first stage to authenticate users to the mobile game. Each attendee had an opportunity to try it by yourself. In total, we had 1200 players of the game.</p>

<img src="images/cross-dc-blog-architecture-rhsso.png"/>

<p>With this setup, every cloud is aware just about the users and sessions created on itself. This is fine with sticky session, but it won’t work for failover scenarios in case if one of the 3 clouds is broken/removed. There are also other issues with it - for example that admins and users see just sessions created on particular cloud. There are also potential security issues. For example when admin disables user on one cloud, user would still be enabled on other clouds as changes to user won’t be propagated to other clouds.</p>