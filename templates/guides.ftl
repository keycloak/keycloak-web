<#import "/templates/template.ftl" as tmpl>
<#import "/templates/guide-version.ftl" as gv>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->

<#assign title="Guides">
<#if guideVersion.noindex>
    <#assign title="Guides / ${guideVersion.label}">
</#if>
<@tmpl.page current=guideVersion.snapshot?then("nightly-guides", "guides") title=title noindex=guideVersion.noindex preloadImage="images/banner.svg" summary="Find the guides to help you get started, install Keycloak, and configure it and your applications to match your needs.">

<script src="${links.getResource('js/guides.js')}" defer></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <div class="guides-navbar-content">
            <div>
                <@gv.selector selected=guideVersion/>
            </div>
            <div>
                <form>
                    <div class="guide-search-wrapper">
                        <input id="guide-search" class="form-control" type="text" placeholder="Search" aria-label="Search" data-pagefind="${links.getRoot()}/pagefind/pagefind.js" data-pagefind-version="${guideVersion.id}">
                        <span id="guide-search-spinner" class="guide-search-spinner" hidden><i class="fa fa-spinner fa-spin"></i></span>
                        <button type="button" id="guide-search-clear" class="guide-search-clear" aria-label="Clear search" hidden><i class="fa fa-times"></i></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</nav>

<div id="pagefind-results" class="container pt-4" style="display: none;" aria-live="polite"></div>

<div id="guide-cards" class="jumbotron jumbotron-fluid bg-light kc-bg-triangles kc-bg-fixed pt-4 pb-1">
    <div class="container">
        <@gv.disclaimer selected=guideVersion/>
        <div class="row">
            <div class="col-lg-3 mb-4">
                <nav class="guides-sidebar" aria-label="Guide categories">
                    <h3 class="guides-sidebar-heading">Categories</h3>
                    <ul>
                        <#list guides.getCategories(guideVersion) as c>
                        <li>
                            <a href="#${c.id}">${c.title}</a>
                        </li>
                        </#list>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-9">
        <#list guides.getCategories(guideVersion) as c>
            <div class="row guide-category mb-4" id="${c.id}">
                <h3>${c.title}</h3>
                <#list guides.getGuides(c, guideVersion) as g>
                <#if g.tileVisible>
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
                            <a href="${links.get(g)}" <#if g.external>target="_blank"</#if> class="stretched-link"></a>
                        </div>
                    </div>
                </#if>
                </#list>
            </div>
        </#list>
            </div>
        </div>
    </div>
    </div>
</div>

</@tmpl.page>