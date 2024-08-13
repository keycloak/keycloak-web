<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="blog" title="Blog" rss=true>

<div class="jumbotron jumbotron-fluid bg-light kc-bg-triangles pt-4 pb-2">
    <div class="container">
        <div class="row">
        <#assign displayed = 0>
        <#list blogs as blog>
        <div class="col-sm-6">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h4 class="card-title">${blog.title}</h4>
                    <span class="card-subtitle fs-xsmall text-muted">
                        ${blog.date?string["dd MMMM yyyy"]}
                        <#if blog.author??>by ${blog.author}</#if>
                    </span>
                    <#if blog.summary??>
                    <div class="card-text">${blog.summary}</div>
                    </#if>
                    <a href="${links.get(blog)}" class="stretched-link link-dark"></a>
                </div>
            </div>
        </div>
        <#assign displayed = displayed + 1>
        <#if displayed == config.maxBlog>
            <#break>
        </#if>
        </#list>
        </div>
        <div class="row">
            <div class="col">
            <h4>For older entries go <a href="blog-archive.html">here</a></h4>
            </div>
            <div class="col">
            <h4><a class="float-end" href="${links.rss}"><i class="fas fa-rss text-dark"></i></a></h4>
            </div>
        </div>
    </div>
</div>

</@tmpl.page>