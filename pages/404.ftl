<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="keys" title="Page not found" noindex=true summary="The page you’re looking for does not exist.">

<div class="container mt-5">
    <h1 id="heading">Page not found</h1>

    <div id="notfound">
        <p>
            The page you’re looking for does not exist. It may have been moved. You can return to <a href="${links.home}">the start page</a>, or follow one of the links in the navigation on the top.
        </p>
        <p>
            If you arrived at this page by clicking on a link, please notify the owner of the site that the link is broken. If you typed the URL of this page manually, please double-check that you entered the address correctly.
        </p>

        <p>
            If you think this is a bug that the Keycloak team should fix, create <a id="buglink" href="https://github.com/keycloak/keycloak-web/issues/new?template=bug.yml&title=Broken%20link%20on%20the%20website%20{url}&description=%0A%0AURL:%20{url}">a bug issue on the GitHub issue tracker</a>.
        </p>
    </div>

    <div id="redirecting" style="display: none">
        <p>
            You are being redirected to <a id="redirectlink" href="...">...</a>.
        </p>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var buglink = document.getElementById("buglink")
            var href = buglink.getAttribute("href")
            href = href.replaceAll("\{url\}", encodeURIComponent(window.location))
            buglink.setAttribute("href", href)
        });
    </script>

</div>

<script src="${links.getResource('js/redirect.js')}" type="text/javascript"></script>

</@tmpl.page>
