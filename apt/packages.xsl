<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="content">
    <html>
      <head>
        <title>
          <xsl:text>My packages</xsl:text>
        </title>
      </head>
      <body>
        <center>
          <h1>Command line</h1>
          <input type="text" id="cmd" style="width:80%;" readonly="readonly" value="apt install"/>
          <input type="button" value="clear" onclick="document.getElementById('cmd').value='apt-get install';" style="width:10%"/>
          <br/>
          <br/>
          <hr/>
        </center>
        <xsl:for-each select="section">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="section">
    <center>
      <h1>
        <xsl:value-of select="@name"/>
      </h1>
    </center>
    <xsl:for-each select="subsection">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
    <hr/>
  </xsl:template>
  <xsl:template match="subsection">
    <h3>
      <xsl:value-of select="@name"/>
    </h3>
    <ul>
      <xsl:for-each select="item">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template match="item">
    <li>
      <xsl:text>apt-get install </xsl:text>
      <b>
        <span onclick="document.getElementById('cmd').value = document.getElementById('cmd').value.concat(' ').concat(this.innerHTML);">
          <xsl:value-of select="."/>
        </span>
      </b>
      <br/>
      <font size="-1" color="navy">
        <xsl:value-of select="@desc"/>
      </font>
    </li>
  </xsl:template>
</xsl:stylesheet>
