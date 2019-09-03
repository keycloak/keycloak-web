<#--
title = What's Coming To Keycloak
date = 2019-09-03
publish = true
author = Stian Thorgersen
-->

<h3>New Account Console and Account REST API</h3>

<p>The current account console is getting dated. It is also having issues around usability and being hard
to extend. For this reason we had the UXD team at Red Hat develop
<a href="https://marvelapp.com/c90dfi0/screen/59941600">wireframes</a> for a new account console. The new console
is being implemented with React.js providing a better user experience as well as making it easier to extend
and customise.</p>

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-6197">JIRA - Account Console</a></li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-7428">JIRA - Account REST API</a></li>
</ul>


<h3>WebAuthn</h3>

<p>We are working towards adding WebAuthn support both for two factor authentication and passwordless experience.
This task is not as simple as adding an authenticator for WebAuth, but will also require
work on improving authentication flows and the account console.</p>

<ul>
<li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/multi-factor-admin-and-step-up.md">Design proposal - Authentication flow improvements</a></li>
<li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/web-authn-authenticator.md">Design proposal - WebAuthn Authenticator</a></li>
<li><a href="https://github.com/keycloak/keycloak-community/blob/master/design/web-authn-two-factor.md">Design proposal - WebAuthn Two factor</a></li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-7159">JIRA - Two factor</a></li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-9365">JIRA - Passwordless</a></li>
</ul>


<h3>Operator</h3>

<p>Operators are becoming an important way to manage software running on Kubernetes and we are working on an operator for
Keycloak. The aim is to have an operator published on <a href="https://operatorhub.io/">OperatorHub.io</a> soon which
provides basic install and seamless upgrade capabilities. This will be based on the awesome work done by the
Red Hat Integreatly team.</p>

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-7300">JIRA</a></li>
<li><a href="https://github.com/integr8ly/keycloak-operator">Integreatly Keycloak Operator</a></li>
</ul>


<h3>Vault</h3>

<p>At the moment to keep credentials such as LDAP bind credentials more secure it is required to encrypt the whole
database. This can be complex and can also have a performance overhead.</p>

<p>We are working towards enabling loading credentials, such as LDAP bind credential and SMTP password, from an external vault.
We're providing a built-in integration with Kubernetes secrets as well as an SPI allowing integrating with any vault provider.</p>

<p>In the future we will also provide the option to encrypt other more dynamic credentials at rest in the database.</p>

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-3205">JIRA - Vault</li>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-10774">JIRA - Encryption at rest</a></li>
</ul>


<h3>User Profile</h3>

<p>Currently there's no single place to define user profiles for a realm. To resolve this we are planning to introduce the Profile SPI,
which will make it possible to define a user profile for a realm. It will be possible to define mandatory as well as
optional attributes and also add validation to the attributes.</p>

<p>The built-in Profile SPI provider will make it possible to declaratively define the user profile for a realm and we
also aim to have an editor in the admin console.</p>

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-2966">JIRA</a></li>
</ul>


<h3>Observerability</h3>

<p>Keycloak already comes with basic support for metrics and health endpoints provided by the underlying WildFly container.
We plan to document how to enable this as well as extend with Keycloak specific metrics and health checks. If you would
like to try this out today check the WildFly documentation.</p>

<ul>
<li><a href="https://issues.jboss.org/browse/KEYCLOAK-8288">JIRA</a></li>
</ul>


<h3>Continuous Delivery</h3>

<p>Over the last few months the team has invested a significant amount of time into automated testing and builds. This
will pay of in the long run as we will need to spend less time on releases and will also make sure Keycloak is always
release ready. In fact we're taking this as far as not allowing maintainers to manually merge PRs anymore, but rather
have created a bot called the Merge Monster that will merge PRs automatically after they have been both manually reviewed
and all tests have passed.</p>


<h3>Keycloak.X</h3>

<p>It's 5 years since the first Keycloak release so high time for some rearchitecting. More details coming soon!</p>


<h3>Kanban Planning Board</h3>

<p>For more insight and details into what we are working on and our backlog, check out our
<a href="https://issues.jboss.org/secure/RapidBoard.jspa?rapidView=4740&quickFilter=17938&quickFilter=17950">
Kanban Planning Board</a>.