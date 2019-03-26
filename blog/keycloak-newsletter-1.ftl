<#--
title = Keycloak Community Newsletter #1
date = 2019-03-26
publish = false
author = Sébastien Blanc
-->

<p>
This is the very first "Keycloak Community Newsletter". The goal of this newsletter is to share news around the Keycloak project.
</p>


<h2>News from the community</h2>
<p>
Since the beginning of the year, the community has been really active. Each week several blog posts speaking about Keycloak are published, here is a short selection.
</p>
<p>
Let's start with Philip Riecks who explains in <a href="https://rieckpil.de/howto-microprofile-jwt-authentication-with-keycloak-and-react/">this article</a> how you can leverage Microprofile JWT Authentication with Keycloak and React.
</p>
<p>
Ramandeep Singh has been <a href="https://medium.com/@ramandeep.singh.1983/enterprise-web-app-authentication-using-keycloak-and-node-js-c10b0e26b80d">blogging</a> about Keycloak and NodeJS. 
</p>
<p>
Joshua Alfred Erney explain in this <a href="https://www.jerney.io/secure-apis-kong-keycloak-1/">blog serie</a> how to integrate Keylcoak and <a href="https://konghq.com/">Kong</a>, a popular API management platform.
</p>
<P>
With Mohamed Aboullaite's blog post you will learn how to <a href="https://aboullaite.me/secure-kibana-keycloak/">secure your Kibana dashboards using Keycloak</a>.
</p>
<p>
Finally in <a href=https://beyondthekube.com/identity-management-for-on-prem-clusters/?utm_sq=g0u3m590zf">this 3 parts article</a> installing Keycloak on Kubernetes will have no more secrets for you. 
</p>


<h2>News from the project</h2>
<p>
Keycloak 5.0.0 has been <a href="https://www.keycloak.org/2019/03/keycloak-500-released.html">released</a> and 6.0.0 is around the corner.
</p>
<p>
From now on, new larger Keycloak's features will be discussed in the open. For each new feature, a design document will be created and pushed to our Github repository as a simple MarkDown file. This will make it easy for everyone to comment as
well as contribute to the designs by opening Github issues and providing pull requests. 
We have already 3 documents open for discussion: 
<ul>
    <li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/web-authn-two-factor.md">W3C Web Authentication - Two-Factor</a></li>
    <li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/application-initiated-actions.md">Application Initiated Actions</a></li>
    <li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/observerability.md">Observerability</a></li>
</ul>  


<h2>News from the Identity Management World</h2>
<p>
The big announcement, 2 weeks ago, was that <a href="https://www.yubico.com/webauthn/">WebAuthn<a/> became an official W3C Standard. This marks a milestone in the world of authentication and Identity Management. The goal of WebAuthn, according to <a href="https://en.wikipedia.org/wiki/WebAuthn">Wikipedia</a> is to :<i> standarize an interface for public-key authentication of users to web-based applications and services.</i>
The Keycloak community is of course really interested in this new standard, there is already a design document <a href="https://github.com/keycloak/keycloak-community/blob/master/design/web-authn-two-factor.md">available</a> and the community has even started to work on some <a href="https://github.com/webauthn4j/keycloak-webauthn-authenticator">prototype</a>
</p>


<h2>Conferences / Webinars</h2>
<p>
In March, there was the Javaland conference in Germany. There were actuallly 2 talks about Keycloak : Sébastien blanc gave a talk about <a href="https://docs.google.com/presentation/d/e/2PACX-1vSp6t8vo1LsWBVDmFmFVC43qtwSQK3_UrVfFIQcTpaEmGJohHbwsKj9UYUEZdogRMXWMMJJSskWRHyZ/pub?start=false&loop=false&delayms=3000">Securing your Microservices wih Keycloak</a> , there is also a Github repository containing the <a href="https://github.com/sebastienblanc/quarkus-quickstart">demo</a>. Thomas Darimont also give an <a href="https://www.javaland.eu/formes/pubfiles/11145218/2019-nn-thomas_darimont-sichere_spring-anwendungen_mit_keycloak-praesentation.pdf">introductory talk</a> about Keycloak in German.
<p>
<p>
In April, at Devoxx France, Guillaume Gillon will talk about how to combine <a href="https://cfp.devoxx.fr/2019/talk/BIP-1027/L'open-source_a_la_rescousse_de_mes_APIS:_comment_les_securiser_grace_a_Gravitee.io_et_Keycloak">Keycloak and Gravitee.io</a> (in French). 
</p>


<h2>Contributing to Keycloak</h2>

<p>We always welcome contributions to Keycloak. If you would like to contribute and have a great idea then tell us about it
on the developer mailing list. If you would like to contribute, but not sure what to work on we can help!</p>

<p>As a first time contributor it may be an idea to start by contributing a bug fix. This will allow you to get to know
the codebase, the testsuite and what is involved in creating a pull request. You can find a list of <a href="https://issues.jboss.org/issues/?jql=project%20%3D%20Keycloak%20AND%20issuetype%20%3D%20bug%20AND%20fixVersion%20%3D%20%22Awaiting%20Volunteers%22%20">open bugs here</a></p>

<p>We also have a list of <a href="https://issues.jboss.org/issues/?jql=project%20%3D%20Keycloak%20AND%20fixVersion%20%3D%20%22Awaiting%20Volunteers%22%20">open issues</a> that
are awaiting contributions. Not all of these have been properly reviewed so it is always a good idea to start by sending
an email to the developer mailing list prior to working on any of these.</p>

<p>
For each newsletter we will also highlight a few features that we would especially like to see contributions for. These
include:

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-4593">Support for large number of realms</a> - Keycloak is not designed to handle large amount of realms. If there are more than 50 or so realms you will start experiencing issues.</li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-6073">Support different URLs for front and back channel requests in adapters</a> - When adapters are located alongside Keycloak it's not always wanted to use the public URL of Keycloak and this issue is about allowing adapters to use one URL for back-channel requests and a different URL for redirects.</li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-2939">OpenID Connect Front-Channel Logout</a> - The description says it all. Add support for OpenID Connect Front-Channel logout specification to Keycloak.</li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-2537">SCIM 2</a> - Add support for the SCIM 2 specification to Keycloak, which provides a standards based interface for user management.</li>
</ul>
</p>
