<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:key name="keywordKey" match="keyword" use="." />

    <xsl:template match="/">
        <html>
        <head>
            <title>キーワード検索</title>
        </head>
        <body>
            <h1>キーワード検索</h1>
            <form action="./search_res.rb" method="post">
                <label for="keyword">キーワードを入力してください：</label>
                <input type="text" id="keyword" name="keyword"/>
                <input type="submit" value="検索"/>
            </form>
            <h2>トップ10キーワード</h2>
            <table border="1">
                <tr>
                    <th>キーワード</th>
                    <th>登場数</th>
                    <th>検索</th>
                </tr>
                <xsl:apply-templates select="//keyword[generate-id() = generate-id(key('keywordKey', .)[1])]">
                    <xsl:sort select="count(key('keywordKey', .))" order="descending" data-type="number"/>
                </xsl:apply-templates>
            </table>
        </body>
        </html>
    </xsl:template>

    <xsl:template match="keyword">
        <xsl:if test="position() &lt;= 10">
            <tr>
                <td><xsl:value-of select="."/></td>
                <td><xsl:value-of select="count(key('keywordKey', .))"/></td>
                <td>
                    <form action="search_res.rb" method="get" style="display:inline;">
                        <input type="hidden" name="keyword" value="{.}"/>
                        <input type="submit" value="このキーワードで検索"/>
                    </form>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
