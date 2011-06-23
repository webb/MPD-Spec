<?xml version="1.0" encoding="UTF-8"?><stylesheet xmlns:cf="http://ittl.gtri.org/wr24/2010-03-03-1533/curie-functions/1" xmlns:private="http://ittl.gtri.org/wr24/2010-03-03-1533/curie-functions/1/private" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xslext="http://ittl.gtri.gatech.edu/wr24/2009-03-23-1736/xsl-extension" xmlns="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <function name="cf:resolve-curie" as="xs:anyURI*">
      <param name="curie" as="xs:string"/>
      <param name="element" as="element()"/>
      <variable name="prefix" select="substring-before($curie, ':')"/>
      <variable name="rest" select="substring-after($curie, ':')"/>
      <variable name="base-URI" select="namespace-uri-for-prefix($prefix, $element)"/>
      <sequence select="xs:anyURI(concat($base-URI, $rest))"/>
  </function>

  <function name="cf:resolve-safe-curie" as="xs:anyURI*">
      <param name="safe-curie" as="xs:string"/>
      <param name="element" as="element()"/>
      <choose>
         <when test="matches($safe-curie, '^\[.*\]$')">
            <sequence select="cf:resolve-curie( substring($safe-curie, 2, string-length($safe-curie) - 2), $element)"/>
         </when>
         <otherwise>
            <value-of select="xs:anyURI($safe-curie)"/>
         </otherwise>
      </choose>
  </function>
</stylesheet><!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->