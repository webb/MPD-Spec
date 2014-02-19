<?xml version="1.0" encoding="UTF-8"?>

<!--

How to use this XSLT:

1.  In the XSD you will check, insert the following 
line immediately beneath the <?xml ...> declaration:
<?xml-stylesheet type="text/xsl" href="./xsd.xsl"?>

2.  Put this XSLT into same directory as the XSD. 

3.  Drag and drop a copy of the XSD into a browser.

-->

<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:niem="http://niem.gov/niem/niem-core/2.0"
    xmlns:iso_4217="http://niem.gov/niem/iso_4217/2.0" 
    xmlns:fips_6-4="http://niem.gov/niem/fips_6-4/2.0" 
    xmlns:nonauth="http://niem.gov/niem/nonauthoritative-code/2.0" 
    xmlns:fbi="http://niem.gov/niem/fbi/2.0" 
    xmlns:nc="http://niem.gov/niem/niem-core/2.0" 
    xmlns:ut_offender="http://niem.gov/niem/ut_offender-tracking-misc/2.0" 
    xmlns:nga="http://niem.gov/niem/nga/2.0" 
    xmlns:usps="http://niem.gov/niem/usps_states/2.0" 
    xmlns:unece="http://niem.gov/niem/unece_rec20-misc/2.0" 
    xmlns:ansi_d20="http://niem.gov/niem/ansi_d20/2.0" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:atf="http://niem.gov/niem/atf/2.0" 
    xmlns:can="http://niem.gov/niem/post-canada/2.0" 
    xmlns:fips_10-4="http://niem.gov/niem/fips_10-4/2.0" 
    xmlns:fips_5-2="http://niem.gov/niem/fips_5-2/2.0" 
    xmlns:dod_jcs-pub2.0="http://niem.gov/niem/dod_jcs-pub2.0-misc/2.0" 
    xmlns:census="http://niem.gov/niem/census/2.0" 
    xmlns:twpdes="http://niem.gov/niem/twpdes/2.0" 
    xmlns:iso_3166="http://niem.gov/niem/iso_3166/2.0" 
    xmlns:s="http://niem.gov/niem/structures/2.0" 
    xmlns:iso_639-3="http://niem.gov/niem/iso_639-3/2.0" 
    xmlns:i="http://niem.gov/niem/appinfo/2.0" 
    xmlns:niem-xsd="http://niem.gov/niem/proxy/xsd/2.0" 
    xmlns:ansi-nist="http://niem.gov/niem/ansi-nist/2.0"
    >

<xsl:output method="text"/>

<xsl:variable name="nl"><xsl:text>
</xsl:text></xsl:variable>	

<xsl:template match="/">
<!--
    <html>
	<body>
	    <h2>title</h2>
	    <table border="3">
	    <thead style="background-color:maroon; color:white; ">
		<tr>
		    <th>hdrcol1</th>
		    <th>hdrcol2</th>
		</tr>
	    </thead>
-->
		<xsl:apply-templates />
<!--
	    </table>
	</body>
    </html>
-->
</xsl:template>

<!--
	<xsl:template match="/xsd:schema">
	    <xsl:for-each select="xsd:element" >
		<tr>
		    <td><xsl:value-of select="@name" /></td>
		    <td><xsl:value-of select="xsd:annotation/xsd:documentation" /></td>
		</tr>
	    </xsl:for-each>
	</xsl:template>
-->
			
<xsl:template match="/ ">
//xsd:element/@name=    <xsl:value-of select="count(//xsd:element/@name)"/>
//xsd:element/@ref=	<xsl:value-of select="count(//xsd:element/@ref)"/>
//xsd:attribute/@name=  <xsl:value-of select="count(//xsd:attribute/@name)"/>
//xsd:attribute/@ref=   <xsl:value-of select="count(//xsd:attribute/@ref)"/>
//xsd:element=		<xsl:value-of select="count(//xsd:element)"/>
//xsd:attribute=	<xsl:value-of select="count(//xsd:attribute)"/>
//xsd:complexType=	<xsl:value-of select="count(//xsd:complexType)"/>
//xsd:simpleType=	<xsl:value-of select="count(//xsd:simpleType)"/>

element name=
    <xsl:for-each select="//xsd:element[string-length(@name) &gt; 0]" >
	<xsl:value-of select="concat($nl,@name)"/>
    </xsl:for-each>

attribute name=
    <xsl:for-each select="//xsd:attribute[string-length(@name) &gt; 0]" >
	<xsl:value-of select="concat($nl,@name)"/>
    </xsl:for-each>
    
complexType name=
    <xsl:for-each select="//xsd:complexType[string-length(@name) &gt; 0]" >
	<xsl:value-of select="concat($nl,@name)"/>
    </xsl:for-each>
    
simpleType name=
    <xsl:for-each select="//xsd:simpleType[string-length(@name) &gt; 0]" >
	<xsl:value-of select="concat($nl,@name)"/>
    </xsl:for-each>

element ref=
    <xsl:for-each select="//xsd:element[string-length(@ref) &gt; 0]" >
	<xsl:value-of select="concat($nl,@ref)"/>
    </xsl:for-each>
    
attribute ref=
    <xsl:for-each select="//xsd:attribute[string-length(@ref) &gt; 0]" >
	<xsl:value-of select="concat($nl,@ref)"/>
    </xsl:for-each>

</xsl:template>

</xsl:stylesheet>

