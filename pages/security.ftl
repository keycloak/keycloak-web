<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="security" title="Security">

<div class="container mt-5 kc-article">
    <h1>Security Policy</h1>

    <p>The Keycloak team takes security very seriously, and aim to resolve issues as quickly as possible. Building secure software is a continuous process, and can always be improved. As such we welcome reports on potential security vulnerabilities, as well as suggestions around hardening the software and our process.</p>

    <h2>Reporting a suspected vulnerability</h2>

    <p>It is important that suspected vulnerabilities are disclosed in a responsible way, and are not publicly disclosed until after they have been analysed and a fix is available.</p>

    <p>To report a security vulnerability, please create a <a aria-label-position="top" aria-label="https://github.com/keycloak/keycloak/security/advisories/new." rel="noopener" class="external-link" href="https://github.com/keycloak-poc/keycloak/security/advisories/new." target="_blank">new GitHub advisory</a>, or if you don't have a GitHub account, you can email the Keycloak team at <a aria-label-position="top" aria-label="mailto:keycloak-security@googlegroups.com." rel="noopener" class="external-link" href="mailto:keycloak-security@googlegroups.com." target="_blank">keycloak-security@googlegroups.com.</a>&nbsp;Include steps to reproduce the vulnerability, the vulnerable versions, and any additional files necessary.</p>

    <p>When creating an advisory, you should have access to the temporary private fork, so we can collaborate on a fix without it being disclosed publicly.</p>

    <p>Do not open a public issue, send a pull request, or disclose any information about the suspected vulnerability publicly. If you discover any publicly disclosed security vulnerabilities, please notify us immediately through <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>.</p>

    <p>Public CVEs</p>

    <p>For publicly known CVEs from third-party dependencies, we use <a aria-label-position="top" aria-label="https://github.com/aquasecurity/trivy" rel="noopener" class="external-link" href="https://github.com/aquasecurity/trivy" target="_blank">Trivy</a> and <a aria-label-position="top" aria-label="https://snyk.io/" rel="noopener" class="external-link" href="https://snyk.io/" target="_blank">Snyk</a>. Trivy is a vulnerability scanning tool that checks container images, and Snyk keeps track of our project's dependencies.</p>

    <p>We review the reports coming from Trivy and Snyk on a daily basis, below you can find the list of issues:</p>

    <ul>
        <li><a href="https:/github.com/keycloak/keycloak/issues?q=is%3Aissue+sort%3Aupdated-desc+label%3Akind%2Fcve+is%3Aopen" target="_blank">Open Issues</a></li>
        <li><a href="https:/github.com/keycloak/keycloak/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc+label%3Akind%2Fcve" target="_blank">New fixes</a></li>
        <li><a href="https:/github.com/keycloak/keycloak/issues?q=is%3Aissue+sort%3Aupdated-desc+is%3Aclosed+label%3Akind%2Fcve" target="_blank">Closed issues</a></li>
    </ul>

    <p>Although we appreciate receiving reports from the community, it is not necessary to send scanner reports to the keycloak-security mailing list. Instead, please create <a href="https://github.com/keycloak/keycloak/issues/new?assignees=&amp;labels=kind%2Fbug%2Cstatus%2Ftriage&amp;template=bug.yml" target="_blank">a new GitHub issue</a> for public known CVEs on GitHub for public known CVEs.</p>

    <h2>Supported Versions</h2>

    <p>Depending on the severity of a vulnerability the issue may be fixed in the current <code>major.minor</code> release of Keycloak, or for lower severity vulnerabilities or hardening in the following <code>major.minor</code> release. Refer to <a href="https://www.keycloak.org/downloads">https://www.keycloak.org/downloads</a> to find the latest release.</p>

    <p>If you are unable to regularly upgrade Keycloak we encourage you to consider <a href="https://access.redhat.com/products/red-hat-single-sign-on">Red Hat Single Sign-On</a>, which offers <a href="https://access.redhat.com/support/policy/updates/jboss_notes#p_sso">long term support</a> of specific versions of Keycloak.</p>
</div>

</@tmpl.page>
