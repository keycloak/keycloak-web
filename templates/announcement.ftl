<#-- Announcement banner: set enabled to false (or remove the assign) to hide it, including its JavaScript. Change version for each new announcement so dismissed banners reappear. -->
<#assign announcement = {
    "enabled": false,
    "version": "2026-10-17",
    "url": "https://www.keycloak.org/2026/09/keycloakcon-27-eu-call-for-papers",
    "text": "Speak at <b>KeycloakCon Europe 2027</b> in Barcelona! CfP closes October 18 &middot; Save the date: March 15, 2027 &middot; <span class=\"fw-semibold text-decoration-underline\">Submit Today &rarr;</span>"
}>
<#if announcement.enabled>
<div id="announcement-banner" hidden class="bg-primary text-center py-2 px-3" data-nosnippet data-version="${announcement.version}">
    <div class="position-relative px-4">
        <a class="link-light text-decoration-none small" href="${announcement.url}">${announcement.text?no_esc}</a>
        <button id="announcement-banner-close" type="button" class="btn-close btn-close-white position-absolute top-50 end-0 translate-middle-y" aria-label="Dismiss announcement"></button>
    </div>
</div>
<script>
    (function() {
        var banner = document.getElementById("announcement-banner");
        var close = document.getElementById("announcement-banner-close");
        var storageKey = "keycloak.announcement.dismissedVersion";
        try {
            if (window.localStorage.getItem(storageKey) === banner.dataset.version) {
                return;
            }
        } catch (error) {
            console.warn("Unable to read the announcement dismissal preference.", error);
        }
        banner.hidden = false;
        close.addEventListener("click", function() {
            banner.hidden = true;
            try {
                window.localStorage.setItem(storageKey, banner.dataset.version);
            } catch (error) {
                console.warn("Unable to save the announcement dismissal preference.", error);
            }
        });
    })();
</script>
</#if>
