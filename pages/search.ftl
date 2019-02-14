<#assign title = "Search">

<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="page-section">
    <div class="container">
        <h1>Search</h1>

        <p>Search the Keycloak website, documentation, blog and mailing lists.</p>

        <div>
            <script>
                (function() {
                    var cx = '003352037071895905641:hyz4b1vj6uu';
                    var gcse = document.createElement('script');
                    gcse.type = 'text/javascript';
                    gcse.async = true;
                    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(gcse, s);
                })();
            </script>
            <gcse:search></gcse:search>
        </div>
    </div>
</div>

<#include "../templates/footer.ftl">