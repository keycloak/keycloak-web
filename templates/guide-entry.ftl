<#import "/templates/template.ftl" as tmpl>
<#import "/templates/guide-version.ftl" as gv>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->
<#-- @ftlvariable name="guide" type="org.keycloak.webbuilder.Guides.Guide" -->

<@tmpl.page current="search" title="${guide.title}" summary="${guide.summary}" noindex=guide.version.noindex toc=true>

<div class="container mt-5 kc-article">
    <div class="row">
        <div class="col-md-9 col-xl-10 col-sm-12" data-pagefind-body data-pagefind-filter="category:${guide.metadata.title}">
            <div class="d-flex align-items-center mb-3" data-pagefind-ignore>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${links.getGuides(guide.version)}">Guides</a></li>
                        <li class="breadcrumb-item"><a href="${links.getGuides(guide.version)}#${guide.metadata.id}">${guide.metadata.title}</a></li>
                        <#if guide.parent?has_content>
                          <li class="breadcrumb-item"><a href="${links.getParentLink(guide)}">${guide.parent?replace('-', ' ')?cap_first}</a></li>
                        </#if>
                        <li class="breadcrumb-item active">${guide.title}</li>
                    </ol>
                </nav>
            </div>

            <@gv.disclaimer selected=guide.version guide=guide/>

            <span data-pagefind-filter="version" hidden>${guide.version.id}</span>
            <div class="mb-4">
                <div data-nosnippet data-pagefind-ignore class="me-3 float-end">
                    <@gv.selector selected=guide.version guide=guide/>
                </div>

                <h1 data-pagefind-meta="title">${guide.title}</h1>
                <#if guide.summary??>
                    <span class="text-muted">${guide.summary}</span>
                </#if>
            </div>

            <#if guide.name == 'all-config'>
                <div class="mb-4">
                    <form>
                        <div class="row">
                            <div class="col">
                                <input id="options-search" class="form-control" type="text" placeholder="Search" aria-label="Search">
                            </div>
                            <div class="col">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="options-filter" value="all" id="options-filter-all" checked>
                                    <label class="form-check-label" for="options-filter-all">All</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="options-filter" value="build" id="options-filter-build">
                                    <label class="form-check-label" for="options-filter-build">Build options</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="options-filter" value="config" id="options-filter-config">
                                    <label class="form-check-label" for="options-filter-config">Configuration</label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </#if>


            <div class="kc-asciidoc" id="guide-body">
                <#include "../target/tmp/guide.html" parse=false>
            </div>
        </div>

        <div class="col-md-3 mt-4 col-xl-2 col-sm-12 bg-light">
            <div class="sticky-top px-2 py-3">
                <#if guide.community>
                   <p class="community-badge text-primary">
                       <i class="fa fa-users text-primary"></i> Community guide
                   </p>
               </#if>
                <div class="mt-2 mb-2 fw-bold">On this page</div>
                <div id="js-toc"></div>
                <div class="mt-4">
                    <a href="${links.getGuideEdit(guide)}" target="_blank"><i class="fa fa-edit"></i> Edit this guide</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${links.getResource('js/guide.js')}" defer></script>

</@tmpl.page>
