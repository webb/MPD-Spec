<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:c="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"
                xmlns:xml-catalog="urn:oasis:names:tc:entity:xmlns:xml:catalog"
                xmlns:structures="http://release.niem.gov/niem/structures/3.0/"
                version="2.0"><!--Importing stylesheet additions--><xsl:output xmlns:sch="http://www.ascc.net/xml/schematron" method="text"/>
   <!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->


<!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <xsl:apply-templates select="/" mode="M4"/>
      <xsl:apply-templates select="/" mode="M5"/>
      <xsl:apply-templates select="/" mode="M6"/>
      <xsl:apply-templates select="/" mode="M7"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/" priority="1000" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="c:Catalog"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>An MPD catalog must have document element c:Catalog.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

   <!--PATTERN -->


	<!--RULE -->
<xsl:template match="c:MPD" priority="1001" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="c:ReadMe"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>A c:MPD MUST have a c:ReadMe.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="c:MPD" priority="1000" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="c:MPDChangeLog"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>A c:MPD MUST have a c:MPDChangeLog.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN -->


	<!--RULE -->
<xsl:template match="*[@c:xmlCatalogURI]" priority="1000" mode="M6">
      <xsl:variable name="uri" select="resolve-uri(@c:xmlCatalogURI, base-uri(.))"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="doc-available($uri)"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>An attribute c:xmlCatalogURI MUST resolve to an XML document.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(doc-available($uri))                   or doc($uri)/xml-catalog:catalog"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>An attribute c:xmlCatalogURI MUST resolve to an XML catalog.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN -->


	<!--RULE -->
<xsl:template match="c:IEPConformanceTarget" priority="1000" mode="M7">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(@structures:id)"/>
         <xsl:otherwise>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="base-uri(.)"/>
            <xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron"
                          use-when="function-available('saxon:line-number')">
               <xsl:text>:</xsl:text>
               <xsl:value-of select="saxon:line-number()"/>
            </xsl:value-of>
            <xsl:text xmlns:sch="http://www.ascc.net/xml/schematron">:assert:</xsl:text>An IEP conformance target MUST have an ID.<xsl:value-of xmlns:sch="http://www.ascc.net/xml/schematron" select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>
