<#--
title = Keycloak and Angular CLI
date = 2018-02-09
publish = true
author = Stan Silvert
category = AngularJS
-->

<p>So I made a <a href="https://blog.angular.io/schematics-an-introduction-dc1dfbc2a2b2" target="_blank">schematic</a></span> that installs and configures <a href="https://github.com/ssilvert/keycloak-schematic/wiki/Getting-Started" target="_blank">Keycloak in any Angular CLI application</a>.</p>

<p>If you want to try it out, do this from the command line:</p>

<pre>
npm install -g @ssilvert/keycloak-schematic
ng new myApp</span>
cd myApp
ng generate keycloak --collection @ssilvert/keycloak-schematic --clientId=myApp
</pre>

<p>Now Keycloak is integrated into your app.&nbsp; Of course, you can do this with any existing Angular CLI application.&nbsp; It doesn't have to be a new one.</p>

<p>Then, go to the Keycloak Admin console (master realm) and go to Clients --&gt; Add Client --&gt; Select File.</p>

<p>Select the client-import.json file that the "ng generate keycloak" command created in /myApp.</p>

<p>Assuming your Keycloak server is running on localhost:8080, you are ready to go.&nbsp; Start your application:</p>
<pre>ng serve</pre>

<p>Go to your browser to start the app and see this:</p>

<img src="${blogImages}/login.png"/>

<p>Oh joy! myApp is protected with Keycloak!</p>

<p>The <a href="https://github.com/ssilvert/keycloak-schematic" target="_blank">keycloak-schematic</a> installs a KeycloakService and a KeycloakGuard.&nbsp; So you can easily:</p>

<ul>
<li>Add login/logout buttons</li>
<li>Access user self service (account management)</li>
<li>Guard protected routes instead of the whole app</li>
<li>Work with roles</li>
<li>Lots more</li>
</ul>

<p><a href="https://github.com/ssilvert/keycloak-schematic/wiki/Getting-Started" target="_blank">Click here</a> for a comprehensive getting started guide, full documentation, and sample code.</p>

<p>Note that this stuff is early alpha right now.&nbsp; And it will move from&nbsp;@ssilvert to @keycloak before long.&nbsp; In the mean time, I'd love to get feedback.&nbsp; There is a lot to do to make Keycloak/Angular integration even better, but I think the <a href="https://github.com/ssilvert/keycloak-schematic" target="_blank">keycloak-schematic</a> is a big step forward.</p>

<p>So long, and thanks for all the fish.</p>