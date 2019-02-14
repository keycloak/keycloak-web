<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">

<channel>
  <title>Keycloak Blog</title>
  <link>https://www.keycloak.org/blog.html</link>
  <description>Keycloak Blog</description>
  <language>en-us</language>
  <#list blogs as blog>
    <#assign description>
        <#include "../${blog.template}">
    </#assign>
      <item>
        <title>${blog.title}</title>
        <link>${home}/blog/${blog.filename}</link>
        <description><#outputformat 'HTML'>${description?esc}</#outputformat></description>
      </item>
  </#list>
</channel>

</rss>
