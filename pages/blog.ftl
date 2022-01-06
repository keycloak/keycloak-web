<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="blog" title="Blog">

<div class="jumbotron jumbotron-fluid kc-bg-triangles py-5">
    <div class="container">
        <div class="row">
        <#assign displayed = 0>
        <#list blogs as blog>
        <div class="col-sm-6">
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h4><a href="${links.get(blog)}">${blog.title}</a></h4>
                    <span class="fs-xsmall text-muted">
                        ${blog.date?string["dd MMMM yyyy"]}
                        <#if blog.author??>by ${blog.author}</#if>
                    </span>

                    <#if blog.summary??>
                    <div class="mt-3">${blog.summary}</div>
                    </#if>
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
            <a class="float-end" href="${links.rss}"><img src="resources/images/rss.png"/></a>
            </div>
        </div>
    </div>
</div>

</@tmpl.page>