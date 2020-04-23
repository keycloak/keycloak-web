<#assign title = "Security">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Reporting security vulnerabilities</h1>

        <p>
            When reporting a security vulnerability please do not disclose the details publicly. This includes our
            user mailing lists. Instead contact <a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a> or create a JIRA issue and mark it as security sensitive. The Keycloak team will acknowledge your e-mail, and you will receive a response indicating the next steps in handling your report.
        </p>

        <p>
            To report a security vulnerability:
        </p>

        <ul>
            <li>
                Go to <a href="https://issues.jboss.org/browse/KEYCLOAK" target="_blank">JIRA</a> and create a new issue
            </li>
            <li>
                Before saving the issue make sure the <b>This issue is security relevant</b> checkbox is checked. This
                makes the details in the issue only visible to the core Keycloak team and yourself.
            </li>
            <li>
                Please provide as much information about the issue as possible when contacting the list. This will contribute to a better response time.
            </li>
            <li>
                If you have a patch or patches to submit, please include them in the email using <a href="https://www.kernel.org/pub/software/scm/git/docs/git-format-patch.html">git format-patch</a>. But do not file a pull request on GitHub, unless you coordinated it with the team.
            </li>
        </ul>

        <h3>Resources</h3>
        <ul>
            <li><a href="https://issues.jboss.org/browse/KEYCLOAK" target="_blank">JIRA</a></li>
            <li><a href="mailto:keycloak-security@googlegroups.com">keycloak-security@googlegroups.com</a></li>
        </ul>
</div>

<#include "../templates/footer.ftl">
