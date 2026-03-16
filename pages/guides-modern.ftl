<#import "/templates/template-tailwind.ftl" as tmpl>
<#-- @ftlvariable name="links" type="org.keycloak.webbuilder.Links" -->
<#-- @ftlvariable name="version" type="org.keycloak.webbuilder.Versions.Version" -->

<@tmpl.page current="guides" title="Guides" summary="Find the guides to help you get started, install Keycloak, and configure it and your applications to match your needs.">

<script src="${links.getResource('js/guides.js')}" type="text/javascript"></script>

<!-- Modern Hero Section with Guides Navigation -->
<div class="bg-gradient-to-b from-gray-900 to-gray-800 text-white pt-20">
    <div class="container mx-auto px-4 py-8" x-data="{ searchQuery: '' }">
        <!-- Version Selector & Categories -->
        <div class="flex flex-col lg:flex-row gap-4 items-start lg:items-center">
            <!-- Version Selector -->
            <div class="flex-shrink-0">
                <label class="block text-sm font-medium text-gray-300 mb-2">Version</label>
                <select
                    data-nosnippet
                    aria-label="Version"
                    onchange="location = this.options[this.selectedIndex].value;"
                    class="bg-gray-800 border border-gray-700 text-white rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:border-transparent"
                >
                    <option value="${links.getGuides(true)}">Nightly</option>
                    <option value="${links.getGuides(false)}" selected="selected">${version.version}</option>
                </select>
            </div>

            <!-- Category Navigation -->
            <nav class="flex-1 lg:mx-6">
                <p class="text-sm font-medium text-gray-300 mb-2">Categories</p>
                <div class="flex flex-wrap gap-2">
                    <#list guides.getCategories(false) as c>
                    <a
                        href="#${c.id}"
                        class="px-4 py-2 bg-gray-800 hover:bg-gray-700 rounded-lg transition-colors text-sm font-medium"
                    >
                        ${c.title}
                    </a>
                    </#list>
                </div>
            </nav>

            <!-- Search -->
            <div class="flex-shrink-0 w-full lg:w-auto">
                <label class="block text-sm font-medium text-gray-300 mb-2">Search</label>
                <input
                    id="guide-search"
                    x-model="searchQuery"
                    class="w-full lg:w-64 bg-gray-800 border border-gray-700 text-white rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:border-transparent placeholder-gray-400"
                    type="text"
                    placeholder="Search guides..."
                    aria-label="Search"
                >
            </div>
        </div>
    </div>
</div>

<!-- Guides Content -->
<div class="bg-white py-12">
    <div class="container mx-auto px-4">
        <#list guides.getCategories(false) as c>
            <div class="mb-12" id="${c.id}">
                <h2 class="text-3xl font-bold text-gray-900 mb-6">${c.title}</h2>

                <!-- Guides Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <#list guides.getGuides(c) as g>
                    <#if g.tileVisible && !g.snapshot>
                        <!-- Guide Card -->
                        <a
                            href="${links.get(g)}"
                            <#if g.external>target="_blank"</#if>
                            class="group block bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-200 overflow-hidden border border-gray-200 hover:border-primary"
                        >
                            <div class="p-6">
                                <!-- Title & Badges -->
                                <div class="flex items-start justify-between mb-3">
                                    <h3 class="text-xl font-semibold text-gray-900 group-hover:text-primary transition-colors flex-1">
                                        ${g.title}
                                    </h3>
                                    <div class="flex gap-1 ml-2">
                                        <#if g.community>
                                        <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-blue-100 text-blue-800">
                                            <i class="fas fa-users mr-1"></i> Community
                                        </span>
                                        </#if>
                                        <#if g.external>
                                        <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-purple-100 text-purple-800">
                                            <i class="fas fa-external-link-alt mr-1"></i> External
                                        </span>
                                        </#if>
                                    </div>
                                </div>

                                <!-- Summary -->
                                <#if g.summary??>
                                <p class="text-gray-600 text-sm mb-4 line-clamp-2">
                                    ${g.summary}
                                </p>
                                </#if>

                                <!-- Tags -->
                                <#if g.tags??>
                                <div class="flex flex-wrap gap-2">
                                    <#list g.tags as tag>
                                    <span class="inline-block px-2 py-1 rounded-md text-xs font-medium bg-gray-100 text-gray-700">
                                        ${tag}
                                    </span>
                                    </#list>
                                </div>
                                </#if>
                            </div>

                            <!-- Card Footer -->
                            <div class="px-6 py-3 bg-gray-50 border-t border-gray-100 group-hover:bg-primary group-hover:bg-opacity-5 transition-colors">
                                <span class="text-sm font-medium text-primary group-hover:translate-x-1 inline-block transition-transform">
                                    Read guide <i class="fas fa-arrow-right ml-1"></i>
                                </span>
                            </div>
                        </a>
                    </#if>
                    </#list>
                </div>
            </div>
        </#list>
    </div>
</div>

</@tmpl.page>
