<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="downloads" title="Downloads archive" noindex=true>

<div class="container mt-5 kc-article">
    <h1>Downloads archive</h1>

    <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="downloads.html">Downloads</a></li>
        <li class="breadcrumb-item active">Archive</li>
    </ol>
    </nav>

    <ul>
    <#list versions as version>
        <li><a href="archive/downloads-${version.versionShort}.html">${version.versionShort}</a></li>
    </#list>
    </ul>
</div>

</@tmpl.page>