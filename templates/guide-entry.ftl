<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="search" title="${guide.category.label} - ${guide.title}">

<div class="container mt-5 kc-article">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${links.guides}">Guides</a></li>
                    <li class="breadcrumb-item"><a href="${links.guides}#${guide.category.id}">${guide.category.label}</a></li>
                    <li class="breadcrumb-item active">${guide.title}</li>
                </ol>
            </nav>

            <div class="mb-4">
                <h1>${guide.title}</h1>
                <#if guide.summary??>
                    <span class="text-muted">${guide.summary}</span>
                </#if>
            </div>

            <div class="kc-asciidoc" id="guide-body">
                <#include "../target/tmp/${guide.template}">
            </div>
        </div>

        <div class="col-2 bg-light">
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
