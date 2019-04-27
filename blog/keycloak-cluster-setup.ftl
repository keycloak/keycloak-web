<#--
title = Keycloak Cluster Setup
date = 2019-04-27
publish = true
author = 张立强 liqiang@fit2cloud.com
category = Cluster
-->

<p xmlns="http://www.w3.org/1999/html">This post shares some solutions to setup Keycloak cluster in various scenarios (e.g. cross-DC, docker cross-host, Kubernetes).</p>

<p>If you'd like to setup Keycloak cluster, this blog may give you some reference.</p>

<p>Two cli script files are added to the <a href="https://hub.docker.com/r/jboss/keycloak/">Keycloak image</a> as per the <a href="https://github.com/jboss-dockerfiles/keycloak/blob/master/server/README.md#adding-custom-discovery-protocols">guide</a>, these two files are the most important matter for this blog, you can find them from <a href="${blogImages}/keycloak-cluster-setup/TCPPING.cli">TCPPING.cli</a> and <a href="${blogImages}/keycloak-cluster-setup/JDBC_PING.cli">JDBC_PING.cli</a>.</p>

<img src="${blogImages}/keycloak-cluster-setup/dockerfile.jpg"/>

<p>First of all we should know that for a Keycloak cluster, all keycloak instances should use same database and this is very simple, another thing is about cache(generally there are two kinds of cache in Keycloaks, the 1st is persistent data cache read from database aim to improve performance like realm/client/user, the 2nd is the non-persistent data cache like sessions/clientSessions, the 2nd is very important for a cluster) which is a little bit complex to configure, we have to make sure the consistent of cache in a cluster view.</p>

<p>Totally here are 3 solutions for clustering, and all of the solutions are base on the discovery protocols of <a href="http://jgroups.org/">JGroups</a> (Keycloak use <a href="http://infinispan.org/">Infinispan</a> cache and Infinispan use JGroups to discover nodes).</p>

<h3>1. PING</h3>
<p><a href="http://jgroups.org/manual/#PING">PING</a> is the default enabled clustering solution of Keycloak using UDP protocol, and you don't need to do any configuration for this.</p>
<p>But PING is only available when multicast network is enabled and port 55200 should be exposed, e.g. bare metals, VMs, docker containers in the same host.</p>
<img src="${blogImages}/keycloak-cluster-setup/ping-deployment.jpg"/>
<p>We tested this by two Keycloak containers in same host.</p>
<p>The logs show that the two Keycloak instances discovered each other and clustered.</p>
<img src="${blogImages}/keycloak-cluster-setup/ping-log.png"/>

<h3>2. TCPPING</h3>
<p><a href="http://jgroups.org/manual/#TCPPING_Prot">TCPPING</a> use TCP protocol with 7600 port. This can be used when multicast is not available, e.g. deployments cross DC, containers cross host.</p>
<img src="${blogImages}/keycloak-cluster-setup/tcp-ping-deployment.jpg"/>
<p>We tested this by two Keycloak containers cross host.</p>
<p>And in this solution we need to set three below environment variables for containers.
<pre>
#IP address of this host, please make sure this IP can be accessed by the other Keycloak instances
JGROUPS_DISCOVERY_EXTERNAL_IP=172.21.48.39
#protocol
JGROUPS_DISCOVERY_PROTOCOL=TCPPING
#IP and Port of all host
JGROUPS_DISCOVERY_PROPERTIES=initial_hosts="172.21.48.4[7600],172.21.48.39[7600]"
</pre>
</p>
<p>The logs show that the two Keycloak instances discovered each other and clustered.</p>
<img src="${blogImages}/keycloak-cluster-setup/tcp-ping-log.png"/>

<h3>3. JDBC_PING</h3>
<p><a href="http://jgroups.org/manual/#_jdbc_ping">JDBC_PING</a> use TCP protocol with 7600 port which is similar as TCPPING, but the difference between them is, TCPPING requires you configure the IP and port of all instances,  for JDBC_PING you just need to configure the IP and port of current instance, this is because in JDBC_PING solution each instance insert its own information into database and the instances discover peers by the ping data read from database.</p>
<p>We tested this by two Keycloak containers cross host.</p>
<p>And in this solution we need to set two below environment variables for containers.
<pre>
#IP address of this host, please make sure this IP can be accessed by the other Keycloak instances
JGROUPS_DISCOVERY_EXTERNAL_IP=172.21.48.39
#protocol
JGROUPS_DISCOVERY_PROTOCOL=JDBC_PING
</pre>
</p>
<p>The ping data of all instances haven been saved in database after instance started.</p>
<img src="${blogImages}/keycloak-cluster-setup/jdbc-ping-data.png"/>
<p>The logs show that the two Keycloak instances discovered each other and clustered.</p>
<img src="${blogImages}/keycloak-cluster-setup/jdbc-ping-log.png"/>

<h3>One more thing</h3>
<p>The above solutions are available for most scenarios, but they are still not enough for some others, e.g.Kubernetes.</p>
<p>The typical deployment on Kubernetes is one Deployment/ReplicateSet/StatefulSet contains multi Keycloak Pods, the Pods are really dynamic as they can scale up and down or failover to another node, which requires the cluster to discover and remove these dynamic members.</p>
<p>On Kubernetes we can use <a href="https://github.com/jboss-dockerfiles/keycloak/blob/master/server/README.md#openshift-example-with-dnsdns_ping">DNS_PING</a> or <a href="http://jgroups.org/manual/#_kube_ping">KUBE_PING</a> which work quite well in  <a href="https://github.com/helm/charts/blob/master/stable/keycloak/templates/statefulset.yaml#L92">practice</a>. </p>
<p>Besides DNS_PING and KUBE_PING, JDBC_PING is another option for Kubernetes. </p>
<p>On Kubernetes multicast is available only for the containers in the same node and a pod has no static ip which can be used to configure TCPPING or JDBC_PING. But in the JDBC_PING.cli mentioned above we have handled this, if you don't set the JGROUPS_DISCOVERY_EXTERNAL_IP env, the pod ip will be used, that means on Kubernetes you can simply set JGROUPS_DISCOVERY_PROTOCOL=JDBC_PING then your keycloak cluster is ok.</p>

<h3>Discussion</h3>
<p>Suggestions and comments can be discussed via <a href="https://lists.jboss.org/mailman/listinfo/keycloak-user">Keycloak User Mail List</a> or <a href="https://github.com/fit2anything/keycloak-cluster-setup-and-configuration">this GitHub Repository</a>.</p>