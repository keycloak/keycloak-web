<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="extensions" title="Extensions" previewImage="extensions.jpg" summary="Use community maintained extensions to extend the functionality of your Keycloak setup.">

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <h4 class="mb-0 text-white w-100 text-center">Extensions</h4>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4">
    <div class="container">
        <div class="rounded-4 mb-4" style="background-color: rgba(255, 255, 255, 0.7); padding: 1.5rem;">
            <p>
                See below for a list of community maintained extensions for Keycloak.
                Note that those extensions are not vetted by the Keycloak team, and are maintained independent third parties.
                Only install extensions from parties that your trust, as these extensions will get access to sensitive data managed in Keycloak.
            </p>
            <p class="mb-0">
               To add an extension, <a href="https://github.com/keycloak/keycloak-web/issues">open an issue on GitHub</a>.
            </p>
        </div>
        <#list extensions.getLivenessCategories() as c>
            <#if c.name() == "LESS_ACTIVE">
                <h2>Less active</h2>
                <h5 class="text-black-50">(Not active for more than 1 year)</h5>
            </#if>

            <div class="row">
                <#list extensions.getByLivenessCategory(c) as extension>
                    <div class="col-sm-4 d-flex">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">${extension.name}</h5>
                                <span class="card-text">${extension.description}</span>
                            </div>
                            <#if extension.stars??>
                            <div class="card-footer">
                                <div class="d-flex align-items-center">
                                    <img src="resources/images/github.png" width="16px" alt="GitHub logo"
                                         class="me-2"/>
                                    <span data-nosnippet class="text-body-secondary">${extension.stars} stars</span>
                                </div>
                            </div>
                            </#if>
                            <a href="${extension.website}" class="stretched-link"></a>
                        </div>
                    </div>
                </#list>
            </div>
        </#list>
    </div>
</div>

</@tmpl.page>