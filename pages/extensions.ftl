<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="extensions" title="Extensions">

<div class="jumbotron jumbotron-fluid kc-bg-triangles pt-5">
    <div class="container">
        <h1 class="text-white">Extensions</h1>

        <div class="row">
        <#list extensions as extension>
        <div class="col-sm-4">
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card=title">${extension.name}</h5>
                    <span class="card-text">${extension.description}</span>
                    <a href="${extension.website}" class="stretched-link link-dark"></a>
                </div>
            </div>
        </div>
        </#list>
        </div>
    </div>
</div>

</@tmpl.page>