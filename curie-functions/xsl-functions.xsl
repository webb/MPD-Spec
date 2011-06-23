<?xml version="1.0" encoding="UTF-8"?><stylesheet xmlns:f="http://ittl.gtri.org/wr24/2009-03-10-1439/xsl-functions" xmlns:private="http://ittl.gtri.org/wr24/2009-03-10-1439/xsl-functions/private" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <!-- ============================================================ -->
  <!-- FUNCTIONS -->
  <!-- ============================================================ -->

  <function name="f:attribute-matches" as="xs:boolean">
    <param name="attribute" as="attribute()"/>
    <param name="qname" as="xs:QName"/>
    <variable name="attribute-qname" select="QName(namespace-uri($attribute), local-name($attribute))"/>
    <sequence select="$attribute-qname = $qname"/>
  </function>

  <function name="f:get-item-description" as="xs:string">
    <param name="item" as="item()"/>
    <value-of>
      <if test="$item/self::node()"> node()</if>
      <if test="$item/self::text()"> text(<value-of select="$item"/>)</if>
      <if test="$item/self::comment()"> comment(<value-of select="$item"/>)</if>
      <if test="$item/self::element()"> element(<value-of select="namespace-uri($item)"/>, <value-of select="local-name($item)"/>)</if>
      <if test="$item/self::attribute()"> attribute(<value-of select="namespace-uri($item)"/>, <value-of select="local-name($item)"/>)</if>
      <if test="$item/self::document-node()"> document-node(<value-of select="namespace-uri($item)"/>, <value-of select="local-name($item)"/>)</if>
      <if test="$item/self::processing-instruction()"> processing-instruction()</if>
    </value-of>
  </function>

  <function name="f:get-location" as="xs:string">
    <!-- return a string that shows the file and line number of the
         given location.  -->
    <param name="context"/>
    <value-of select="concat(tokenize(base-uri($context),'/')[last()], ':', saxon:line-number($context), ':')"/>
  </function>

  <function name="f:get-message" as="xs:string">
    <!-- return a string that is a useful error message for some
         location -->
    <param name="context"/>
    <param name="message"/>
    <value-of>
      <value-of select="f:get-location($context)"/>
      <text>: </text>
      <value-of select="$message"/>
    </value-of>
  </function>

  <function name="f:get-namespace-from-qualified-name" as="xs:string">
    <param name="context" as="element()"/>
    <param name="qualified-name" as="xs:string"/>
    <value-of select="namespace-uri-from-QName(resolve-QName($qualified-name, $context))"/>
  </function>

  <!-- downselects string down to letters, numbers, and period.  Good for element names, types, etc. -->
  <function name="f:get-safe-string" as="xs:string">
    <param name="string" as="xs:string"/>
    <variable name="normalized" as="xs:string" select="normalize-space($string)"/>
    <value-of select="private:get-safe-string($normalized)"/>
  </function>

  <function name="f:implies" as="xs:boolean">
    <param name="lhs" as="xs:boolean"/>
    <param name="rhs" as="xs:boolean"/>
    <sequence select="not($lhs) or $rhs"/>
  </function>

  <function name="f:is-in" as="xs:boolean">
    <!-- true if item is in list -->
    <param name="item" as="item()"/>
    <param name="list" as="item()*"/>
    <sequence select="some $list-item in $list satisfies ($item = $list-item)"/>
  </function>

  <function name="f:is-qualified-name-same-as" as="xs:boolean">
    <param name="context"/>
    <param name="qualified-name" as="xs:string"/>
    <param name="namespace" as="xs:anyURI"/>
    <param name="local-name" as="xs:string"/>
    <sequence select="QName($namespace, $local-name) = resolve-QName($qualified-name, $context)"/>
  </function>

  <function name="f:join-strings">
    <param name="lhs" as="xs:string"/>
    <param name="join-string" as="xs:string"/>
    <param name="rhs" as="xs:string"/>
    <value-of select="concat(                           $lhs,                            if ($lhs != '' and $rhs != '')                                then $join-string                                else '',                            $rhs)"/>
  </function>

  <function name="f:QName-get-braces" as="xs:string">
    <param name="qname" as="xs:QName"/>
    <value-of select="concat('{', namespace-uri-from-QName($qname), '}', local-name-from-QName($qname))"/>
  </function>

  <function name="f:QName-get-clark-name" as="xs:string">
    <param name="qname" as="xs:QName"/>
    <value-of select="f:QName-get-braces($qname)"/>
  </function>

  <function name="f:QName-local-name-append" as="xs:QName">
    <param name="qname" as="xs:QName"/>
    <param name="string" as="xs:string"/>
    <sequence select="QName(                           namespace-uri-from-QName($qname),                           concat(                               local-name-from-QName($qname),                               $string))"/>
  </function>

  <function name="f:QName-local-name-join-append" as="xs:QName">
    <param name="qname" as="xs:QName"/>
    <param name="join-string" as="xs:string"/>
    <param name="string" as="xs:string"/>
    <sequence select="QName(                           namespace-uri-from-QName($qname),                           if ($string = '')                                then local-name-from-QName($qname)                               else concat(local-name-from-QName($qname), $join-string, $string))"/>
  </function>

  <function name="f:QName-local-name-prepend" as="xs:QName">
    <param name="qname" as="xs:QName"/>
    <param name="string" as="xs:string"/>
    <sequence select="QName(                         namespace-uri-from-QName($qname),                         concat($string,                              local-name-from-QName($qname)))"/>
  </function>

  <function name="f:string-to-node" as="node()">
    <param name="string" as="xs:string"/>
    <value-of select="$string"/>
  </function>

  <function name="private:get-safe-string" as="xs:string">
    <param name="string" as="xs:string"/>
    <choose>
      <when test="string-length($string) = 0"><value-of select="''"/></when>
      <otherwise>
        <variable name="first" select="substring($string, 1, 1)"/>
        <variable name="rest" select="private:get-safe-string(substring($string,2))"/>
        <variable name="first-xformed" select="if (matches($first, '[a-zA-Z0-9\.]'))                               then $first                               else '_'"/>
        <value-of select="concat($first-xformed, $rest)"/>
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