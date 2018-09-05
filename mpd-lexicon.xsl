<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:owl="http://www.w3.org/2002/07/owl#" >

<xsl:output method="html"/>

<xsl:template match="/">
    <html><body>
	<xsl:apply-templates />
    </body></html>
</xsl:template>

<xsl:template match="/owl:Ontology">

    <h2>NIEM Nature/Purpose Lexicon</h2>
    <table border="3">
      <thead style="background-color:maroon; color:white; ">
        <tr>
	  <th>Nature or Purpose</th>
	  <th>Definition</th>
        </tr>
      </thead>

	<xsl:for-each select="owl:AnnotationAssertion" >
		<xsl:choose>
			<xsl:when test="owl:AbbreviatedIRI = 'owl:Thing' or owl:AnnotationProperty/@abbreviatedIRI = 'rdfs:label'" >
		</xsl:when>
		<xsl:otherwise>
			<tr>
			<td><xsl:value-of select="owl:IRI" /></td>
			<td><xsl:value-of select="owl:Literal" /></td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
    </table>

</xsl:template>

</xsl:stylesheet>

