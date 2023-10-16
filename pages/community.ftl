<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="community" title="Community">

<div class="container">
    <div class="row mt-5">
        <h2>Questions and help</h2>

        <ul class="ms-4 mt-2">
            <li>Join <a href="https://cloud-native.slack.com/archives/C056HC17KK9">#keycloak</a>, or <a href="https://cloud-native.slack.com/archives/C056XU905S6">#keycloak-dev</a> on Slack for design discussions, or questions by creating an account at <a href="https://slack.cncf.io/">https://slack.cncf.io/</a></li>
            <li><a href="search.html">Search</a> for information in the documentation and mailing list</li>
            <li><a href="https://github.com/keycloak/keycloak/discussions">GitHub Discussions Forum</a> for discussions and asking questions</li>
            <li><a href="https://keycloak.discourse.group/">Discourse Forum</a> where you can ask questions</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-user">Mailing list</a> where you can ask questions</li>
        </ul>
    </div>

    <div class="row mt-3">
        <h2>Extensions</h2>
        <p>You can find a number of community maintained extensions to Keycloak <a href="extensions.html">here</a>
    </div>

    <div class="row mt-3">
        <h2>Reporting security vulnerabilities</h2>
        <p>
            If you've found a security vulnerability, please look at the <a href="security.html">instructions on how to properly report it</a>.
        </p>
    </div>

    <div class="row mt-3">
        <h2>Reporting bugs</h2>
        <p>
            Before reporting a bug or feature request please:
        </p>
        <ul class="ms-4">
            <li>Check if it is still an issue in the <a href="downloads.html">latest release</a></li>
            <li>Check if it has already been reported in the <a href="https://github.com/keycloak/keycloak/issues">GitHub Issues</a></li>
        </ul>
        <p>
            If it hasn't already been fixed or reported create an issue in <a href="https://github.com/keycloak/keycloak/issues">GitHub Issues</a>.
        </p>
    </div>

    <div class="row mt-3">
        <h2>Requesting features and enhancements</h2>
        <p>
            If you are interested in contributing the feature take a look at the Contributors section.
        </p>
        <p>
            Otherwise, open a feature request in <a href="https://github.com/keycloak/keycloak/issues">GitHub Issues</a>.
        </p>
    </div>

    <div class="row mt-3">
        <h2>Contributors</h2>
        <p>
            If you'd like to contribute to the Keycloak project, please look at our <a href="https://github.com/keycloak/keycloak/blob/main/CONTRIBUTING.md">contributors guide</a>
            for the details.
        </p>
    </div>

    <div class="row mt-3">
        <h2>Resources</h2>
        <ul class="ms-4">
            <li><a href="https://github.com/keycloak/keycloak">Source Code</a></li>
            <li><a href="documentation.html">Documentation</a></li>
            <li><a href="https://github.com/keycloak/keycloak/issues">GitHub Issues</a></li>
            <li><a href="https://keycloak.discourse.group/">Forum</a> - for questions and help</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-user">User Mailing List</a> - for questions and help</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-dev">Developer Mailing List</a> - for discussions around design and contributing to Keycloak</li>
        </ul>
    </div>

    <div class="row mt-3">
        <h2>Thanks</h2>
        <p>
            <img src="resources/images/github.png" width="32px"></img>
            <span>
                Thanks to <a href="https://github.com/keycloak/keycloak/graphs/contributors">everyone</a> that has
            contributed to the project.</span>
        </p>
        <p>
            <img src="resources/images/jprofiler.png" width="32px"></img>
            <span>
                Thanks to <a href="https://www.ej-technologies.com/">ej-technologies</a> for providing free
                <a href="https://www.ej-technologies.com/products/jprofiler/overview.html">JProfiler</a> licenses to
                core team members.
            </span>
        </p>
    </div>

</div>

</@tmpl.page>
