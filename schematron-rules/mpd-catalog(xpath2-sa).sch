<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron"

<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
<ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>
<ns prefix="structures" uri="http://release.niem.gov/niem/structures/3.0/"/>


<title>Rule for an MPD catalog document (Requires XPath2 schema aware app; covers an extended MPD catalog)</title>

<pattern>
	<rule context="element(*,c:SchemaDocumentSetType)">
		<assert test="schema-element(c:SchemaDocument) or schema-element(c:XMLCatalog)"
		>Rule ###: An element information item with a type definition validly derived from c:SchemaDocumentSetType MUST have a child element with an element declaration that is in the substitution group of c:XMLCatalog or c:SchemaDocument.</assert>
	</rule>
</pattern>


</schema>


<!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->

