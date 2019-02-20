<#--
title = Cross-Datacenter support in Keycloak
date = 2017-09-06
publish = true
author = Marek Posolda
category = Cross Datacenter/Replication/Infinispan
-->

<p>In Keycloak 3.3.0.CR1 we added basic setup for cross-datacenter (cross-site) replication. This blogpost covers some details about it. It consists of 2 parts:

<p>
<ul>
<li>Some technical details and challenges, which we needed to address</li>
<li>Example setup</li>
</ul>
<p>If you're not interested in too much details, but rather want to try things, feel free to go directly to the example. Or viceversa :-)

<p>
Here is the picture with the basic example architecture

<a href="https://4.bp.blogspot.com/-TuP-tUCytyY/Wa-1b33MTxI/AAAAAAAAIjA/FSSSzfDP1uMqlhkyUqayb4NJwH-O7EFZQCLcBGAs/s1600/Cross-site%2Bdiagram.jpg" imageanchor="1"><img border="0" data-original-height="720" data-original-width="960" src="https://4.bp.blogspot.com/-TuP-tUCytyY/Wa-1b33MTxI/AAAAAAAAIjA/FSSSzfDP1uMqlhkyUqayb4NJwH-O7EFZQCLcBGAs/s1600/Cross-site%2Bdiagram.jpg" /></a>

<p>
<h2>
Technical details</h2>
In typical scenario, end user's browser sends HTTP request to the frontend loadbalancer server. This is usually HTTPD or Wildfly with mod_cluster, NGinx, HA Proxy or other kind of software or hardware loadbalancer. Loadbalancer then forwards HTTP requests to the underlying Keycloak instances, which can be spread among multiple datacenters (sites). Loadbalancers typically offer support for <i>sticky sessions</i>, which means that loadbalancer is able to forward HTTP requests from one user always to the same Keycloak instance in same datacenter.

<p>
There are also HTTP requests, which are sent from client applications to the loadbalancer. Those HTTP requests are <i>backchannel requests</i>. They are not seen by end user's browser and can't be part of sticky session between user and loadbalancer and hence loadbalancer can forward the particular HTTP request to any Keycloak instance in any datacenter. This is challenging as some OpenID Connect or SAML flows require multiple HTTP requests from both user and application. Because we can't reliably rely on sticky sessions, it means that some data need to be replicated between datacenters, so they are seen by subsequent HTTP requests during particular flow.

<p>
<h4>
Authentication sessions</h4>
In Keycloak 3.2.0 we did some refactoring and introduced authentication sessions. There is separate infinispan cache <i>authenticationSessions</i> used to save data during authentication of particular user. This cache usually involves just browser and Keycloak server, not the application. Hence we usually can rely on sticky sessions and <i>authenticationSessions</i> cache content usually doesn't need to be replicated among datacenters.

<p>
<h4>
Action tokens</h4>
In 3.2.0 we introduced also action tokens, which are used typically for scenarios when user needs to confirm some actions asynchronously by email. For example during <i>forget password</i> flow. The <i>actionTokens</i> infinispan cache is used to track metadata about action tokens (eg. which action token was already used, so it can't be reused second time) and it usually needs to be replicated between datacenters.

<p>
<h4>
Database</h4>
Keycloak uses RDBMS to persist some metadata about realms, clients, users etc. In cross-datacenter setup, we assume that either both datacenters talk to same database or every datacenter has it's own database, but both databases are synchronously replicated. In other words, when Keycloak server in site 1 persists any data and transaction is commited, those data are immediatelly visible by subsequent DB transactions on site 2.

<p>
Details of DB setup are out-of-scope of Keycloak, however note that many RDBMS vendors like PostgreSQL or MariaDB offers replicated databases and synchronous replication. Databases are not shown in the example picture above just to make it a bit simpler.

<p>
<h4>
Caching and invalidation of persistent data</h4>
Keycloak uses infinispan for cache persistent data to avoid many unecessary requests to the database. Caching is great for save performance, however there is one additional challenge, that when some Keycloak server updates any data, all other Keycloak servers in all datacenters need to be aware of it, so they invalidate particular data from their caches. Keycloak uses local infinispan caches called <i>realms</i>, <i>users</i> and <i>authorization</i> to cache persistent data.

<p>
We use separate cache <i>work</i>, which is replicated among all datacenters. The <i>work</i> cache itself doesn't cache any real data. It is defacto used just for sending invalidation messages between cluster nodes and datacenters. In other words, when some data is updated (eg. user "john" is updated), the particular Keycloak node sends the invalidation message to all other cluster nodes in same datacenter and also to all other datacenters. Every node then invalidates particular data from their local cache once it receives the invalidation message.

<p>
<h4>
User sessions</h4>
There are infinispan caches <i>sessions</i> and <i>offlineSessions</i>, which usually need to be replicated between datacenters. Those caches are used to save data about <i>user sessions</i>, which are valid for the whole life of one user's browser session. The caches need to deal with the HTTP requests from the end user and from the application. As described above, sticky session can't be reliably used, but we still want to ensure that subsequent HTTP requests can see the latest data. Hence the data are replicated.

<p>
<h4>
Brute force protection</h4>
Finally <i>loginFailures</i> cache is used to track data about failed logins (eg. how many times user <i>john</i> filled the bad password on username/password screen etc). It is up to the admin if he wants this cache to be replicated between datacenters. To have accurate count of login failures, the replication is needed. On the other hand, avoid replicating this data can save some performance. So if performance is more important then accurate counts of login failures, the replication can be avoided.

<p>
<h4>
Communication details</h4>
Under the covers, there are multiple separate infinispan clusters here. Every Keycloak node is in the cluster with the other Keycloak nodes in same datacenter, but not with the Keycloak nodes in different datacenters. Keycloak node doesn't communicate directly with the Keycloak nodes from different datacenters. Keycloak nodes use external JDG (or infinispan server) for communication between datacenters. This is done through the <a href="http://infinispan.org/docs/8.2.x/user_guide/user_guide.html#using_hot_rod_server">Infinispan HotRod protocol</a>.

<p>
The infinispan caches on Keycloak side needs to be configured with the <a href="http://infinispan.org/docs/8.2.x/user_guide/user_guide.html#remote_store">remoteStore</a>, to ensure that data are saved to the <i>remote cache</i>, which uses HotRod protocol under the covers. There is separate infinispan cluster between JDG servers, so the data saved on JDG1 on site 1 are replicated to JDG2 on site 2.

<p>
Finally the receiver JDG server then notifies Keycloak servers in it's cluster through the <i>Client Listeners</i>, which is feature of HotRod protocol. Keycloak nodes on site 2 then update their infinispan caches and particular userSession is visible on Keycloak nodes on <i>site 2</i> too.

<p>
<h2>
Example setup</h2>
This is the example setup simulating 2 datacenters <i>site 1</i> and <i>site 2</i> . Each datacenter (site) consists of 1 infinispan server and 2 Keycloak servers.
So 2 infinispan servers and 4 Keycloak servers are totally in the testing setup.

<p>
<ul>
<li>Site1 consists of infinispan server <i>jdg1</i> and 2 Keycloak servers <i>node11</i> and <i>node12</i> .</li>
<li>Site2 consists of infinispan server <i>jdg2</i> and 2 Keycloak servers <i>node21</i> and <i>node22</i> .</li>
<li>Infinispan servers <i>jdg1</i> and <i>jdg2</i> forms cluster with each other and they are used as a channel for communication between 2 datacenters. Again, in production, there is also clustered DB used for replication between datacenters (each site has it's own DB), but that's not the case in the example, which would just use single DB.</li>
<li>Keycloak servers <i>node11</i> and <i>node12</i> forms cluster with each other, but they don't communicate with any server in <i>site2</i> . They communicate with infinispan server <i>jdg1</i> through the HotRod protocol (Remote cache).</li>
<li>Same applies for <i>node21</i> and <i>node22</i> . They have cluster with each other and communicate just with <i>jdg2</i> server through the HotRod protocol.</li>
</ul>
Example setup assumes all 6 servers are bootstrapped on localhost, but each on different ports. It also assumes that all 4 Keycloak servers talk to same database, which can be either locally set MySQL, PostgreSQL, MariaDB or any other. In production, there will be rather separate synchronously replicated databases between datacenters.

<p>
<h3>
Infinispan Server setup</h3>
1) Download Infinispan 8.2.6 server and unzip to some folder

<p>
2) Add this into <i>JDG1_HOME/standalone/configuration/clustered.xml</i> into cache-container named <i>clustered</i> :

<p>
<pre>&lt;cache-container name="clustered" default-cache="default" statistics="true"&gt;
        ...
        &lt;replicated-cache-configuration name="sessions-cfg" mode="ASYNC" start="EAGER" batching="false"&gt;
            &lt;transaction mode="NON_XA" locking="PESSIMISTIC"/&gt;
        &lt;/replicated-cache-configuration&gt;

        &lt;replicated-cache name="work" configuration="sessions-cfg" /&gt;
        &lt;replicated-cache name="sessions" configuration="sessions-cfg" /&gt;
        &lt;replicated-cache name="offlineSessions" configuration="sessions-cfg" /&gt;
        &lt;replicated-cache name="actionTokens" configuration="sessions-cfg" /&gt;
        &lt;replicated-cache name="loginFailures" configuration="sessions-cfg" /&gt;

&lt;/cache-container&gt;
</pre>
3) Copy the server into the second location referred later as <i>JDG2_HOME</i>

<p>
4) Start server <i>jdg1</i>:

<p>
<pre>cd JDG1_HOME/bin
./standalone.sh -c clustered.xml -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=1010 -Djboss.default.multicast.address=234.56.78.99 \
-Djboss.node.name=jdg1
</pre>
5) Start server <i>jdg2</i>:

<p>
<pre>cd JDG2_HOME/bin
./standalone.sh -c clustered.xml -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=2010 -Djboss.default.multicast.address=234.56.78.99 \
-Djboss.node.name=jdg2
</pre>
6) There should be message in the log that nodes are in cluster with each other:

<p>
<pre>Received new cluster view for channel clustered: [jdg1|1] (2) [jdg1, jdg2]
</pre>

<h3>Keycloak servers setup</h3>
<p>
1) Download Keycloak 3.3.0.CR1 and unzip to some location referred later as <i>NODE11</i>

<p>2) Configure shared database for KeycloakDS datasource. Recommended to use MySQL, MariaDB or PostgreSQL. See Keycloak docs for more details

<p>3) Edit <i>NODE11/standalone/configuration/standalone-ha.xml</i> :

<p>3.1) Add attribute <i>site</i> to the JGroups UDP protocol:

<p>
<pre>
&lt;stack name="udp">
    &lt;transport site="&amp;{jboss.site.name}" socket-binding="jgroups-udp" type="UDP">
</pre>

3.2) Add output-socket-binding for <i>remote-cache</i> into <i>socket-binding-group</i> element:

<p>
<pre>
&lt;socket-binding-group ... &gt;
    ...
    &lt;outbound-socket-binding name="remote-cache"&gt;
        &lt;remote-destination host="localhost" port="&amp;{remote.cache.port}"&gt;
        &lt;/remote-destination&gt;
    &lt;/outbound-socket-binding&gt;

&lt;/socket-binding-group&gt;
</pre>

3.3) Add this <i>module</i> attribute into <i>cache-container</i> element of name <i>keycloak</i> :

<pre>
 &lt;cache-container jndi-name="infinispan/Keycloak" module="org.keycloak.keycloak-model-infinispan" name="keycloak"&gt;
</pre>

3.4) Add the <i>remote-store</i> into <i>work</i> cache:

<p>
<pre>
&lt;replicated-cache mode="SYNC" name="work"&gt;
    &lt;remote-store cache="work" fetch-state="false" passivation="false" preload="false"
          purge="false" remote-servers="remote-cache" shared="true"&gt;
        &lt;property name="rawValues"&gt;true&lt;/property&gt;
        &lt;property name="marshaller"&gt;org.keycloak.cluster.infinispan.KeycloakHotRodMarshallerFactory&lt;/property&gt;
    &lt;/remote-store&gt;
&lt;/replicated-cache&gt;
</pre>

3.5) Add the <i>store</i> like this into <i>sessions</i> cache:

<p>
<pre>
&lt;distributed-cache mode="SYNC" name="sessions" owners="1"&gt;
    &lt;store class="org.keycloak.models.sessions.infinispan.remotestore.KeycloakRemoteStoreConfigurationBuilder"
      fetch-state="false" passivation="false" preload="false" purge="false" shared="true"&gt;
        &lt;property name="remoteCacheName"&gt;sessions&lt;/property&gt;
        &lt;property name="useConfigTemplateFromCache"&gt;work&lt;/property&gt;
    &lt;/store&gt;
&lt;/distributed-cache&gt;
</pre>

3.6) Same for <i>offlineSessions</i> and <i>loginFailures</i> caches:

<p>
<pre>
&lt;distributed-cache mode="SYNC" name="offlineSessions" owners="1"&gt;
    &lt;store class="org.keycloak.models.sessions.infinispan.remotestore.KeycloakRemoteStoreConfigurationBuilder"
      fetch-state="false" passivation="false" preload="false" purge="false" shared="true"&gt;
        &lt;property name="remoteCacheName"&gt;offlineSessions&lt;/property&gt;
        &lt;property name="useConfigTemplateFromCache"&gt;work&lt;/property&gt;
    &lt;/store&gt;
&lt;/distributed-cache&gt;


&lt;distributed-cache mode="SYNC" name="loginFailures" owners="1"&gt;
    &lt;store class="org.keycloak.models.sessions.infinispan.remotestore.KeycloakRemoteStoreConfigurationBuilder"
      fetch-state="false" passivation="false" preload="false" purge="false" shared="true"&gt;
        &lt;property name="remoteCacheName"&gt;loginFailures&lt;/property&gt;
        &lt;property name="useConfigTemplateFromCache"&gt;work&lt;/property&gt;
    &lt;/store&gt;
&lt;/distributed-cache&gt;

</pre>

<p>
3.7) The configuration of distributed cache <i>authenticationSessions</i> and other caches is left unchanged.

<p>
3.8) Optionally enable DEBUG logging into <i>logging</i> subsystem:
<p>
<pre>
&lt;logger category="org.keycloak.cluster.infinispan"&gt;
    &lt;level name="DEBUG"&gt;
&lt;/level&gt;&lt;/logger&gt;
&lt;logger category="org.keycloak.connections.infinispan"&gt;
    &lt;level name="DEBUG"&gt;
&lt;/level&gt;&lt;/logger&gt;
&lt;logger category="org.keycloak.models.cache.infinispan"&gt;
    &lt;level name="DEBUG"&gt;
&lt;/level&gt;&lt;/logger&gt;
&lt;logger category="org.keycloak.models.sessions.infinispan"&gt;
    &lt;level name="DEBUG"&gt;
&lt;/level&gt;&lt;/logger&gt;
</pre>

<p>
4) Copy the <i>NODE11</i> to 3 other directories referred later as <i>NODE12</i>, <i>NODE21</i> and <i>NODE22</i>.

<p>
5) Start <i>NODE11</i> :

<p>
<pre>
cd NODE11/bin
./standalone.sh -c standalone-ha.xml -Djboss.node.name=node11 -Djboss.site.name=site1 \
-Djboss.default.multicast.address=234.56.78.100 -Dremote.cache.port=12232 -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=3000
</pre>

<p>
6) Start <i>NODE12</i> :

<pre>
cd NODE12/bin
./standalone.sh -c standalone-ha.xml -Djboss.node.name=node12 -Djboss.site.name=site1 \
-Djboss.default.multicast.address=234.56.78.100 -Dremote.cache.port=12232 -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=4000
</pre>

<p>
The cluster nodes should be connected. This should be in the log of both NODE11 and NODE12:

<pre>
Received new cluster view for channel hibernate: [node11|1] (2) [node11, node12]
</pre>

7) Start <i>NODE21</i> :

<p>
<pre>
cd NODE21/bin
./standalone.sh -c standalone-ha.xml -Djboss.node.name=node21 -Djboss.site.name=site2 \
-Djboss.default.multicast.address=234.56.78.101 -Dremote.cache.port=13232 -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=5000
</pre>

<p>
It shouldn't be connected to the cluster with <i>NODE11</i> and <i>NODE12</i>, but to separate one:

<p>
<pre>
Received new cluster view for channel hibernate: [node21|0] (1) [node21]
</pre>

8) Start <i>NODE22</i> :

<p>
<pre>
cd NODE22/bin
./standalone.sh -c standalone-ha.xml -Djboss.node.name=node22 -Djboss.site.name=site2 \
-Djboss.default.multicast.address=234.56.78.101 -Dremote.cache.port=13232 -Djava.net.preferIPv4Stack=true \
-Djboss.socket.binding.port-offset=6000
</pre>


<p>
It should be in cluster with <i>NODE21</i> :

<pre>
Received new cluster view for channel server: [node21|1] (2) [node21, node22]
</pre>

<p>
9) Test:

<p>
9.1) Go to <a href="http://localhost:11080/auth/">http://localhost:11080/auth/</a> and create initial admin user

<p>
9.2) Go to <a href="http://localhost:11080/auth/admin">http://localhost:11080/auth/admin</a> and login as admin to admin console

<p>
9.3) Open 2nd browser and go to any of nodes <a href="http://localhost:12080/auth/admin">http://localhost:12080/auth/admin</a> or <a href="http://localhost:13080/auth/admin">http://localhost:13080/auth/admin</a> or <a href="http://localhost:14080/auth/admin">http://localhost:14080/auth/admin</a> . After login, you should be able to see
the same sessions in tab <i>Sessions</i> of particular user, client or realm on all 4 servers

<p>
9.4) After doing any change (eg. update some user), the update should be immediatelly visible on any of 4 nodes as caches should be properly invalidated everywhere.

<p>
9.5) Check server.logs if needed. After login or logout, the message like this should be on all the nodes <i>NODEXY/standalone/log/server.log</i> :

<pre>
2017-08-25 17:35:17,737 DEBUG [org.keycloak.models.sessions.infinispan.remotestore.RemoteCacheSessionListener]
(Client-Listener-sessions-30012a77422542f5) Received event from remote store.
Event 'CLIENT_CACHE_ENTRY_REMOVED', key '193489e7-e2bc-4069-afe8-f1dfa73084ea', skip 'false'
</pre>

<h2>Conclusion</h2>

<p>
This is just a starting point and the instructions are subject to change. We plan various improvements especially around performance. If you
have any feedback regarding cross-dc scenario, please let us know on keycloak-user mailing list referred from <a href="http://www.keycloak.org/community.html">Keycloak home page</a> .