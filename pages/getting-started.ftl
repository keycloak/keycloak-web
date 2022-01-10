<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="get-started" title="Getting started">

<div class="jumbotron jumbotron-fluid kc-bg-triangles py-5">
    <#list guides.categories as c>
    <div class="container">
        <h1 class="text-white">${c.label}</h1>

        <div class="row">
            <#list guides.getGuides(c) as g>
            <div class="col-sm-4">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                            <h5>
                                <a href="${links.get(g)}">${g.title}</a>
                                <#if g.community><span class="badge bg-primary"><i class="fa fa-users"></i> Community</span></#if>
                                <#if g.external><span class="badge bg-primary"><i class="fa fa-link"></i> External</span></#if>
                            </h5>
                            <#if g.summary??>
                            <span>${g.summary}</span>
                            </#if>
                    </div>
                </div>
            </div>
            </#list>
        </div>
    </div>
    </#list>
</div>

</@tmpl.page>