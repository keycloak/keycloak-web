<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->

<@tmpl.page current="community" title="Community" summary="Find activities and resources to engage with the Keycloak community.">

<div class="container mt-4">

    <div class="mb-4">
        <h3>Questions and help</h3>
        <ul class="ms-2 mb-0">
            <li>Join <a href="https://cloud-native.slack.com/archives/C056HC17KK9">#keycloak</a>, or <a href="https://cloud-native.slack.com/archives/C056XU905S6">#keycloak-dev</a> on Slack for design discussions, or questions by creating an account at <a href="https://slack.cncf.io/">https://slack.cncf.io/</a></li>
            <li><a href="search.html">Search</a> for information in the documentation and mailing list</li>
            <li><a href="https://github.com/keycloak/keycloak/discussions">GitHub Discussions Forum</a> for discussions and asking questions</li>
            <li><a href="https://forum.keycloak.org/">Discourse Forum</a> where you can ask questions</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-user">Mailing list</a> where you can ask questions</li>
        </ul>
    </div>

    <div class="mb-4">
        <h3>Community meetings</h3>
        <ul class="ms-2 mb-0">
            <li>
                <b>OID4VCI - OAuth SIG Weekly meeting</b>
                <br class="d-sm-none"/>
                <a class="btn btn-primary btn-sm ms-sm-2 mt-2 mt-sm-0 mb-2 mb-sm-0 py-sm-0" href="https://zoom-lfx.platform.linuxfoundation.org/meeting/97933174558?password=6965d59c-daea-4f7e-b6de-24790eddc957">Join Zoom</a>
            </li>
            <ul>
                <li>Time: Wed 12:00 PM - 01:00 PM GMT</li>
                <li>For more details about the meeting, check out the <a href="https://github.com/keycloak/keycloak-oauth-sig">GitHub repository</a> and <a href="https://cloud-native.slack.com/archives/C05KR0TL4P8">Slack channel</a>.</li>
            </ul>
            <li class="mt-2">
                <b>OAuth SIG Monthly meeting</b>
                <br class="d-sm-none"/>
                <a class="btn btn-primary btn-sm ms-sm-2 mt-2 mt-sm-0 mb-2 mb-sm-0 py-sm-0" href="https://zoom-lfx.platform.linuxfoundation.org/meeting/98291605594?password=d91ff281-70d0-4b60-9081-4457ebba30d8">Join Zoom</a>
            </li>
            <ul>
                <li>Monthly on the first Monday, Time: 12:00 PM - 01:00 PM GMT</li>
                <li>For more details about the meeting, check out the <a href="https://github.com/keycloak/keycloak-oauth-sig">GitHub repository</a> and <a href="https://cloud-native.slack.com/archives/C05KR0TL4P8">Slack channel</a>.</li>
            </ul>
            <li class="mt-2"><b>Keycloak User Group Austria</b></li>
            <ul>
                <li>For upcoming meetings, check out the page on <a href="https://www.meetup.com/keycloak-user-group-austria">Meetup</a>.</li>
            </ul>
        </ul>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 py-3">
        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">⚡ Extensions</h4>
                    <span class="card-text">Community maintained extensions to extend the functionality of your Keycloak setup.</span>
                </div>
                <a href="${links.extensions}" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🌍 Translations</h4>
                    <span class="card-text">Translating Keycloak is a community effort. Find out how you can contribute translations.</span>
                </div>
                <a href="${links.translations}" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🏢 Case Studies</h4>
                    <span class="card-text">See how Keycloak is used by end user companies in real life scenarios.</span>
                </div>
                <a href="${links.casestudies}" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🛡️ Security vulnerabilities</h4>
                    <span class="card-text">Found a security vulnerability? Follow the instructions on how to properly report it.</span>
                </div>
                <a href="${links.getLink('security')}" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🐛 Report bugs</h4>
                    <span class="card-text">Check if it's still an issue in the latest release and hasn't been reported yet before opening a new issue.</span>
                </div>
                <a href="https://github.com/keycloak/keycloak/issues" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">💡 Feature requests</h4>
                    <span class="card-text">Have an idea for Keycloak? Open a feature request or contribute the feature yourself.</span>
                </div>
                <a href="https://github.com/keycloak/keycloak/issues" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🤝 Contributors</h4>
                    <span class="card-text">Want to contribute to Keycloak? Check out our contributors guide to get started.</span>
                </div>
                <a href="https://github.com/keycloak/keycloak/blob/main/CONTRIBUTING.md" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">📜 Code of Conduct</h4>
                    <span class="card-text">We are committed to providing a safe, welcoming, and constructive environment for everyone.</span>
                </div>
                <a href="https://github.com/keycloak/.github/blob/main/CODE_OF_CONDUCT.md" class="stretched-link"></a>
            </div>
        </div>

        <div class="col d-flex">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">🌙 Nightly release</h4>
                    <span class="card-text">For early feedback and extension developers, try the latest nightly build of Keycloak.</span>
                </div>
                <a href="${links.nightly}" class="stretched-link"></a>
            </div>
        </div>
    </div>

    <div class="mb-4">
        <h3>Resources</h3>
        <ul class="ms-2 mb-0">
            <li><a href="https://github.com/keycloak/keycloak">Source Code</a></li>
            <li><a href="${links.getLink('documentation')}">Documentation</a></li>
            <li><a href="https://github.com/keycloak/keycloak/issues">GitHub Issues</a></li>
            <li><a href="https://forum.keycloak.org/">Forum</a> - for questions and help</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-user">User Mailing List</a> - for questions and help</li>
            <li><a href="https://groups.google.com/forum/#!forum/keycloak-dev">Developer Mailing List</a> - for discussions around design and contributing to Keycloak</li>
        </ul>
    </div>

    <div class="mb-4">
        <h3>Thanks!</h3>
        <p class="ms-2 mb-2"><img src="resources/images/github.png" width="28px" alt="GitHub" class="me-2"></img>Thanks to <a href="https://github.com/keycloak/keycloak/graphs/contributors">everyone</a> that has contributed to the project.</p>
        <p class="ms-2 mb-0"><img src="resources/images/jprofiler.png" width="28px" alt="JProfiler" class="me-2"></img>Thanks to <a href="https://www.ej-technologies.com/">ej-technologies</a> for providing free <a href="https://www.ej-technologies.com/products/jprofiler/overview.html">JProfiler</a> licenses to core team members.</p>
    </div>

</div>

</@tmpl.page>
