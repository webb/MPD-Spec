<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ca="http://reference.niem.gov/niem/resource/mpd/catalog/1.0/">

<xsl:output method="html" indent="yes"/>

<xsl:template name="put-row">
  <xsl:param name="item"/>
      <tr>
	<td><xsl:value-of select="$item/@ca:id"/></td>
	<td>
	    <a>
		<xsl:attribute name="href">
		      <xsl:value-of select="$item/@ca:relativePathName"/>
		</xsl:attribute>
		<xsl:value-of select="$item/@ca:relativePathName"/>
	    </a>
	</td>
	<td><xsl:value-of select="$item/@ca:descriptionText"/></td>
	<td><xsl:value-of select="$item/@ca:externalURI"/></td>
    </tr>
</xsl:template>

<xsl:template name="process-ids">
    <xsl:param name="in-string"/>
    <xsl:variable name="normalized" select="normalize-space($in-string)"/>
    <xsl:variable name="head">
      <xsl:choose>
        <xsl:when test="contains($normalized, ' ')">
          <xsl:value-of select="substring-before($normalized, ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$normalized"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($head) = 0"/>
      <xsl:otherwise>
        <xsl:variable name="match" select="//*[normalize-space(@ca:id) = $head]"/>
        <xsl:call-template name="put-row">
          <xsl:with-param name="item" select="$match"/>
        </xsl:call-template>
      <xsl:variable name="tail" select="substring-after(normalize-space($in-string), ' ')"/>
      <xsl:if test="string-length($tail) &gt; 0">
        <xsl:call-template name="process-ids">
	  <xsl:with-param name="in-string" select="$tail" />
        </xsl:call-template>
      </xsl:if>
     </xsl:otherwise>

   </xsl:choose>
</xsl:template>

<xsl:template match="/">
    <html>
	<body><xsl:apply-templates/></body>
    </html>
</xsl:template>

<xsl:template match="/ca:Catalog">
    <h1>IEPD: <xsl:value-of select="@ca:mpdName" /></h1>
    <table border="3">
	<thead style="background-color:maroon; color:white; ">
	    <tr>
		<th>Attribute</th>
		<th>Value</th>
	    </tr>
	</thead>
	<tr>
	    <td>URI</td>
	    <td><xsl:value-of select="@ca:mpdURI" /></td>
	</tr>
	<tr>
	    <td>Class</td>
	    <td><xsl:value-of select="@ca:mpdClassCode" /></td>
	</tr>
	<tr>
	    <td>Name</td>
	    <td><xsl:value-of select="@ca:mpdName" /></td>
	</tr>
	<tr>
	    <td>Version</td>
	    <td><xsl:value-of select="@ca:mpdVersionID" /></td>
	</tr>
	<tr>
	    <td>Description</td>
	    <td><xsl:value-of select="@ca:descriptionText" /></td>
	</tr>
    </table>

    <h2>All File Artifacts (and Folders; organized by directory)</h2>

    <table border="3">
	<thead style="background-color:maroon; color:white; ">
	    <tr>
		<th>Local ID</th>
		<th>Path and File Name</th>
		<th>Description</th>
		<th>External URI</th>
	    </tr>
	</thead>
     
	<xsl:for-each select="//ca:File | //ca:Folder">
	<xsl:sort select="@ca:relativePathName" />
        <xsl:call-template name="put-row">
          <xsl:with-param name="item" select="."/>
        </xsl:call-template>
    </xsl:for-each>

</table>

<h2>All FileSet Artifacts (organized by set)</h2>
    
    <table border="3">

	<thead style="background-color:maroon; color:white; ">
	    <tr>
		<th>Local ID</th>
		<th>Path and File Name</th>
		<th>Description</th>
		<th>External URI</th>
	    </tr>
	</thead>

    <xsl:for-each select="ca:FileSet">

<!-- process FileSet element -->

        <xsl:call-template name="put-row">
          <xsl:with-param name="item" select="."/>
        </xsl:call-template>

<!-- process FileSet/@files list -->

	<xsl:call-template name="process-ids">
	    <xsl:with-param name="in-string" select="@ca:files" />
	</xsl:call-template>

<!-- process each FileSet/File element -->

    <xsl:for-each select="ca:File">
        <xsl:call-template name="put-row">
          <xsl:with-param name="item" select="."/>
        </xsl:call-template>
      </xsl:for-each>

    </xsl:for-each>
    </table>

    <h2>Notes about artifacts:</h2>
    <p>Artifacts with External URIs are reused from another MPD.</p>

    <h2>Metadata</h2>

    <table border="3">
      <thead style="background-color:#24ffc0; ">
      <tr>
        <th>Attribute</th>
	<th>Value</th>
      </tr>
      </thead>
      <tr>
	<td>Security Marking</td>
	<td><xsl:value-of select="ca:Metadata/ca:SecurityMarkingText"/></td>
      </tr>
      <tr>
	<td>Creation Date</td>
	<td><xsl:value-of select="ca:Metadata/ca:CreationDate"/></td>
      </tr>
      <tr>
	<td>Last Revision Date</td>
	<td><xsl:value-of select="ca:Metadata/ca:LastRevisionDate"/></td>
      </tr>
      <tr>
	<td>Next Revision Date</td>
	<td><xsl:value-of select="ca:Metadata/ca:NextRevisionDate"/></td>
      </tr>
      <tr>
	<td>Status</td>
	<td><xsl:value-of select="ca:Metadata/ca:StatusText"/></td>
      </tr>


      <xsl:for-each select="ca:Metadata/ca:KeywordText">
	<tr>
	    <td>Keyword</td>
	    <td><xsl:value-of select="."/></td>
	</tr>
      </xsl:for-each>

      <xsl:for-each select="ca:Metadata/ca:DomainText">
	<tr>
	    <td>Domain</td>
	    <td><xsl:value-of select="."/></td>
	</tr>
      </xsl:for-each>

      <tr>
	  <td>Purpose</td>
	  <td>    
	      <xsl:value-of select="ca:Metadata/ca:PurposeText"/>
	  </td>
      </tr>

      <xsl:for-each select="ca:Metadata/ca:ExchangePatternText">
	<tr>
	    <td>Exchange Pattern</td>
	    <td><xsl:value-of select="."/></td>
	</tr>
      </xsl:for-each>

      <xsl:for-each select="ca:Metadata/ca:ExchangePartnerName">
	<tr>
	    <td>Exchange Partner</td>
	    <td><xsl:value-of select="."/></td>
	</tr>
      </xsl:for-each>

    </table>

    <h2>Lineage</h2>

    <table border="3">
	<thead style="background-color:green; color:white; ">
	    <tr>
		<th>Relationship</th>
		<th>Resource</th>
		<th>Description</th>
	    </tr>
	</thead>
	<xsl:for-each select="ca:Metadata/ca:Relationship">
	    <tr>
		<td><xsl:value-of select="@ca:relationshipCode"/></td>
		<td><xsl:value-of select="@ca:resourceURI"/></td>
		<td><xsl:value-of select="@ca:descriptionText"/></td>
	    </tr>
	</xsl:for-each>

    </table>

    <h2>Authoritative Source</h2> 

    <table border="3">
	<thead style="background-color:blue; color:white; ">
	    <tr>
		<th>Attribute</th>
		<th>Value</th>
	    </tr>
	</thead>
	<tr>
	    <td>Name</td>
	    <td>
		<xsl:value-of select="ca:Metadata/ca:AuthoritativeSource/ca:ASName"/>
	    </td>
	</tr>
	<tr>
	    <td>Address</td>
		<td>
		  <xsl:value-of select="ca:Metadata/ca:AuthoritativeSource/ca:ASAddressText"/>
		</td>
	</tr>
	<tr>
	    <td>Web Site</td>
	    <td>
		<xsl:value-of select="ca:Metadata/ca:AuthoritativeSource/ca:ASWebSiteURL"/>
	    </td>
	</tr>
	<xsl:for-each select="ca:Metadata/ca:AuthoritativeSource/ca:POC">
	    <tr>
		<td>POC</td>
		<td>
		    <xsl:value-of select="ca:POCName"/>, 
		    <xsl:value-of select="ca:POCEmail"/>, 
		    <xsl:value-of select="ca:POCTelephone"/>
		</td>
	    </tr>
	</xsl:for-each>
    </table>

</xsl:template>
</xsl:stylesheet>

