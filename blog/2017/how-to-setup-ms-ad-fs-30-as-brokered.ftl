<#--
title = How to Setup MS AD FS 3.0 as Brokered Identity Provider in Keycloak
date = 2017-03-23
publish = true
author = Hynek Mlnařík
category = Active Directory
-->

<p><span>This document guides you through initial setup of Microsoft Active Directory Federation Services 3.0 as a brokered identity provider Keycloak.</span></p>
<h2>Prerequisites</h2>
<ul>
<li>Two server hosts:</li>
<ul>
<li>Microsoft Windows Server 2012 with Active Directory Federation Services (AD FS) installed. The AD domain will be named </span><span style="font-weight: 700">DOMAIN.NAME </span><span>in this post.</li>
<li>Keycloak server. This can be generally placed anywhere but here it is expected to be running on separate host</li>
</ul>
<li>DNS setup:</li>
<ul>
<li>The Windows host name will be </span><span style="font-weight: 700">fs.domain.name</span><span> in this post</li>
<li>The Keycloak host name will be </span><span style="font-weight: 700">kc.domain.name</span><span> in this post</li>
</ul>
</ul>
<h2>
<span style="font-size: 16pt; white-space: pre-wrap;">Setup Keycloak Server</span></h2>
<p><span>Keycloak server has configured for SSL/TLS transport - this is mandatory for AD FS to communicate with it. This comprises two steps:</span></p>
<ul>
<li>Setup keycloak for incoming HTTPS</span><span style="font-weight: 700"> </span><span>connections - steps are provided </span><a href="https://www.keycloak.org/docs/latest/server_installation/index.html#enabling-ssl-https-for-the-keycloak-server" style="text-decoration: none;"><span style="color: #1155cc; font-weight: 400; text-decoration: underline; vertical-align: baseline; white-space: pre-wrap;">in Server Installation guide</span></a><span>.</li>
<li>Export AD FS certificate into a Java truststore to enable outgoing HTTPS connections:</li>
<ul>
<li>In the AD FS management console, go to </span><span style="font-size: 11pt; font-style: italic">Service → Certificates</span><span> node in the tree and export the </span><span style="font-size: 11pt; font-style: italic">Service communications </span><span>certificate.</li>
<li>Import the certificate into a Java truststore (JKS format) using Java keytool utility.</li>
<li>Setup the truststore in Keycloak as described </span><a href="https://www.keycloak.org/docs/latest/server_installation/index.html#_truststore" style="text-decoration: none;"><span style="color: #1155cc; font-weight: 400; text-decoration: underline; vertical-align: baseline; white-space: pre-wrap;">in Server Installation guide</span></a><span>.</li>
</ul>
</ul>
<h2>
<span style="font-size: 16pt; white-space: pre-wrap;">Setup Identity Provider in Keycloak</span></h2>
<h3 style="margin-bottom: 4pt; margin-top: 16pt;">
<span style="color: #434343; font-size: 14pt; white-space: pre-wrap;">Setup Basic Properties of Brokered Identity Provider</span></h3>
<p><span>In the Identity Providers, create a new SAML v2.0 identity provider. In this post, the identity provider will be known under alias </span><span style="font-weight: 700">adfs-idp-alias</span><span>.</span></p>
<p><span>Now scroll to the bottom and enter the AD FS descriptor URL into </span><span style="font-size: 11pt; font-style: italic">Import from URL</span><span> field. For AD FS 3.0, this URL is </span><span style="font-weight: 700">https://fs.domain.name/FederationMetadata/2007-06/FederationMetadata.xml</span><span>. Once you click “Import”, check the settings. Usually, you would at least enable </span><span style="font-size: 11pt; font-style: italic">Validate signature</span><span> option. </span></p>
<p><span>If the authentication requests sent to the AD FS instance are expected to be signed, which is also usually the case, you have to enable </span><span style="font-size: 11pt; font-style: italic">Want AuthnRequests Signed</span><span> option. Importantly, then the </span><span style="font-size: 11pt; font-style: italic">SAML Signature Key Name</span><span> field that shows after enabling the </span><span style="font-size: 11pt; font-style: italic">Want AuthnRequests Signed</span><span> option has to be set to CERT_SUBJECT as AD FS expects the signing key name hint to be the subject of the signing certificate.</span></p>
<p><span>The AD FS will be set up in the next step to respond with name ID in Windows Domain Qualified Name format, hence set the </span><span style="font-size: 11pt; font-style: italic">NameID Policy Format</span><span> field accordingly.</span></p>
<b id="docs-internal-guid-d7a78233-f66d-5bde-d887-549caec7811b" style="font-weight: normal;"><br /></b>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img height="640" src="${blogImages}/adfs/0-adfs.png" width="617" /></span></div>
<h3 style="margin-bottom: 4pt; margin-top: 16pt;">
<span style="color: #434343; font-size: 14pt; white-space: pre-wrap;">Setup Mappers</span></h3>
<p><span>In the steps setting AD FS below, AD FS will be set up to send email and group information in SAML assertion. To transform these details from SAML document issued by AD FS to Keycloak user store, we’ll need to set up two corresponding mappers in the Mappers tab of Identity Provider:</span></p>
<ul>
<li>Mapper named </span><span style="font-size: 11pt; font-style: italic">Group: managers</span><span> will be of type </span><span style="font-size: 11pt; font-style: italic">SAML Attribute to Role</span><span>, and will map attribute named </span><span style="font-size: 11pt; font-style: italic">http://schemas.xmlsoap.org/claims/Group</span><span>, if that has attribute value </span><span style="font-size: 11pt; font-style: italic">managers,</span><span> to role </span><span style="font-size: 11pt; font-style: italic">manager</span><span>.</li>
</ul>
<p><span><span class="Apple-tab-span" style="white-space: pre;"> </span></span></p>
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><span class="Apple-tab-span" style="white-space: pre;"> </span></span><span><img height="266" src="${blogImages}/adfs/1-adfs.png" width="400" /></span></div>
<br />
<ul>
<li>Mapper named </span><span style="font-size: 11pt; font-style: italic">Attribute: email</span><span> will be of type </span><span style="font-size: 11pt; font-style: italic">Attribute Importer</span><span>, and will map attribute named </span><span style="font-size: 11pt; font-style: italic">http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress</span><span> into user attribute named </span><span style="font-size: 11pt; font-style: italic">email</span><span>.</li>
</ul>
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img height="200" src="${blogImages}/adfs/2-adfs.png" width="400" /></span></div>
<h3 style="margin-bottom: 4pt; margin-top: 16pt;">
<span style="color: #434343; font-size: 14pt; white-space: pre-wrap;">Obtain information for the AD FS configuration</span></h3>
<p><span>Now we determine SAML service provider descriptor URI that will be used in AD FS setup from the </span><span style="font-size: 11pt; font-style: italic">Redirect URI</span><span> field in the identity provider detail by adding “/descriptor” to the URI in this field. The URI will be similar to </span><span style="font-weight: 700">https://kc.domain.name:8443/auth/realms/master/broker/adfs-idp-alias/endpoint/descriptor</span><span>. You can check whether you got the URI right by entering the URI into the browser - you should receive a SAML service provider XML descriptor.</span></p>
<h2>
<span style="font-size: 16pt; white-space: pre-wrap;">Setup Relying Party Trust in AD FS</span></h2>
<h4 style="margin-bottom: 4pt; margin-top: 14pt;">
<span style="color: #666666; font-size: 12pt; white-space: pre-wrap;">Setup Relying Party</span></h4>
<p><span>In AD FS Management console, right-click Tr</span><span style="font-size: 11pt; font-style: italic">ust relationships → Relying Party Trusts</span><span> and select </span><span style="font-size: 11pt; font-style: italic">Add Relying Party Trust</span><span> from the menu:</span></p>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img src="${blogImages}/adfs/3-adfs.png" /></span></div>
<br />
<p><span>At the beginning of the wizard, enter the SAML descriptor URL obtained in the previous step into the </span><span style="font-size: 11pt; font-style: italic">Federation metadata address </span><span>field, and let AD FS import the settings. Proceed with the wizard, and adjust the settings where appropriate. Here we use only the default settings. Note that you will need to edit the claim rules so when asked to do so at the last page of the wizard, you can leave the checkbox checked on.</span></p>
<h4 style="margin-bottom: 4pt; margin-top: 14pt;">
<span style="color: #666666; font-size: 12pt; white-space: pre-wrap;">Setup Claim Mapping</span></h4>
<p><span>Now the SAML protocol would proceed correctly, AD FS would be able to correctly authenticate the users according to requests from Keycloak, but the requested name ID format is not yet recognized and SAML response would not contain any additional information like e-mail. It is hence necessary to map claims from AD user details into SAML document.</span></p>
<p><span>We will set up three rules: one for mapping user ID, second for mapping standard user attributes, and third for a user group. All start by clicking the </span><span style="font-size: 11pt; font-style: italic">Add Rule</span><span> button in the </span><span style="font-size: 11pt; font-style: italic">Edit Claim Rules for kc.domain.name</span><span> window:</span></p>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img height="400" src="${blogImages}/adfs/4-adfs.png" width="365" /></span></div>
<br />
<p><span>The first rule will map user ID in Windows Qualified Domain name to the SAML response. In the </span><span style="font-size: 11pt; font-style: italic">Add Transform Claim Rule</span><span> window, select </span><span style="font-size: 11pt; font-style: italic">Transform an incoming claim </span><span>rule type:</span></p>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img height="515" src="${blogImages}/adfs/5-adfs.png" width="640" /></span></div>
<br />
<p><span>The example above targets windows account name ID format. Other name ID formats are supported but out of scope of this post. See e.g. <a href="https://blogs.msdn.microsoft.com/card/2010/02/17/name-identifiers-in-saml-assertions/">this blog</a> on how to setup name IDs for persistent and transient formats.</span></p>
<br />
<p><span>The second rule will map user e-mail to the SAML response. In the </span><span style="font-size: 11pt; font-style: italic">Add Transform Claim Rule</span><span> window, select </span><span style="font-size: 11pt; font-style: italic">Send LDAP attributes as Claims </span><span>rule type. You can add other attributes as needed:</span></p>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img src="${blogImages}/adfs/6-adfs.png" /></span></div>
<br />
<p><span>The third rule would send a group name if the user is member of a named group. Start again in the </span><span style="font-size: 11pt; font-style: italic">Add Transform Claim Rule</span><span> window, and select </span><span style="font-size: 11pt; font-style: italic">Send Group Membership as a Claim </span><span>rule type. Then enter the requested values in the field:</span></p>
<br />
<div style="margin-bottom: 0pt; margin-top: 0pt; text-align: center;">
<span><img height="515" src="${blogImages}/adfs/7-adfs.png" width="640" /></span></div>
<br />
<p><span>This setup would send an attribute named </span><span style="font-size: 11pt; font-style: italic">Group </span><span>in the SAML assertion with value </span><span style="font-size: 11pt; font-style: italic">managers</span><span> if the authenticated user is member of the </span><span style="font-size: 11pt; font-style: italic">DOMAIN\Managers</span><span> group.</span></p>
<h2>
<span style="font-size: 16pt; white-space: pre-wrap;">Troubleshooting</span></h2>
<p><span>As a first-hand tool, you should check SAML messages sent back and forth between Keycloak and AD FS in your browser. The SAML decoders are available as browser extensions (e.g. SAML Tracer for Firefox, SAML Chrome Panel for Chrome). From the captured communication, you might see error status codes as well as the actual attribute names and values in SAML assertion necessary for setting up mappers. For example, if name ID format is not recognized, AD FS would return a SAML response containing </span><span style="font-size: 11pt; font-weight: 400"><i>urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy</i></span><span> status code.</span></p>
<br />
<p><span>As a second resort, check the logs. For AD FS, the logs are available in the </span><span style="font-size: 11pt; font-weight: 400"><i>Event viewer</i></span><span> under </span><span style="font-size: 11pt; font-style: italic">Applications and Services Logs → AD FS → Admin</span><span>. In Keycloak, you can enable tracing of the SAML processing by connecting to the running Keycloak instance via jboss-cli.sh and entering the following commands:</span></p>
<br />
<div>
<span style="color: black; font-family: &quot;courier new&quot;; font-size: 11pt; white-space: pre-wrap;"><span class="Apple-tab-span" style="white-space: pre;"> </span></span><span style="color: black; font-family: &quot;courier new&quot;; font-size: 11pt; white-space: pre-wrap;">/subsystem=logging/logger=org.keycloak.saml:add(level=DEBUG)</span></div>
<div>
<span style="color: black; font-family: &quot;courier new&quot;; font-size: 11pt; white-space: pre-wrap;"><span class="Apple-tab-span" style="white-space: pre;"> </span></span><span style="color: black; font-family: &quot;courier new&quot;; font-size: 11pt; white-space: pre-wrap;">/subsystem=logging/logger=org.keycloak.broker.saml:add(level=DEBUG)</span></div>
<br />
<p><span>Then you will be able to find the SAML messages and broker-related SAML processing messages in the Keycloak server log.</span></p>
<h3 style="margin-bottom: 4pt; margin-top: 16pt;">
<span style="color: #434343; font-size: 14pt; white-space: pre-wrap;">Common issues</span></h3>
<div>
<span style="font-weight: 700">Q:</span><span> I cannot log out! When I click logout in my app, it seems I’m logged out from Keycloak but when I return to the app, AD FS login form never displays and I’m redirected back authenticated as the same user as previously!</span></div>
<div>
<span style="font-weight: 700">A:</span><span> Don’t panic. This is not a Keycloak issue, rather AD FS settings of authentication policy. Try </span><a href="https://blogs.msdn.microsoft.com/josrod/2014/10/15/enabled-forms-based-authentication-in-adfs-3-0/" style="text-decoration: none;"><span style="color: #1155cc; font-weight: 400; text-decoration: underline; vertical-align: baseline; white-space: pre-wrap;">disabling Windows Authentication</span></a><span> before reporting an issue.</span><br />
<span style="font-size: 11pt; font-style: normal"><br /></span>
<span style="font-family: &quot;arial&quot;;"><span style="font-size: 14.6667px; white-space: pre-wrap;"><b>Q:</b> While using AD FS in Windows 2016, the following error appeared in Keycloak log after importing the descriptor from URL: R<i>ESTEASY002010: Failed to execute: javax.ws.rs.NotFoundException: RESTEASY003210: Could not find resource for full path: https://kc.domain.name/auth/realms/master/broker/adfs-idp-alias/endpoint/descriptor/FederationMetadata/2007-06/FederationMetadata.xml</i>. Does it cause any harm?</span></span><br />
<span style="font-family: &quot;arial&quot;;"><span style="font-size: 14.6667px; white-space: pre-wrap;"><b>A:</b> It is harmless. It seems that Windows 2016 version first checks for AD FS-like descriptor URL by adding <i>FederationMetadata/2007-06/FederationMetadata.xml</i> to the entered URL. Such resource does not exist in Keycloak, so it reports error. AD FS however seems to import using the entered URL when this happens. Please see also the <a href="http://lists.jboss.org/pipermail/keycloak-user/2017-March/010138.html">original email discussion</a> on this issue.&nbsp;</span></span></div>
<h2>
<span style="font-size: 16pt; white-space: pre-wrap;">Conclusion</span></h2>
<p><span>If you get stuck, do not hesitate to write a question to </span><a href="https://keycloak.discourse.group/"><b>Keycloak user forum</b></a><span> mailing list.</span></p>
<br />
<p><span>As there is always room for improvement, if you find any issue or have any suggestion on this text, feel free to leave a comment!</span></p>
<br />
