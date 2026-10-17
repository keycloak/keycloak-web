<#macro selector selected guide="">
    <#local choices=guideVersions.all>
    <#if guide?has_content>
        <#local choices=guides.getVersionsFor(guide)>
    </#if>
    <select <#if !guide?has_content>id="guide-version-select"</#if> data-nosnippet aria-label="Version" onchange="location = this.options[this.selectedIndex].value;" class="form-select">
        <#list choices as choice>
            <#if guide?has_content>
                <#local url=links.getGuideVersion(guide, choice)>
            <#else>
                <#local url=links.getGuides(choice)>
            </#if>
            <option value="${url}" <#if selected.id == choice.id>selected="selected"</#if>>${choice.label}</option>
        </#list>
    </select>
</#macro>

<#macro disclaimer selected guide="">
    <#if selected.noindex>
        <#local currentUrl=links.guides>
        <#if guide?has_content>
            <#local currentUrl=links.getGuideVersion(guide, guideVersions.current)>
        </#if>
        <div class="mb-4 alert alert-warning" role="alert" data-pagefind-ignore>
            <#if selected.snapshot>
                <h4 class="no-top-margin">Nightly release</h4>
                These guides are for the unstable <a href="${links.nightly}">nightly release</a>.
                For the latest release go <a href="${currentUrl}">here</a>.
            <#else>
                <h4 class="no-top-margin">Archived release &mdash; Keycloak ${selected.minor}</h4>
                There will be no further community releases for the Keycloak ${selected.minor} minor release branch.
                These guides describe Keycloak ${selected.version}.
                For the latest community release, see the <a href="${currentUrl}">current guides</a>.
            </#if>
        </div>
    </#if>
</#macro>
