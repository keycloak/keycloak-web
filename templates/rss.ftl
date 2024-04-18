<#setting locale="en_US">
<#setting time_zone="GMT">
<#setting datetime_format="EEE, d MMM yyyy HH:mm:ss z">
<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">

<channel>
  <title>Keycloak Blog</title>
  <link>${ links.blog }</link>
  <atom:link href="${home}/rss.xml" rel="self" type="application/rss+xml" />
  <description>Keycloak Blog</description>
  <language>en-us</language>
  <category>Keycloak/SSO/Identity and Access Management</category>
  <#list blogs as blog>
    <#assign description>
        <#include "../${blog.template}">
    </#assign>
      <item>
        <title>${blog.title}</title>
        <link>${links.get(blog)}</link>
        <description><#outputformat 'HTML'>${description?esc}</#outputformat></description>
        <guid>${links.get(blog)}</guid>
        <pubDate>${blog.date?datetime}</pubDate>
        <#if blog.category??><category>${blog.category}</category></#if>
        <#if blog.author??><author>${blog.author}</author></#if>
      </item>
  </#list>
</channel>

</rss>
