<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="get-started" title="Getting started">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <ul class="nav navbar-nav" id="categoriesTabs" role="tablist">
            <#list guides.categories as c>
            <li role="presentation">
                <a class="nav-link <#if c?is_first>active</#if>" id="${c.id}-tab" data-bs-toggle="tab" data-bs-target="#${c.id}" type="button" role="tab" aria-controls="home" aria-selected="true">${c.label}</a>
            </li>
            </#list>
        </ul>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid kc-bg-triangles pt-4">
    <div class="container">
    <div class="tab-content" id="categoriesContent">
        <#list guides.categories as c>
            <div class="tab-pane fade <#if c?is_first>show active</#if>" id="${c.id}" role="tabpanel" aria-labelledby="${c.id}-tab">
                <div class="row">
                    <#list guides.getGuides(c) as g>
                    <div class="col-sm-4">
                        <div class="card shadow-sm mb-4">
                            <div class="card-body">
                                <h5 class="card-title">
                                    ${g.title}
                                    <#if g.community><span class="badge bg-primary"><i class="fa fa-users"></i> Community</span></#if>
                                    <#if g.external><span class="badge bg-primary"><i class="fa fa-link"></i> External</span></#if>
                                </h5>
                                <#if g.summary??>
                                <span class="card-text">${g.summary}</span>
                                </#if>
                                <a href="${links.get(g)}" class="stretched-link link-dark"></a>
                            </div>
                        </div>
                    </div>
                    </#list>
                </div>
            </div>
        </#list>
    </div>
    </div>
</div>

</@tmpl.page>