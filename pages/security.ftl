<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="security" title="Security">

<div class="container mt-5 kc-article">
    <h1>Security Policy</h1>

    <p>The Keycloak team takes security very seriously, and aim to resolve issues as quickly as possible. Building secure software is a continuous process, and can always be improved. As such we welcome reports on potential security vulnerabilities, as well as suggestions around hardening the software and our process.</p>

    <h2>Reporting a suspected vulnerability</h2>

    <p>It is important that suspected vulnerabilities are disclosed in a responsible way, and are not publicly disclosed until after they have been analysed and a fix is available.</p>

    <p>To report a security vulnerability in the Keycloak codebase, send an email to <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>. Please test against the <b>latest version</b> of Keycloak and include the version affected in your report, provide detailed instructions on how to reproduce the issue with a <a href="https://stackoverflow.com/help/minimal-reproducible-example">minimal an reproducible example</a>, and include your contact information for acknowledgements. If you are reporting known CVEs related to third-party libraries used in Keycloak, please <a href="https://github.com/keycloak/keycloak/issues/new/choose">create a new GitHub issue</a>.</p>

    <p>If you would like to work with us on a fix for the security vulnerability, please include your GitHub username in the above email, and we will provide you access to a temporary private fork where we can collaborate on a fix without it being disclosed publicly.</p>

    <p>Do not open a public issue, send a pull request, or disclose any information about the suspected vulnerability publicly. If you discover any publicly disclosed security vulnerabilities, please notify us immediately through <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>.</p>

    <h2>Security Scanners</h2>

    <p>Reports from automated security scanners will <b>not</b> be accepted. These tools often report false positives, and can be disruptive to the project maintainers as it takes a long time to analyse these reports. If you believe you have found a security vulnerability using a security scanner, it is your responsiblity to provide a clear example of the vulnerability and how it could be exploited specifically for Keycloak as outlined above.</p>

    <h2>Supported Versions</h2>

    <p>Depending on the severity of a vulnerability the issue may be fixed in the current <code>major.minor</code> release of Keycloak, or for lower severity vulnerabilities or hardening in the following <code>major.minor</code> release. Refer to <a href="https://www.keycloak.org/downloads">https://www.keycloak.org/downloads</a> to find the latest release.</p>

    <p>If you are unable to regularly upgrade Keycloak we encourage you to consider <a href="https://access.redhat.com/products/red-hat-build-of-keycloak">Red Hat build of Keycloak</a>, which offers <a href="https://access.redhat.com/support/policy/updates/jboss_notes#p_sso">long term support</a> of specific versions of Keycloak.</p>
</div>

</@tmpl.page>
