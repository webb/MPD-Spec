<?xml version="1.0" encoding="UTF-8"?><stylesheet xmlns:cf="http://ittl.gtri.org/wr24/2010-03-03-1533/curie-functions/1" xmlns:ct="http://ittl.gtri.gatech.edu/wr24/2010-03-03-1701/curie-test/1/" xmlns:f="http://ittl.gtri.org/wr24/2009-03-10-1439/xsl-functions" xmlns:xslext="http://ittl.gtri.gatech.edu/wr24/2009-03-23-1736/xsl-extension" xmlns="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <import href="curie-functions.xsl"/>
  <import href="xsl-functions.xsl"/>
  <output method="text"/>

  <template match="ct:tests">
    <text>Running tests:
</text>
    <apply-templates select="ct:safe-test"/>
  </template>

  <template match="ct:safe-test">
    <!--curie-test.xsl.xslext:20:--><xsl:if xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:private="http://ittl.gtri.gatech.edu/wr24/2009-03-23-1736/xsl-extension/private" xmlns:xe="http://ittl.gtri.gatech.edu/wr24/2009-03-23-1736/xsl-extension" test="not(exists(@safe-curie))"><xsl:message/><xsl:value-of select="error()"/></xsl:if>
    <text>  safe-test: </text>
    <variable name="result" select="cf:resolve-safe-curie(@safe-curie, .)"/>
    <choose>
      <when test="exists(@result) and $result = @result">
        <text>OK "</text>
        <value-of select="@safe-curie"/>
        <text>" yielded "</text>
        <value-of select="$result"/>
        <text>"
</text>
      </when>
      <when test="empty(@result) and empty($result)">
        <text>OK "</text>
        <value-of select="@safe-curie"/>
        <text>" yields empty as expected.
</text>
      </when>
      <otherwise>
        <text>BAD "</text>
        <value-of select="@safe-curie"/>
        <text>" yielded </text>
        <choose>
          <when test="empty($result)">
            <text>empty</text>
          </when>
          <otherwise>
            <text>"</text>
            <value-of select="$result"/>
            <text>" </text>
          </otherwise>
        </choose>
        <text> expected </text>
        <choose>
          <when test="exists(@result)">
            <text>"</text>
            <value-of select="@result"/>
            <text>"</text>
          </when>
          <otherwise>
            <text>empty</text>
          </otherwise>
        </choose>
        <text>
</text>
      </otherwise>
    </choose>
  </template>

  <template match="*">
    <message terminate="yes">
      <value-of select="f:get-message(., concat('unexpected element ', name()))"/>
    </message>
  </template>

  <template match="text()"/>

</stylesheet><!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->