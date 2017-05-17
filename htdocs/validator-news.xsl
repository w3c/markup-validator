<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/2005/Atom"
  exclude-result-prefixes="h">

<xsl:output method="xml" encoding="UTF-8" indent="yes"
  media-type="application/atom+xml"/>

<xsl:param name="host" select="'validator.w3.org'"/>
<xsl:param name="self" select="concat('https://', $host, '/whatsnew.atom')"/>
<xsl:param name="validator" 
    select="concat('https://', $host, '/whatsnew.html')"/>
<!-- number of entries to be displayed in the feed -->
<xsl:param name="limit" select="10"/>
<xsl:param name="author" select="'The W3C Validator Team'"/>
<!-- 
  feedvalidator.org complains about dates like YYYY-MM-DD not 
  being valid ISO datetimes, so we hack around it by setting 
  each item's publish time to 00:00:00 UTC
-->
<xsl:param name="faketime" select="'T00:00:00Z'"/>

<xsl:template match="/">
<feed xml:lang="en">
  <title><xsl:value-of select="/h:html/h:head/h:title"/></title>
  <updated>
    <xsl:value-of
	select="concat(substring-after(/h:html/h:body/*//h:dt[position()=1]/@id,
		't'), $faketime)"/>
  </updated>
  <author>
    <name><xsl:value-of select="$author"/></name>
  </author>
  <id><xsl:value-of select="$self"/></id>
  <link href="{$validator}"/>
  <link rel="self" href="{$self}"/>

  <!-- entries -->
  <xsl:apply-templates select="//h:dt[position() &lt; $limit]"/>
</feed>
</xsl:template>

<xsl:template match="h:dt">
<xsl:variable name="updated" select="substring-after(@id, 't')"/>
  <entry>
    <id><xsl:value-of 
      select="concat('tag:', $host, ',', $updated, ':', @id)"/></id>
    <updated><xsl:value-of select="concat($updated, $faketime)"/></updated>
    <link href="{concat($validator, '#', @id)}"/>
    <title><xsl:value-of select="substring-before(., ':')"/></title>
    <content xml:base="{$validator}" type="xhtml">
      <div xmlns="http://www.w3.org/1999/xhtml">
	<xsl:copy-of select="following::h:dd[position()=1]/node()"/>
      </div>
    </content>
  </entry>
</xsl:template>

<xsl:template match="text()">
</xsl:template>

</xsl:stylesheet>
