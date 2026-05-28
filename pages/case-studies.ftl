<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="casestudies" type="org.keycloak.webbuilder.Casestudies" -->

<@tmpl.page current="case-studies" title="Case Studies" previewImage="casestudies.jpg"  summary="Case studies show how Keycloak is used by end user companies in real life scenarios.">

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <h4 class="mb-0 text-white w-100 text-center">Case Studies</h4>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4">
    <div class="container">
        <div class="rounded-4 mb-4" style="background-color: rgba(255, 255, 255, 0.7); padding: 1.5rem;">
            <p>
                Case studies show how Keycloak is used by end user companies in real life scenarios.
                Click on each tile to read more about each case study.
            </p>
            <p class="mb-0">
                To have your success story listed here, <a href="https://github.com/keycloak/keycloak-web/issues">open an issue on GitHub</a>.
            </p>
        </div>

        <style>
            .logo-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 120px;
            }
            .logo {
                max-height: 90%;
                max-width: 90%;
                display: block;
            }
            .line-clamp-5 {
                display: -webkit-box;
                -webkit-line-clamp: 5;
                line-clamp: 5;
                height: 5.1lh;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                height: 2.1lh;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
        </style>

        <div class="row">
            <#list casestudies.caseStudies as casestudy>
                <div class="col-md-6 col-xl-4 d-flex">
                    <div class="card">
                        <div class="logo-container rounded-top-4" style="background-color: ${casestudy.logoBackground}">
                            <img src="${casestudy.logoUrl}" alt="Company Logo" class="logo" style="${casestudy.logoStyle}">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title line-clamp-2">${casestudy.title}</h5>
                            <span class="card-text">
                                <div class="line-clamp-5">${casestudy.description}</div>
                            </span>
                        </div>
                        <div class="card-footer">
                            <a href="${casestudy.url}" class="stretched-link">Continue reading &rarr;</a>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</div>

</@tmpl.page>