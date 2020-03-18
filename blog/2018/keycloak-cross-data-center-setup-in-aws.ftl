<#--
title = Keycloak Cross Data Center Setup in AWS
date = 2018-01-15
publish = true
author = Hynek Mlnařík
category = Cross Datacenter/Replication/Infinispan
-->

<h2>
Sample Keycloak Cross Data Center Setup in AWS Environment</h2>
<div>
With Keycloak 3.3.0, the support for large-scale deployment across multiple data centers (also called cross site, X-site, cross data-center, cross-DC) has become available. The natural question arose about how this support can be utilized in cloud environment. This blog post follows up on previous blog post <a href="http://blog.keycloak.org/2017/09/cross-datacenter-support-in-keycloak.html" target="_blank">on setting up cross-DC locally</a>, and enhances it with an example of how to setup this type of deployment in Amazon Web Services (AWS).<br />
It is strongly recommended to use version 3.4.3.Final at minimum as there were several important fixes done around cross-DC support since the first cross-DC-capable version.</div>
<h3>
Architecture</h3>
<div>
The general architecture of a cross-DC deployment is described in detail <a href="http://www.keycloak.org/docs/latest/server_installation/index.html#crossdc-mode">in Keycloak documentation</a> and briefly shown in the following diagram. There are several data centers (<i>site1</i> and <i>site2</i> in the picture that can be found in full scale <a href="http://www.keycloak.org/docs/latest/server_installation/index.html#crossdc-mode" target="_blank">in the documentation</a>). The sites have a replicated database, set up ideally in multimaster synchronous replication mode. Each site has a cluster of Keycloak nodes and a cluster of Infinispan nodes. The clusters of Keycloak nodes are hidden behind a load balancer in private subnet; Infinispan nodes form a cluster within corresponding data center, and in addition&nbsp;utilize&nbsp;RELAY protocol to backup each other across data centers.</div>
<div>
<br /></div>
<div class="separator" style="clear: both; text-align: center;">
<a href="http://www.keycloak.org/docs/latest/server_installation/keycloak-images/cross-dc-architecture.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://www.keycloak.org/docs/latest/server_installation/keycloak-images/cross-dc-architecture.png" data-original-height="520" data-original-width="800" height="260" width="400" /></a></div>
<h3>
Example</h3>
<div>
This post is based on three CloudFormation templates that gradually build two data centers with Keycloak instances, each data center in a separate AWS availability zone sharing the same virtual private cloud (VPC). Note that the templates are intended <i>for trying/testing purposes only</i>, not for production. The templates are described below:</div>
<div>
<ol>
<li><i><a href="https://s3-eu-west-1.amazonaws.com/keycloak-aws/01-create-keycloak-vpc.yaml" target="_blank">VPC stack</a>.</i>&nbsp;This stack creates a new VPC with four subnets: two of them in one availability zone, another two in another availability zone. One of the subnet in each availability zone is private, intended for Keycloak instances; the other subnet in each availability zone is intended for load balancer and Infinispan (so that these can communicate over the internet).<br /><br />The only parameter in this stack is the number <i>B</i> in VPC IP address range 10.<i>B</i>.0.0/16.<br /><br />Click the button below to launch this stack:<br /><a href="https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=kc-vpc&amp;templateURL=https://s3-eu-west-1.amazonaws.com/keycloak-aws/01-create-keycloak-vpc.yaml" target="_blank"><img border="0" data-original-height="27" data-original-width="144" src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png" /></a></li>
<li><i><a href="https://s3-eu-west-1.amazonaws.com/keycloak-aws/02-create-keycloak-ami.yaml" target="_blank">Database and AMI stack</a>.</i>&nbsp;This stack creates an RDS Aurora MySQL-compatible database instance, builds Keycloak from source, creates S3 buckets necessary for dynamic node discovery via S3_PING protocol, and produces AMI image that contains both Keycloak and Infinispan preconfigured to form appropriate clusters. It relies on <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources-lambda.html" target="_blank">AWS Lambda-backed custom resources</a>, so in order to create them, it is required that this template creates a role for these Lambdas. To launch this template, it is hence required that the user grants the <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#using-iam-capabilities" target="_blank">CAPABILITY_IAM capability</a>.<br /><br />Both Keycloak and Infinispan server are prepared just the same way as <a href="https://github.com/keycloak/keycloak/blob/master/testsuite/integration-arquillian/HOW-TO-RUN.md#cross-dc-tests" target="_blank">for running cross-DC tests</a>, and then are placed into&nbsp;<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">/opt/tests</span> path&nbsp;and the relevant part of their configuration is updated to suit AWS deployment.<br /><br />This template has several parameters, most of them are self-describing:<br />-&nbsp;<i>VPC stack name:</i>&nbsp;Name of the stack created in the previous step<br />-&nbsp;<i>Instance type for building image</i><br />-&nbsp;<i>Database instance type:</i> Type of the database as available in RDS<br />-&nbsp;<i>Install diagnostic tools:</i> Flag signalling whether the diagnostic tools should be installed<br />-&nbsp;<i>URL to Maven repository for build: </i>To speed up build, instead of downloading each Maven artifact, URL with a .zip file containing the whole $HOME/.m2 directory can be provided that would be unpacked prior to the actual build and provide the artifacts, thus speeding the build up.<br />-&nbsp;<i>Keycloak Git repository</i> and&nbsp;<i>Git tag/branch/commit</i>: Git repository and tag from which the build should start.<br /><br />Click the button below to launch this stack:<br /><a href="https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=kc-ami&amp;templateURL=https://s3-eu-west-1.amazonaws.com/keycloak-aws/02-create-keycloak-ami.yaml" target="_blank"><img border="0" data-original-height="27" data-original-width="144" src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png" /></a></li>
<li><i><a href="https://s3-eu-west-1.amazonaws.com/keycloak-aws/03-create-infinispan-keycloak-clusters.yaml" target="_blank">Keycloak deployment stack</a></i>. This stack creates instantiates one Infinispan node in public subnet per data center, given number of Keycloak servers in private subnet joined in the cluster in each data center, and an AWS Application load balancer to spread the load between the actual Keycloak servers. If not restoring database from backup, it also creates an initial user <i>admin</i> with password <i>admin</i> in master realm, and also configures master realm to permit insecure http access to the admin console (remember, it is only a test instance, don't do this in production!).<br /><br />This template has several parameters, most of them are self-describing:<br />- <i>AMI stack name:</i> Name of the stack created in the previous step<br />-&nbsp;<i>Keycloak instances per data centre</i>: Number of Keycloak nodes per data center<br />-&nbsp;<i>Instance type for Keycloak servers</i><br />-&nbsp;<i>Instance type for Infinispan servers</i><br />-&nbsp;<i>SSH key name: </i>Name of EC2 ssh key used for instance initialization<br />-&nbsp;<i>Load balancer scheme:</i>&nbsp;This settings determines whether the load balancer would be assigned a public or private IP only. See <a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-internet-facing-load-balancers.html#elb-create-internet-facing-load-balancer" target="_blank">AWS documentation</a> for further information.<br />-&nbsp;<i>Database backup URL:</i> In case you have a dump of&nbsp;Keycloak&nbsp;MySQL/MariaDB database, you can initialize the database with it by providing URL to that dump. The dump might be optionally gzipped, .gz suffix of that dump is then mandatory.<br /><br />Click the button below to launch this stack:<br /><a href="https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=kc&amp;templateURL=https://s3-eu-west-1.amazonaws.com/keycloak-aws/03-create-infinispan-keycloak-clusters.yaml" target="_blank"><img border="0" data-original-height="27" data-original-width="144" src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png" /></a></li>
</ol>
<div>
Once you launch the last stack, Keycloak will be available at the load balancer address that will be shown in <i>Outputs</i>&nbsp;tab of the third stack under&nbsp;<i>LoadBalancerUrl</i> key.</div>
</div>
<div>
<br /></div>
<h3>
Connecting to nodes</h3>
<div>
Since Infinispan nodes are assigned public IPs and the security group is set to permit SSH traffic, you can use standard way to access Infinispan nodes.</div>
<div>
<br /></div>
<div>
Accessing Keycloak nodes is only a bit more complicated since these are spawned in private subnets and can only be accessed via Infinispan nodes. You can either copy the private key to the intermediate Infinispan node and use it from there, or (easier) use SSH agent forwarding as follows:</div>
<div>
<ol>
<li>On your <i>local</i> host, add your AWS ssh key to agent:<br /><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">ssh-add /path/to/my/aws_ssh_key</span></li>
<li>Now ssh to the Infinispan host with ssh adding the ForwardAgent option:<br /><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">ssh -oForwardAgent=yes \</span><div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">&nbsp; ec2-user@$<i>{InfinispanServerDcX.PublicDnsName}</i></span></div>
</li>
<li>From the Infinispan host, you can now ssh to the Keycloak node:<br /><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">ssh ec2-user@$<i>{KeycloakServerDcX.PrivateDnsName}</i></span></li>
</ol>
</div>
<div>
<br /></div>
<div>
</div>
<h3>
Connecting to Infinispan JConsole</h3>
<div>
As you would find out from the <a href="http://www.keycloak.org/docs/latest/server_installation/index.html#crossdc-mode" target="_blank">cross-DC guide</a>, many of the DC-wide operations require running JConsole and invoking operations on Infinispan JMX MBeans. For example, to take a DC offline, one has to first disable backups from the other DCs into the DC about to be shut down, and that is performed by invoking <span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">takeSiteOffline</span> operation on CacheManager's <span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">GlobalXSiteAdminOperations</span> MBean.</div>
<div>
<br /></div>
<div>
To connect, it is easiest to have a tunnel created to the Infinispan node via SSH command. To simplify the situation a bit, the ssh command for connecting to Infinispan server and creating the tunnel is shown in the&nbsp;<i>Outputs</i>&nbsp;tab of the third stack under&nbsp;<i>SshToInfinispanDcX</i> key, and it takes the following form:</div>
<div>
<br /></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">ssh -L 19990:127.0.0.1:9990 \</span></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">&nbsp;-oStrictHostKeyChecking=no \</span></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">&nbsp;-oUserKnownHostsFile=/dev/null \</span></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">&nbsp;-oForwardAgent=yes \</span></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">&nbsp; ec2-user@$<i>{InfinispanServerDcX.PublicDnsName}</i></span></div>
<div>
<br /></div>
<div>
In the command above, the host key checking is effectively disabled as this is only a test run, do not do this in production!<br />
Now it is necessary to add an Infinispan management user so that it is possible to fill in JConsole credentials:</div>
<div>
<br /></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">/opt/tests/cache-server-infinispan/bin/add-user.sh -u admin -p pwd</span></div>
<div>
<br /></div>
<div>
<div>
The last thing is to run actual JConsole. Since JConsole does not have support for the service:jmx:remote+http protocol used by both Infinispan and Keycloak, it is necessary to modify JConsole classpath. Fortunately, this work has been already done in WildFly so we can use a script already prepared there. On your&nbsp;<i>local</i>&nbsp;host, extract either WildFly 10+ or Infinispan to path&nbsp;<i>WF_ROOT</i>,&nbsp;and run the following command:</div>
<br /></div>
<div>
<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;"><i>WF_ROOT</i>/bin/jconsole.sh</span></div>
<div>
<br /></div>
<div>
In the New Connection window, specify <i>Remote Process</i> properties as follows (note that we're using port 19990 on localhost forwarded securely by ssh to actual management port above, this requires the ssh command above to be running for the whole time JConsole is used):</div>
<div>
<ul>
<li><i>Remote Process:</i>&nbsp;service:jmx:remote+http://localhost:19990</li>
<li><i>Username: </i>admin</li>
<li><i>Password:</i> pwd</li>
</ul>
<div class="separator" style="clear: both; text-align: center;">
</div>
<div class="separator" style="clear: both; text-align: center;">
<a href="https://4.bp.blogspot.com/-MRbv-y5tI3A/WlynVwPhuAI/AAAAAAAABBA/IWkGvjbZsdgBqcj306W697Nf-POdG2WIQCLcBGAs/s1600/jconsole-connect.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" data-original-height="389" data-original-width="446" height="279" src="https://4.bp.blogspot.com/-MRbv-y5tI3A/WlynVwPhuAI/AAAAAAAABBA/IWkGvjbZsdgBqcj306W697Nf-POdG2WIQCLcBGAs/s320/jconsole-connect.png" width="320" /></a></div>
<div class="separator" style="clear: both; text-align: center;">
<br /></div>
<div>
<br /></div>
<div>
<br /></div>
<div>
Now you can connect to the running instance, navigate to any bean you need and perform operations as needed. The backup site names are configured by the <i>AMI stack</i>&nbsp;to values&nbsp;<i>dc-1 </i>and <i>dc-2</i>.<br />
<br /></div>
</div>
<div class="separator" style="clear: both; text-align: center;">
<a href="https://2.bp.blogspot.com/-yfYaHRip9Hc/WliFAwcG5KI/AAAAAAAABAs/JoTEsu3MPhgPPWMIiHtAqixlTcVlMJb2wCLcBGAs/s1600/jconsole-call.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" data-original-height="623" data-original-width="795" height="250" src="https://2.bp.blogspot.com/-yfYaHRip9Hc/WliFAwcG5KI/AAAAAAAABAs/JoTEsu3MPhgPPWMIiHtAqixlTcVlMJb2wCLcBGAs/s320/jconsole-call.png" width="320" /></a></div>
<div>
<br /></div>
<div>
<br />
<div style="-webkit-text-stroke-width: 0px; color: black; font-family: &quot;Times New Roman&quot;; font-size: medium; font-style: normal; font-variant-caps: normal; font-variant-ligatures: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-decoration-color: initial; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;">
</div>
<br />
<div style="-webkit-text-stroke-width: 0px; color: black; font-family: &quot;Times New Roman&quot;; font-size: medium; font-style: normal; font-variant-caps: normal; font-variant-ligatures: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-decoration-color: initial; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;">
<div>
<div style="margin: 0px;">
For further details, please inspect the configuration files in&nbsp;<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">/opt/tests/auth-server-wildfly/standalone/</span><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">configuration/</span><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">standalone-ha-<i>DC</i>.xml</span>&nbsp;and&nbsp;<span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">/opt/tests/cache-server-infinispan/standalone/configuration/clustered-</span><i style="font-family: &quot;Courier New&quot;, Courier, monospace;">DC</i><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">.xml</span>.</div>
<div style="margin: 0px;">
<br /></div>
</div>
</div>
</div>
<h3>
Disclaimer</h3>
<div>
This blog has been written at the time Keycloak 3.4.3.Final has been released. There may be incompatible changes in the future but you should still be able to run the templates with this version.</div>
<div>
<br /></div>
<h3>
Troubleshooting AWS specifics</h3>
<div>
<ul>
<li>Node discovery in both Keycloak and Infinispan cluster in AWS is handled by S3_PING protocol. This protocol however can operate only in regions that support Version 2 signatures due to <a href="https://issues.jboss.org/browse/JGRP-1914">this JGroups bug</a>. See <a href="https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region">Amazon documentation on S3 endpoints</a> for regions that support Version 2 signatures. Note that it might be possible to use new&nbsp;<a href="https://github.com/jgroups-extras/native-s3-ping">NATIVE_S3_PING</a> protocol but this one has not yet been incorporated into Keycloak due to <a href="https://issues.jboss.org/browse/WFLY-8770">this WildFly issue</a>. As a workaround, you might be able to use other discovery protocol, e.g. JDBC_PING.</li>
<li>The recommended database products for cross-DC deployments are only those&nbsp;<a href="http://www.keycloak.org/docs/latest/server_installation/index.html#database">listed in the documentation</a>&nbsp;(currently Oracle Database 12c RAC and Galera cluster for MariaDB). It is possible to use ones available from <a href="https://aws.amazon.com/rds/">Amazon RDS service</a>. The templates from this blog are only ready for MySQL/MariaDB databases.</li>
<li>It is possible to use <a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html">Amazon ALB</a> for load balancing when the&nbsp;<a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html">related target group</a>&nbsp;is set to support <i>Load balancer stickiness</i>. ALB uses proprietary load balancer cookie and ignores routes set in Keycloak cookies, hence adding the route to cookie <a href="http://www.keycloak.org/docs/latest/server_installation/index.html#disable-adding-the-route">should be disabled in Keycloak configuration</a>.</li>
</ul>
</div>
<div>
<br /></div>
