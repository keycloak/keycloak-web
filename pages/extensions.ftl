<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="extensions" title="Extensions">

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles pt-4">
    <div class="container">
        <h1 class="text-white">Extensions</h1>
        <#list extensions.getLivenessCategories() as c>
            <#if c.name() == "LESS_ACTIVE">
                <h2>Less active</h2>
                <h5 class="text-black-50">(Not active for more than 1 year)</h5>
            </#if>

            <div class="row">
                <#list extensions.getByLivenessCategory(c) as extension>
                    <div class="col-sm-4">
                        <div class="card mb-4 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">${extension.name}</h5>
                                <span class="card-text">${extension.description}</span>
                                <a href="${extension.website}" class="stretched-link link-dark"></a>
                            </div>

                            <#if extension.stars??>
                                <div class="card-footer text-muted">
                                    <div class="d-flex align-items-center">
                                        <img src="resources/images/github.png" width="16px" alt="GitHub logo"
                                             class="me-2"/>
                                        <span>${extension.stars} stars</span>
                                    </div>
                                </div>
                            </#if>
                        </div>
                    </div>
                </#list>
            </div>
        </#list>
    </div>
</div>

</@tmpl.page>