<#--
title = Kubernetes as a default IdP in Minikube
date = 2020-01-27
publish = true
author = Sebastian Łaskawiec
category = Kubernetes
-->

<p>This blog post shows how to use Keycloak as an Identity Provider in Minikube</p>

</br>
<h3>Introduction</h3>

<p>Using Keycloak in Kubernetes is oftentimes referred as Day 2 Operations. In a typical organization, there's a central place with all the information about users. Keycloak might be easily used as such a place or may connect to some other tool (using <a href="https://www.keycloak.org/docs/latest/server_admin/#_identity_broker">Identity Brokering feature</a>). In this blog post I'll show you how to use Keycloak-generated Tokens to access Kubernetes via <span>kubectl</span>.</p>

</br>
<h3>The demo</h3>

<p>Throughout the blog post I will be using tools implemented in <a href="https://github.com/slaskawi/keycloak-minikube-idp-demo">my Github repository</a>.</p>

</br>
<h4>Preparing Keycloak</h4>

<p>The first step is to prepare Keycloak distribution. Once it's downloaded, we'll add an <span>admin</span> user and setup TLS certificates. This will include calling <span>keytool</span> and <span>openssl</span> commands.</p>

<p>I'll omit downloading and unpacking the server and focus on generating both a Keystore used by Keycloak for TLS and a Truststore used by Kubernetes and by us - to generate new tokens.</p>

<p>There are two ways of generating a Keystore and a Truststore. The first one starts with OpenSSL and then imports everything to using KeyTool and the other does this the other way around. I'll use the latter method, since it's slightly more complicated. The <span>$KEYCLOAK_HOST<span> variable contains a public name, which will be used for hosting Keycloak. In my case, it's <span>192-168-0-8.nip.io</span>, which resolves to my public IP address.</p>

<p>
<ul>
<li>Generate a new key - <span>keytool -genkey -noprompt -trustcacerts -keyalg RSA -alias "server" -dname "CN=$(KEYCLOAK_HOST)" -keypass "password" -storepass "password" -keystore "application.keystore"</span></li>
<li>Export public key certificate - <span>keytool -export -keyalg RSA -alias "server" -storepass "password" -file "client.cer" -keystore "application.keystore"</span></li>
<li>Import the certificate - <span>keytool -import -noprompt -v -trustcacerts -keyalg RSA -alias "server" -file "client.cer" -keypass "password" -storepass "password" -keystore "client.truststore"</span></li>
<li>Export the client certificate into PKCS12 - <span>keytool -importkeystore -srckeystore client.truststore -destkeystore client.p12 -srcstoretype jks -deststoretype pkcs12 -srcstorepass "password" -deststorepass "password"</span></li>
<li>Remove the password - <span>openssl pkcs12 -in client.p12 -out client.pem -passin pass:password</span></li>
</ul>
</p>

<p>Once the above procedure is done, we should have <span>client.pem</span> file, which needs to be used, when connecting to Keycloak (e.g. <span>curl --cacert ./client.pem  https://$KEYCLOAK_HOST:8443</span>). The last step is to put <span>application.truststore</span> into <span>$KEYCLOAK/standalone/configuration</span>.</p>

<p>The final part is to import a prepared Realm into Keycloak. We will be using Realm name "kubernetes" and a client "kubernetes". Here are the important parts of the configuration:</p>

<img src="${blogImages}/keycloak-kubernetes-client.png" />
<img src="${blogImages}/keycloak-kubernetes-audience-mapper-1.png" />
<img src="${blogImages}/keycloak-kubernetes-audience-mapper-2.png" />
<img src="${blogImages}/keycloak-kubernetes-test-user.png" />

<br></br>

<p>
To sum up, we'll need:
<ul>
<li>"kubernetes" Realm with "kubernetes" Client</li>
<li>Audience Mapper to include expected (by Kubernetes) audience field</li>
<li>"test" user with verified email</li>
</ul>
</p>

<br></br>
<h4>Bootstrapping Minikube</h4>

<p>One of the least obvious things is that we'll need to bootstrap Minikube two times. At first we need a default configuration and we'll upload a <span>client.pem</span>, so that Kubernetes could connect to Keycloak. Then, we'll bootstrap it again with the following configuration:</p>

<pre>
minikube start --v=5 \
    --extra-config=apiserver.oidc-issuer-url=https://$KEYCLOAK_HOST:8443/auth/realms/kubernetes \
    --extra-config=apiserver.oidc-client-id=kubernetes \
    --extra-config=apiserver.oidc-username-claim=email \
    --extra-config=apiserver.oidc-ca-file=/var/lib/minikube/certs/client.pem
</pre>

<p>The above configures Minikube to use emails as usernames (we could use preferred names here as well) and sets up client certificate to be used when connecting to Keycloak.</p>

</br>
<h4>All in one</h4>

<p>
The <a href="https://github.com/slaskawi/keycloak-minikube-idp-demo">github repository</a> contains a Makefile, which speeds the process of setting everything up:
<ul>
<li>Prepare Keycloak - <span>make keycloak/download keycloak/unpack cert/generate cert/install keycloak/user</span></li>
<li>Run Keycloak - <span>make keycloak/start</span></li>
<li>Import the Realm - <span>make keycloak/prepare</span></li>
<li>Prepare Minikube - <span>make minikube/start</span></li>
</ul>
</p>

</br>
<h4>Getting the token</h4>

<p>In order to get the token, we'll use Credentials Grant. Once we obtain an Access Token, we'll reconfigure <span>kubectl</span> client:</p>

<pre>
curl -s --cacert ./client.pem "https://$KEYCLOAK_HOST:8443/auth/realms/kubernetes/protocol/openid-connect/token" -d grant_type=password -d response_type=id_token -d scope=email -d client_id="kubernetes" -d username="test" -d password="test"
</pre>

<p>The next step is to reconfigure <span>kubectl</span>:</p>

<pre>
kubectl config set-credentials "test@test.com" \
--auth-provider=oidc \
--auth-provider-arg=idp-certificate-authority="$(pwd)/client.pem" \
--auth-provider-arg=idp-issuer-url="https://$KEYCLOAK_HOST:8443/auth/realms/kubernetes" \
--auth-provider-arg=client-id="kubernetes" \
--token $ACCESS_TOKEN

kubectl config set-context test@test.com --cluster=minikube --user=test@test.com --namespace=default
kubectl config use-context test@test.com
</pre>

</br>
<h4>Invoking kubectl</h4>

<p>Once all the above is done - invoke:</p>

<pre>
kubectl get nodes
</pre>

<p>If the above configuration worked, you will get:</p>

<pre>
Error from server (Forbidden): nodes is forbidden: User "test@test.com" cannot list resource "nodes" in API group "" at the cluster scope
</pre>

<p>This means, test@test.com user doesn't have sufficient permissions. It's OK, as we haven't added <span>permissions.yaml</span>. You may do it before switching to test@test.com user.</p>

<h3>Final thoughts</h3>

<p>Throughout the demo, we learned how to configure both Keycloak and Minikube to work together. Once everything was configured correctly we used Credentials Grant to obtain an Access Token and then used it to configure <span>kubectl</span>. Of course, later on, we might want to modify the session timeout and probably enable Identity Brokering with other tools.</p>

</br>

<p>I hope you enjoyed the demo!</p>

<h3>References</h3>

<p>When working on this demo, I found two great configuration examples:</p>

<p>
<ul>
<li><a href="https://medium.com/@mrbobbytables/kubernetes-day-2-operations-authn-authz-with-oidc-and-a-little-help-from-keycloak-de4ea1bdbbe">Kubernetes Day 2 Operation written by Bob Killen</li>
<li><a href="https://github.com/mrbobbytables/oidckube">A wrapper for minikube that integrates with Keycloak by Bob Killen</li>
</ul>
</p>
