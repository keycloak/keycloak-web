<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->

<@tmpl.page current="guides" title="Guides" summary="Find the guides to help you get started, install Keycloak, and configure it and your applications to match your needs.">

<script src="${links.getResource('js/guides.js')}" type="text/javascript"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <div class="guides-navbar-content">
            <div>
                <select id="guide-version-select" data-nosnippet aria-label="Version" onchange="location = this.options[this.selectedIndex].value;" class="form-select">
                    <option value="${links.getGuides(true)}">Nightly</option>
                    <option value="${links.getGuides(false)}" selected="selected">${version.version}</option>
                </select>
            </div>
            <ul class="nav navbar-nav guides-navbar-menu">
                <#list guides.getCategories(false) as c>
                <li>
                    <a class="nav-link" href="#${c.id}">${c.title}</a>
                </li>
                </#list>
            </ul>
            <div>
                <form>
                    <input id="guide-search" class="form-control" type="text" placeholder="Search" aria-label="Search">
                </form>
            </div>
        </div>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4 pb-1">
    <div class="container">
        <#list guides.getCategories(false) as c>
            <div class="row guide-category mb-4" id="${c.id}">
                <h3>${c.title}</h3>
                <#list guides.getGuides(c) as g>
                <#if g.tileVisible && !g.snapshot>
                    <div class="col-sm-4 d-flex">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    ${g.title}
                                    <#if g.community><span class="float-end badge bg-primary fs-xsmall"><i class="fa fa-users"></i> community</span></#if>
                                    <#if g.external><span class="float-end badge bg-primary fs-xsmall"><i class="fa fa-link"></i> external</span></#if>
                                </h5>
                                <#if g.summary??>
                                <span class="card-text">${g.summary}</span>
                                </#if>
                                <#if g.tags??>
                                <div class="mt-2">
                                    <#list g.tags as tag>
                                    <span class="badge bg-light text-body-secondary fs-xsmall">${tag}</span>
                                    </#list>
                                </div>
                                </#if>
                            </div>
                            <div class="card-footer">
                                <a href="${links.get(g)}" <#if g.external>target="_blank"</#if> class="stretched-link">Read guide &rarr;</a>
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