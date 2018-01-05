<#assign title = "Community">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Community</h1>

        <h2>Users</h2>

        <h3>Help</h3>

        <p>
            For questions and if you're running into trouble, first <a href="search.html">search</a> our documentation
            and forums. If you can't find an answer there join our
            <a href="https://lists.jboss.org/mailman/listinfo/keycloak-user" target="_blank">user mailing list</a>
            and send us an email. We'll typically answer within a few days (excluding weekends of course).
        </p>

        <h3>Reporting security vulnerabilities</h3>

        <p>
            If you've found a security vulnerability, please look at the <a href="security.html">instructions on how to properly report it</a>.
        </p>


        <h3>Reporting bugs and feature requests</h3>

        <p>
            Before reporting a bug or feature request please:
        </p>

        <ul>
            <li>Check if it's already resolved in the <a href="downloads.html">latest release</a></li>
            <li>Check if it's already reported in <a href="https://issues.jboss.org/browse/KEYCLOAK" target="_blank">JIRA</a></li>
            <li><a href="search.html">Search</a> user forums</li>
            <li>If you're unsure if it's a bug ask on the <a href="https://lists.jboss.org/mailman/listinfo/keycloak-user" target="_blank">user mailing list</a></li>
            <li>For feature request you can discuss it on the <a href="https://lists.jboss.org/mailman/listinfo/keycloak-user" target="_blank">user mailing list</a></li>
        </ul>

        <p>
            Once you've confirmed it's not already fixed or reported please create an issue in our <a href="https://issues.jboss.org/browse/KEYCLOAK" target="_blank">JIRA</a>.
        </p>

        <h3>Resources</h3>

        <ul>
            <li><a href="https://lists.jboss.org/mailman/listinfo/keycloak-user" target="_blank">User Mailing List</a></li>
            <li><a href="https://issues.jboss.org/browse/KEYCLOAK" target="_blank">JIRA</a></li>
            <li><a href="documentation.html" target="_blank">Documentation</a></li>
            <li><a href="search.html" target="_blank">Search documentation and forums</a></li>
        </ul>

        <h2>Contributors</h2>

        <p>
            If you'd like to contribute to the Keycloak project, please join our
            <a href="https://lists.jboss.org/mailman/listinfo/keycloak-dev" target="_blank">developer mailing list</a>. This list is used to
            discuss new features and improvements to Keycloak.
        </p>

        <p>
            The first step in contributing is usually sending an email to the
            <a href="https://lists.jboss.org/mailman/listinfo/keycloak-dev" target="_blank">developer mailing list</a> to let
            others know what you're planning. For a simple bug fix this is obviously not necessary, but if you plan to add
            a new feature discussing it on the mailing list first may save you a lot of time.
        </p>

        <p>
            To build Keycloak from source first fork our <a href="https://github.com/keycloak/keycloak">Github repository</a>. Then
            follow the steps in the <a href="https://github.com/keycloak/keycloak/blob/master/README.md">README</a> file.
        </p>

        <h3>Resources</h3>

        <ul>
            <li><a href="https://lists.jboss.org/mailman/listinfo/keycloak-dev" target="_blank">Developer Mailing List</a></li>
            <li><a href="https://github.com/keycloak/keycloak" target="_blank">Source code</a></li>
        </ul>

        <h2>Thanks</h2>

        <div style="float: left; width: 300px; padding: 10px 10px 10px 0;">
            <img style="float: left; margin-right: 15px;" src="resources/images/github.png"></img>
            <span style="float: left; width: 200px;">
                Thanks to <a href="https://github.com/keycloak/keycloak/graphs/contributors">everyone</a> that has
            contributed to the project.</span>
        </div>

        <div style="float: left; width: 300px; padding: 10px 10px 10px 0;">
            <img style="float: left; margin-right: 15px;" src="resources/images/jprofiler.png"></img>
            <span style="float: left; width:200px;">
                Thanks to <a href="https://www.ej-technologies.com/">ej-technologies</a> for providing free
                <a href="https://www.ej-technologies.com/products/jprofiler/overview.html">JProfiler</a> licenses to
                core team members.
            </span>
        </div>

    </div>
</div>

<#include "../templates/footer.ftl">
