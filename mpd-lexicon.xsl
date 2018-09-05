<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:owl="http://www.w3.org/2002/07/owl#" >

<xsl:output method="html"/>

<xsl:template match="/">
    <html>
	<body>
	    <xsl:apply-templates />
	</body>
    </html>
</xsl:template>

<xsl:template match="/rdf:RDF">

    <h2>NIEM Natures</h2>
	<table border="3">
	    <thead style="background-color:maroon; color:white; ">
		<tr>
		    <th>Nature</th>
		    <th>Definition</th>
		</tr>
	    </thead>

	    <xsl:for-each select="owl:Class" >
		<tr>
		    <td><xsl:value-of select="@rdf:about" /></td>
		    <td><xsl:value-of select="rdfs:comment" /></td>
		</tr>
	    </xsl:for-each>
        </table>

	<br/><br/><br/><br/>

    <h2>NIEM Purposes</h2>
	<table border="3">
	    <thead style="background-color:green; color:white; ">
		<tr>
		    <th>Purpose</th>
		    <th>Definition</th>
		</tr>
	    </thead>
	    <xsl:for-each select="owl:ObjectProperty" >
		<tr>
		    <td><xsl:value-of select="@rdf:about" /></td>
		    <td><xsl:value-of select="rdfs:comment" /></td>
		</tr>
	    </xsl:for-each>
	</table>

</xsl:template>

</xsl:stylesheet>

