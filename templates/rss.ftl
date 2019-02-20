<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">

<channel>
  <title>Keycloak Blog</title>
  <link>https://www.keycloak.org/blog.html</link>
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
        <link>${home}/blog/${blog.filename}</link>
        <description><#outputformat 'HTML'>${description?esc}</#outputformat></description>
        <guid>${home}/blog/${blog.filename}</guid>
        <pubDate>${blog.date?string["EEE, d MMM YYYY"]}</pubDate>
        <#if blog.category??><category>${blog.category}</category></#if>
      </item>
  </#list>
</channel>

</rss>
