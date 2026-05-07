<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="casestudies" type="org.keycloak.webbuilder.Casestudies" -->

<@tmpl.page current="case-studies" title="Case Studies" previewImage="casestudies.jpg"  summary="Case studies show how Keycloak is used by end user companies in real life scenarios.">

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4">
    <div class="container">
        <h1 class="text-white">Case Studies</h1>

        <p class="text-white">
            Case studies show how Keycloak is used by end user companies in real life scenarios.
            Click on each tile to read more about each case study.
        </p>

        <p class="text-white">
            To have your success story listed here, <a href="https://github.com/keycloak/keycloak-web/issues">open an issue on GitHub</a>.
        </p>

        <style>
            .logo-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 120px;
                margin: 1rem -1rem -1rem;
                border-radius: 0 0 0.25rem 0.25rem;
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
                <div class="col-md-6 col-xl-4">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title line-clamp-2">${casestudy.title}</h5>
                            <span class="card-text">
                                <div class="line-clamp-5">${casestudy.description}</div>
                            <a href="${casestudy.url}" class="stretched-link">Continue reading...</a></span>
                            <div class="logo-container" style="background-color: ${casestudy.logoBackground}">
                                <img src="${casestudy.logoUrl}" alt="Company Logo" class="logo" style="${casestudy.logoStyle}">
                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</div>

</@tmpl.page>