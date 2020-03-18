<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">


<div class="page-section cards-section">
    <div class="container">

        <#list guides.categories as c>
        <h2>${c.label}</h2>

        <div class="row">
            <#list guides.getGuides(c) as g>
            <div class="col-sm-6">
                <a href="${links.get(g)}">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">${g.title}</h5>
                        <p class="card-text">${g.summary}</p>
                    </div>
                </div>
                </a>
            </div>
            </#list>
        </div>
        </#list>

    </div>
</div>

<#include "../templates/footer.ftl">