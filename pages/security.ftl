<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="security" title="Security Policy" summary="Learn how to report suspected vulnerabilities or other security related information to the Keycloak team.">

<div class="container mt-5 kc-article">
    <h1>Security Policy</h1>
    <p><em>This policy is based on the <a href="https://www.cisa.gov/vulnerability-disclosure-policy-template">CISA vulnerability disclosure policy template</a></em></p>

    <h2>Introduction</h2>
    <p>The Keycloak team believes that everyone, everywhere, is entitled to the access and quality information needed to mitigate security and privacy risks. We strive to protect communities of users, contributors, and partners from digital security threats. We believe an <a href="https://www.redhat.com/en/blog/red-hats-open-approach-vulnerability-management">open approach to vulnerability management</a> is the best way to achieve this.</p>
    <p>This policy supports our open approach and is intended to give security researchers clear guidelines for submitting and coordinating discovered vulnerabilities with us. In complying with this policy, you authorize CNCF to work with you to understand and resolve the issue quickly. For more details about our processes, please read the <a href="security-charter.html">security charter</a>.</p>

    <h2>Guidelines</h2>
    <ul>
        <li>Research shared with any Keycloak representatives/individual will be reported to and managed by the Keycloak Security Response Team in order to be officially protected and coordinated.</li>
        <li>Access and visibility to research and all CVE related data will follow the principle of least privilege by all vendors involved.</li>
        <li>Establish and set a reasonable amount of time to resolve the issue before a vulnerability is disclosed publicly; agree and coordinate on public disclosure dates when possible.</li>
        <li>Public disclosure should be prioritized on the need to keep company, government, and individual data confidential and the general public safe.</li>
        <li>All vendors will honor disclosure/embargo requests in good faith as long as all guidelines are met.</li>
        <li>NDA signatures are not required.</li>
        <li>Vendors involved in coordinated disclosure will remain actively involved.</li>
    </ul>
    <p>Violation of these guidelines may result in the individual, or vendor, being added to a denied coordination list.</p>

    <h2>Scope</h2>
    <p>This policy applies to all Keycloak components and projects. Research disclosed to the project will be limited to Response Team members; however, we will assist in coordinating the disclosure of research with upstream open-source communities as needed and requested.</p>

    <h2>Reporting a Suspected Vulnerability</h2>
    <p>Suspected vulnerabilities should be disclosed responsibly and not made public until after analysis and a fix are available. We will acknowledge your report within 7 business days and work with you to confirm the vulnerability's existence and impact. Our goal is to maintain open dialogue during the assessment and remediation process.</p>

    <h3>Supported Versions</h3>
    <p>Depending on the severity of a vulnerability the issue may be fixed in the current <code>major.minor</code> release of Keycloak, or for lower severity vulnerabilities or hardening in the following <code>major.minor</code> release. Refer to <a href="https://www.keycloak.org/downloads">https://www.keycloak.org/downloads</a> to find the latest release.</p>
    <p>If you are unable to regularly upgrade Keycloak, we encourage you to consider <a href="https://access.redhat.com/products/red-hat-build-of-keycloak/">Red Hat build of Keycloak</a>, which offers <a href="https://access.redhat.com/support/policy/updates/red_hat_build_of_keycloak_notes">long term support</a> of specific versions of Keycloak.</p>

    <h3>Experimental Features</h3>
    <p>While we welcome bug reports against features that are not released yet, the security team usually does not issue CVEs for experimental features. The preview state marks that the feature is mature enough to start normal security handling.</p>
    <p>Instead, those issues will be managed as regular bugs publicly. If in doubt, report your finding via email to the security team first to clarify if it is related to an experimental feature. </p>

    <h3>Coordinated Vulnerability Disclosure</h3>
    <p>If you are reporting known CVEs related to third-party libraries used in Keycloak, <a href="https://github.com/keycloak/keycloak/issues/new/choose">create a new GitHub issue</a>.
    <p>If you discover any publicly disclosed security vulnerabilities, notify us through <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>.
    <p>If you are a <b>security researcher</b> and want to report a security vulnerability in the Keycloak codebase, follow these steps:
    <ol>
        <li>Test against the <a href="${links.getLink('downloads')}">latest released version</a> of Keycloak and include the affected version in your report.</li>
        <li>Provide detailed instructions on how to reproduce the issue with a <a href="https://stackoverflow.com/help/minimal-reproducible-example">minimal and reproducible example.</a></li>
        <li>Show clear evidence of exploitation like log output or screenshots. We will reject reports based on static scanners without a proof-of-concept.</li>
        <li>Include your contact information for acknowledgements. See "Attribution Policy" below for details.</li>
        <li>Submit each finding individually to allow a separate discussion thread with our triage team.</li>
        <li>Pick a descriptive subject for the mail matching the reported finding.</li>
        <li>Email your report to <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>.</li>
    </ol>
    <p>If you are a <b>user of Keycloak</b> and want to report a security concern, follow these steps:
    <ol>
        <li>Identify the Keycloak version affected. Ideally, verify with the <a href="${links.getLink('downloads')}">latest released version</a> of Keycloak.</li>
        <li>If available, provide detailed instructions on how to reproduce the issue with a <a href="https://stackoverflow.com/help/minimal-reproducible-example">minimal and reproducible example.</a></li>
        <li>If available, provide log files or screenshots.</li>
        <li>Include your contact information for acknowledgements. See "Attribution Policy" below for details.</li>
        <li>Submit each finding individually to allow a separate discussion thread with our triage team.</li>
        <li>Pick a descriptive subject for the mail matching the reported finding.</li>
        <li>Email your report to <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a>.</li>
    </ol>

    <h3>Attribution Policy</h3>
    <p>We will credit reporters who informed us in private about security vulnerabilities in security advisories.</p>
    <p>The attribution can contain the name, alias, company and group affiliation of the reporter. For GitHub issues, it can also include the GitHub username. We will not include email addresses or links.</p>

    <h3>Bug Bounty</h3>
    <p>There is currently no active bug bounty.</p>
    <!--
    <p>We are currently offering a bug bounty program. It is both time- and budget restricted, and can change at any time.</p>
    <p>Security researchers who wish to participate in our dedicated vulnerability reward program should refer to <a href="https://yeswehack.com/programs/keycloak-bug-bounty-program">the Bug Bounty Program's platform</a> for submissions and details.</p>
    -->

    <h2>Security Scanners</h2>
    <p>Reports from automated security scanners will <strong>not</strong> be accepted. These tools often report false positives, and can be disruptive to the project maintainers as it takes a long time to analyze these reports. If you believe you have found a security vulnerability using a security scanner, it is your responsibility to provide a clear example of the vulnerability and how it could be exploited specifically for Keycloak as outlined above.</p>
</div>

</@tmpl.page>
