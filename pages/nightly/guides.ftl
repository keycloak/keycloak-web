<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="nightly-guides" title="Guides / Nightly Release" noindex=true summary="Guides for Keycloak's nightly release which contains the very latest developments. Use it for testing only.">

<script src="${links.getResource('js/guides.js')}" type="text/javascript"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <div class="float-left">
            <select aria-label="Version" onchange="location = this.options[this.selectedIndex].value;">
                <option value="${links.getGuides(true)}" selected="selected">Nightly</option>
                <option value="${links.getGuides(false)}">${version.version}</option>
            </select>
        </div>
        <ul class="nav navbar-nav">
            <#list guides.getCategories(true) as c>
            <li>
                <a class="nav-link" href="#${c.id}">${c.title}</a>
            </li>
            </#list>
        </ul>
        <div class="float-right">
            <form>
                <input id="guide-search" class="form-control" type="text" placeholder="Search" aria-label="Search">
            </form>
        </div>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4 pb-1">

    <div class="container">
        <div class="alert alert-warning" role="alert">
          <h4>Nightly release</h4>

          These guides are for the unstable nightly release, for the latest release go <a href="${links.guides}">here</a>.
        </div>

        <#list guides.getCategories(true) as c>
            <div class="row guide-category mb-4" id="${c.id}">
                <h2>${c.title}</h2>
                <#list guides.getGuides(c) as g>
                <#if g.tileVisible && g.snapshot>
                    <div class="col-sm-4">
                        <div class="card shadow-sm mb-4">
                            <div class="card-body">
                                <h5 class="card-title">
                                    ${g.title}
                                    <#if g.community><span class="float-end badge bg-primary fs-xsmall"><i class="fa fa-users"></i> community</span></#if>
                                    <#if g.external><span class="float-end badge bg-primary fs-xsmall"><i class="fa fa-link"></i> external</span></#if>
                                </h5>
                                <#if g.summary??>
                                <span class="card-text">${g.summary}</span>
                                </#if>
                                <div>
                                    <#if g.tags??>
                                    <#list g.tags as tag>
                                    <span class="badge bg-light text-muted fs-xsmall mt-3">${tag}</span>
                                    </#list>
                                    </#if>
                                </div>
                                <a href="${links.get(g)}" <#if g.external>target="_blank"</#if> class="stretched-link link-dark"></a>
                            </div>
                        </div>
                    </div>
                </#if>
                </#list>
            </div>
        </#list>
    </div>
    </div>
</div>

</@tmpl.page>