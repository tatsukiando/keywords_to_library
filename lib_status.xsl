<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>蔵書状況</title>
      </head>
      <body>
        <h2>蔵書状況</h2>
        <a>
        <xsl:attribute name="href">
            <xsl:value-of select="/result/books/book/system/reserveurl" />
        </xsl:attribute>
        予約用URL
        </a>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th>館名</th>
            <th>貸出状況</th>
          </tr>
          <xsl:for-each select="/result/books/book/system/libkeys">
          <xsl:for-each select="libkey">
            <tr>
                  <td><xsl:value-of select="@name" /></td>
                  <td><xsl:value-of select="." /></td>
            </tr>
            </xsl:for-each>
          </xsl:for-each>
        </table>
        <a href="javascript:history.back()">戻る</a>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
