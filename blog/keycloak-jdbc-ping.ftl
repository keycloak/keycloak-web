<#--
title = Keycloak and JDBC Ping
date = 2019-08-12
publish = true
author = Sebastian Łaskaiwec
category = Cluster, JDBC_PING
-->

<p>
A few months back, we had a great article about clustering using <a href="http://jgroups.org/manual/#JDBC_PING">JDBC_PING</a> protocol. Since then, we introduced some improvements for the <a href="https://quay.io/repository/keycloak/keycloak?tab=tags">Keycloak container image</a> that can simplify the setup. So, before diving into this blog post, I highly encourage you to visit the <a href="https://www.keycloak.org/2019/05/keycloak-cluster-setup.html">Keycloak Cluster Setup</a> article.
</p>


<h2>What has changed in our Container Image?</h2>
<p>
Probably the most important change is configuring the JGroups discovery protocol by using variables (see the <a href="https://github.com/jboss-dockerfiles/keycloak/pull/151">Pull Request</a>). Once the change got in, we could configure the JGroups discovery by setting two properties:
<ul>
<li>JGROUPS_DISCOVERY_PROTOCOL</li>
<li>JGROUPS_DISCOVERY_PROPERTIES</li>
</ul>
</p>

<h2>Let's apply the changes, shall we...</h2>
<p>
The JDBC_PING-based setup works fine in all scenarios, where we connect all Keyclaok instances to the same database. Since JDBC_PING can be configured to obtain a database connection using JNDI binding, it can easily connect to the Keycloak database. All we need to do is to add two parameters to our docker image:
<ul>
<li>JGROUPS_DISCOVERY_PROTOCOL=JDBC_PING</li>
<li>JGROUPS_DISCOVERY_PROPERTIES=datasource_jndi_name=java:jboss/datasources/KeycloakDS</li>
</ul>
</p>

You may find an end-to-end scenario <a href="https://github.com/jboss-dockerfiles/keycloak/pull/204">here</a>.
</p>

<h2>Additional configuration</h2>
<p>
In some scenarios, you may need additional configuration. All additional settings might be added to the JGROUPS_DISCOVERY_PROPERTIES. Here are some hints and common problems, that you may find:
<table>
<tbody>
<tr>
<td>Problem description</td>
<td>Possible solution</td>
</tr>
<tr>
<td>The initialization SQL needs to be adjusted</td>
<td>In this case, you might want to look at <tt>initialize_sql</tt> JDBC_PING property</td>
</tr>
<tr>
<td>When Keycloak crashes, the database is not cleared</td>
<td>Turn <tt>remove_old_coords_on_view_change</tt> property on</td>
</tr>
<tr>
<td>When Keycloak crashes, the database is not cleared</td>
<td>Also, when a cluster is not too large, you may turn the <tt>remove_all_data_on_view_change</tt> property on</td>
</tr>
<tr>
<td>Sometimes, Keycloak doesn't write its data into the database</td>
<td>You may lower the <tt>info_writer_sleep_time</tt> and <tt>info_writer_max_writes_after_view</tt> property values</td>
</tr>
</tbody>
</table>
</p>

</br>

<p>
Haven fun and don't forget to let us know what you think about this blog post using the <a href="https://lists.jboss.org/mailman/listinfo/keycloak-user">User Mailing List</a>.
</br>
Sebastian Łaskawiec and the Keycloak Team
</p>
