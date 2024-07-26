<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:param name="keyword" select="'キーワード'" />
  <xsl:template match="/">
    <html>
      <head>
        <title>検索結果</title>
      </head>
      <body>
        <h2>検索結果</h2>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th>タイトル</th>
            <th>作者</th>
            <th>出版社</th>
            <th>値段</th>
            <th>出版年月日</th>
            <th>キーワード</th>
            <th>筑波大学附属図書館蔵書検索</th>
          </tr>
          <xsl:for-each select="//item[keywords/keyword[contains(., $keyword)]]">
            <xsl:variable name="ISBN" select="isbn" />
            <tr>
              <td><xsl:value-of select="title" /></td>
              <td><xsl:value-of select="creator" /></td>
              <td><xsl:value-of select="publisher" /></td>
              <td><xsl:value-of select="price" /></td>
              <td>
                <xsl:value-of select="date/year" />/
                <xsl:value-of select="date/month" />/
                <xsl:value-of select="date/day" />
              </td>
              <td>
                <xsl:for-each select="keywords/keyword">
                  <xsl:value-of select="." /><xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
              </td>
              <td>
                <form action="./library.rb" method="get">
                  <input type="hidden" name="isbn" value="{$ISBN}" />
                  <input type="submit" value="蔵書検索" />
                </form>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
