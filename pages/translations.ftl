<#import "/templates/template.ftl" as tmpl>
<#-- @ftlvariable name="translations" type="org.keycloak.webbuilder.Translations" -->

<@tmpl.page current="case-studies" title="Translations" summary="Overview of the available translations for Keylcoak.">

<div class="container mt-5">
    <h1>Translations</h1>

    <p>
        Translating Keycloak is a community effort.
        See below for those translations that available in <a href="https://weblate.org/">Weblate</a>, our web based translation tool.
        Click on any of the links to contribute to the translations. A language maintainer will later review your translations.
    </p>

    <p>
        Some additional translations are not available via Weblate and are not listed below. They require pull requests to our main repository.
    </p>

    <p>
        Read more about the translation process and how to become a language maintainer in our <a href="https://github.com/keycloak/keycloak/blob/main/docs/translation.md">translation guidelines</a>.
    </p>

    <table class="table" style="width: auto" data-nosnippet>
        <thead>
        <tr>
            <th scope="col"></th>
            <#list translations.components as component>
                <td>
                    <a rel="nofollow" href="https://hosted.weblate.org/projects/keycloak/${component.slug()}/">
                        ${component.name()}
                    </a>
                </td>
            </#list>
            <td>To review</td>
        </tr>
        </thead>
        <tbody>
        <#list translations.languages as language>
        <tr>
            <th scope="row">
                <a rel="nofollow" href="https://hosted.weblate.org/projects/keycloak/-/${language.code()}/">
                    ${language.name()}
                </a>
            </th>
            <#list translations.components as component>
                <td style="text-align: right">
                <#assign tranlation = translations.getTranslation(component, language) >
                <#if tranlation.total() != tranlation.translated()>
                    <a rel="nofollow" href="https://hosted.weblate.org/translate/keycloak/${component.slug()}/${language.code()}/?q=state:%3Ctranslated">
                        ${tranlation.completionRate()}
                    </a>
                <#else>
                    &check;
                </#if>
                </td>
            </#list>
            <td style="text-align: right">
                <#if language.unapproved gt 0>
                    <a rel="nofollow" href="https://hosted.weblate.org/translate/keycloak/-/${language.code()}/?q=state%3A%3Dtranslated&sort_by=-priority%2Cposition&checksum=">${language.unapproved}</a>
                <#else>
                    &check;
                </#if>
            </td>
        </tr>
        </#list>
        </tbody>
    </table>

    <p  data-nosnippet>(Statistics updated daily. Last update: ${.now?iso("UTC")})</p>

</div>

</@tmpl.page>