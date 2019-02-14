<#--
title = Red Hat Single Sign-On in Keynote demo on Red Hat Summit!
date = 2018-06-17
publish = true
author = Marek Posolda
-->

<p>Red Hat Summit is one of the most important events during the year. Many geeks, Red Hat employees and customers have great opportunity to meet, learn new things and attend lots of interesting presentations and trainings. During the summit this year, there were few breakout sessions, which were solely about Keycloak and Red Hat SSO. You can take a look at <a href="http://blog.keycloak.org/2018/05/red-hat-single-sign-on-red-hat-summit.html">this blogpost</a> for more details.

<p>One of the most important parts of Red Hat Summit are Keynote demos, which show the main bullet points and strategies going forward. Typically they also contain the demos of the most interesting technologies, which Red Hat uses.

<p>On the Thursday morning keynote, there was <a href="https://www.youtube.com/watch?v=hu2BmE1Wk_Q&feature=youtu.be&t=385">this demo</a> to show the Hybrid Cloud with 3 clouds (Azure, Amazon, Private) in action! There were many technologies and interesting projects involved. Among others, let's name <a href="https://www.redhat.com/en/technologies/jboss-middleware/data-grid">Red Hat JBoss Data Grid (JDG)</a>, <a href="https://openwhisk.apache.org/">OpenWhisk</a> or <a href="https://www.gluster.org/">Gluster FS</a>. The <a href="https://access.redhat.com/products/red-hat-single-sign-on">RH-SSO</a> (Red Hat product based on Keycloak project) had a honor to be used as well.

<h2>Red Hat SSO setup details</h2>

<p>The frontend of the demo was the simple mobile game. RH-SSO was used at the very first stage to authenticate users to the mobile game. Each attendee had an opportunity to try it by yourself. In total, we had 1200 players of the game.

<p>There was loadbalancer up-front and every user was automatically forwarded to one of the 3 clouds. The mobile application used <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/securing_applications_and_services_guide/openid_connect_3#javascript_adapter">RH-SSO Javascript adapter</a> (keycloak.js) to communicate with RH-SSO.

<p>With Javascript application, whole OpenID Connect login flow happens within browser and hence can rely on sticky session. So since Javascript adapter is used, you may think that we can do just "easy" setup and let the RH-SSO instances across all 3 clouds to be independent of each other and have each of them to use separate RDBMS and infinispan caches. See the image below  for what such a setup would look like:

<img src="${blogImages}/cross-dc-blog-architecture-rhsso.png" />

<p>With this setup, every cloud is aware just about the users and sessions created on itself. This is fine with sticky session, but it won’t work for failover scenarios in case if one of the 3 clouds is broken/removed. There are also other issues with it - for example that admins and users see just sessions created on particular cloud. There are also potential security issues. For example when admin disables user on one cloud, user would still be enabled on other clouds as changes to user won’t be propagated to other clouds.

<p>So we rather want to show more proper setup aware of the replication. Also because one part of the demo was showing failover in action. One of the 3 clouds (Amazon) was killed and users, who were previously logged in Amazon, were redirected to one of the remaining 2 clouds. The point was that the end user won't be able to recognize any change. Hence users previously logged in Amazon must be still able to refresh their tokens in Azure or Private cloud. This in turn meant that the data (both users, user sessions and caches) need to be aware of all 3 clouds.

<p>In Keycloak 3.X, we added support for <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/server_installation_and_configuration_guide/operating-mode#crossdc-mode">Cross-datacenter (Cross-site) setup</a> with usage of external JDG servers to replicate data among datacenters (tech preview in RH-SSO 7.2). The demo was using exactly this setup. Each site had JDG server and all 3 sites communicate with each other through those JDG servers. This is standard JDG Cross-DC setup. See the picture below for what the demo looked like:

<img src="${blogImages}/cross-dc-blog-actual-setup-architecture-rhsso.png" />

<p>The JDG servers were not used during the demo just for the purpose of the RH-SSO, but also for the purpose of other parts of the demo. The details are described in the <a href="https://developers.redhat.com/blog/2018/06/19/red-hat-data-grid-on-three-clouds/">JDG setup blog by  Sebastian Łaskawiec</a>. The JDG servers were setup with ASYNC backups, which was more effective and was completely fine for the purpose of the demo due the fact that mobile application was using keycloak.js adapter. See <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/server_installation_and_configuration_guide/operating-mode#backups">RH-SSO docs</a> for more details.

<h2>Red Hat SSO customizations</h2>

<p>The RH-SSO was using standard <a href="https://access.redhat.com/documentation/en-us/red_hat_jboss_middleware_for_openshift/3/html/red_hat_single_sign-on_for_openshift/">RH-SSO openshift image</a> . For Cross-DC setup, we needed to do configuration changes as described in the <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/server_installation_and_configuration_guide/operating-mode#crossdc-mode">RHSSO documentation</a> . Also few other customizations were done.

<h3>JDG User Storage</h3>

<p>RH-SSO Cross-DC setup currently requires both replicated RDBMS and replicated JDG server. When preparing to demo, we figured that using the clustered RDBMS in OpenShift replicated across all 3 clouds, is not very straightforward thing to setup.

<p>Fortunately RH-SSO is highly customizable platform and among other things, it provides supported <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/server_administration_guide/user-storage-federation">User Storage SPI</a> , which allows customers to plug their own storage for RH-SSO users. So instead of setup of replicated RDBMS, we created custom JDG User Storage. So users of the example realm were saved inside JDG instead of the RDBMS Database.

<p>Lessons learned is, that we want to make the Keycloak/RH-SSO Cross-DC setup simpler for administrators. Hence we're considering removing the need for replicated RDBMS entirely and instead store all realms and users metadata within JDG. So just replicated JDG would be a requirement for Cross-DC setup.

<h3>Other customizations</h3>

<p>For the purpose of the demo, we did custom login theme. We also did Email-Only authenticator, which allows to register user just by providing their email address. This is obviously not very secure, but it's pretty neat for the example purpose. Keynote users were also able to login with <a href="https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.2/html/server_administration_guide/identity_broker#google">Google Identity Provider</a>  or <a href="https://developers.redhat.com/">Red Hat Developers OpenID Connect Identity Provider</a>, which was useful for users, who already had an account in those services.

<img src="${blogImages}/login-screen.png" />

<p>If you want to try all these things in action, you can try to checkout our <a href="https://github.com/rhdemo/rh-sso">Demo Project on Github</a> and deploy it to your own openshift cluster! If you have 3 clouds, even better! You can try the full setup including JDG to try exactly the setup we used during keynote demo.








