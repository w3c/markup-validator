<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

  <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01//EN"/>

  <xsl:template match="result">
<html lang="en">
  <head>
    <title>Report</title>
    <link rel="stylesheet" type="text/css" href="xml-results.css"/>
  </head>
  <body>
<!-- insert HTML body top parts here -->
    <xsl:apply-templates select="meta"/>
<!-- insert (whatever) between tables -->
    <xsl:apply-templates select="warnings"/>
<!-- insert (whatever) between tables -->
    <xsl:apply-templates select="messages"/>
<!-- insert HTML footer here -->
  </body>
</html>
  </xsl:template>

  <xsl:template match="meta">
  <table id="meta" summary="Metadata concerning the page">
    <tbody>
      <tr><th scope="row">URL</th>            <td><a><xsl:attribute name="href"><xsl:value-of select="uri"/></xsl:attribute></a></td></tr>
      <tr><th scope="row">Last Modified</th>  <td><xsl:value-of select="modified"/></td></tr>
      <tr><th scope="row">Server</th>         <td><xsl:value-of select="server"/></td></tr>
      <tr><th scope="row">Content-Length</th> <td><xsl:value-of select="size"/></td></tr>
      <tr><th scope="row">Encoding</th>       <td><xsl:value-of select="encoding"/></td></tr>
      <tr><th scope="row">Doctype</th>        <td><xsl:value-of select="doctype"/></td></tr>
    </tbody>
  </table>
  </xsl:template>

  <xsl:template match="warnings">
  <ul style="display: list">
    <xsl:apply-templates select="warning"/>
  </ul>
  </xsl:template>

  <xsl:template match="messages">
  <table id="errors" summary="Error messages">
    <thead>
      <tr>
        <th scope="col">Line</th>
        <th scope="col">Char</th>
        <th scope="col">Offset</th>
        <th scope="col">Message</th>
      </tr>
    </thead>
    <tbody>
    <xsl:apply-templates select="msg"/>
    </tbody>
  </table>
  </xsl:template>

  <xsl:template match="warning">
    <li><xsl:value-of select="text()"/></li>
  </xsl:template>

  <xsl:template match="msg">
    <tr>
      <td><xsl:value-of select="@line"/></td>
      <td><xsl:value-of select="@col"/></td>
      <td><xsl:value-of select="@offset"/></td>
      <td><xsl:value-of select="text()"/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
