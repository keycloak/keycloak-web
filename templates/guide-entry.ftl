<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="search" title="${guide.title}">

<div class="container mt-5 kc-article">
    <div class="row">
        <div class="col-md-9 col-xl-10 col-sm-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${links.getGuides(guide.snapshot)}">Guides</a></li>
                    <li class="breadcrumb-item"><a href="${links.getGuides(guide.snapshot)}#${guide.metadata.id}">${guide.metadata.title}</a></li>
                    <li class="breadcrumb-item active">${guide.title}</li>
                </ol>
            </nav>

            <div class="mb-4">
                <h1>${guide.title}</h1>
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

<script src="${links.getResource('js/guide.js')}" type="text/javascript"></script>

</@tmpl.page>
