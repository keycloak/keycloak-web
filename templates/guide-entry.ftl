<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="search" title="Search">

<div class="container mt-5 kc-article">
    <#if guide.community>
    <p class="community-badge text-primary">
        <i class="fa fa-users text-primary"></i> Contributed by <a href="https://github.com/${guide.author}">${guide.author}</a>
    </p>
    </#if>

    <h1>${guide.title}</h1>
    <#if guide.summary??>
    <p>${guide.summary}</p>
    </#if>

    <#include "../${guide.template}">
</div>

</@tmpl.page>
