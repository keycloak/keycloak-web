<#--
title = Keycloak and Istio
date = 2018-02-26
publish = true
author = Sébastien Blanc
category = Istio
-->

<p>This short blog post is to share the first trials of combining Keycloak with Istio.</p>

<h3>What is Istio?</h3>

<p>Istio is an platform that provides a common way to manage your service mesh. You may wonder what a service mesh is, well, it's an infrastructure layer dedicated to connect, secure and make reliable your different services.</p>

<p>Istio, in the end, will be replacing all of our circuit-breakers, intelligent load balancing or metrics librairies, but also the way how two services will communicate in a secure way. And this is of course the interesting part for Keycloak.</p>

<p>As you know Keycloak uses adapters for each of the application or service that it secures. These adapters make sure to perform the redirect if needed, to retrieve the public keys, to verify the JWT signature etc ...</p>

<p>There are a lot of different adapters depending on the type of application or technology that is used : there are Java EE adapters, JavaScript adapters and we even have a NodeJS adapter.</p>

<h3>The end of the adapters?</h3>
<p>Following the Istio philosophy, these adapters would not be needed in the end because the Istio infrastructure will take care of the tasks the adapters were doing (signature verification etc ...). We are not yet there for now but in this post we will see what can already be done with Istio and how much it already can replace the role of the Adapters.</p>

<h3>The Envoy Sidecar</h3>

<p>We won't dive into the details on how Istio works but there is one main concept to understand around which Istio is articulated : the Envoy Sidecar. Envoy is a high performance proxy deployed alongside with each deployed service and this is the reason we call it a "sidecar".</p>

<p>Envoy captures all incoming and outgoing traffic of its "companion" service, it can then apply some basic operations and also collect data and send it to a central point of decision, called the "mixer" in Istio. The conifugration of Envoy itself happens through the "pilot" an other Istio component.</p>

<img src="${blogImages}/istio-architecture.png"/><div>

<h3>Envoy Filters</h3>

<p>To make it easier to add new functionnality to the Envoy Proxy, there is the concept of filters that you can stack up. Again, these filters can be congifured by the Pilot and they can gather information for the Mixer:</p>

<img src="${blogImages}/envoydetails.png" />

<h3>The JWT-Auth Filter</h3>

<p>The Istio team has been developping a filter that interest us : the jwt-auth filter. As the name suggests, this filter is capable of performing checks on a JWT token that the Envoy Proxy will extract from the HTTP Request's headers.</p>

<p>The details about this filters can be found <a href="https://github.com/istio/proxy/tree/master/src/envoy/http/jwt_auth">here</a>.</p>

<h3>The Keycloak-Istio Demo</h3>

<p>Now that you have the big picture in mind let's take a look at the demo that has been developed by Kamesh Sampath (@kamesh_sampath) From the Red Hat Developer Experience Team to show how Keycloak and Istio can be combined:</p>

<img src="${blogImages}/bigpicure1.png"/>

<p>The demo will be running inside a Minishift instance, Minishift is a tool that helps to run OpenShift locally. Minishift has really nice support for Istio, as it takes only a few commands to install the Istio layer inside a Minishift instance.</p>

<p>So inside our Minishift instance we will have:</p>

<ul>
<li>A Keycloak Pod : a pod containing a Keycloak Server.</li>
<li>A Web App Pod (Cars Web): this pod contains the Web App that will perform the authentification through the Keycloak login in order to obtain a JWT token</li>
<li>Then we have the Istio related components :</li>
    <ul>
    <li>The Pilot to configure the Envoy proxies</li>
    <li>The Mixer to handle the attributes returned by Envoy</li>
    </ul>
<li>The API Service (Cars API) : this pod will have two containers :</li>
    <ul>
    <li>The API service itself, in this case a simple Spring Boot Application</li>
    <li>The Envoy Side-Car container</li>
    </ul>
</ul>

<p>The demo repository provides the Istio script to delpoy the Envoy Sidecar alongside the Spring Boot Api Service.</p>

<p>Thi is how the Cars API Pod looks like after it is deployed:</p>

<img src="${blogImages}/carsapipod.png" />

<p>Now, the Envoy Sidecar needs to be configured:</p>

<ul>
<li>We indicate what needs to be configured, the kind of policy and implicitly the correct filter (in our case the jwt-auth filter) will be configured.</li>
<li>It needs to know where to retrieve Keycloak's Public key in order to verify the JWT signature.</li>
<li>The issuer : who has generated the token ? In this case it's also the Keycloak Server.</li>
</ul>

<img src="${blogImages}/pilotscript.png" />

<p>Now each incoming request to the API Service will be checked by the Envoy Sidecar to see if the JWT token contained in the header is valid or not. If it's valid the request be authorized otherwise an error message will be returned.</p>

<p>The full instructions of the demo (including setting up Minishift with Istio) can be found <a href="https://github.com/kameshsampath/istio-keycloak-demo">here</a>and again thanks to the awesome Kamesh for the work he delivered for this demo.</p>