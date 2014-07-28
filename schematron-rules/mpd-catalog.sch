<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

<title>Rules for an MPD catalog document (XPath2 only - does NOT cover an extended MPD catalog)</title>

<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
<ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>
<ns prefix="structures" uri="http://release.niem.gov/niem/structures/3.0/"/>

<pattern>
	<rule context="c:IEPConformanceTarget">
		<assert test="exists(@structures:id)"
		>Rule 4-42: A c:IEPConformanceTarget element MUST own a structures:id attribute.</assert>
	</rule>
</pattern>

<pattern>
	<rule context="c:SchemaDocumentSet|c:ConstraintSchemaDocumentSet">
		<assert test="c:SchemaDocument or c:XMLCatalog"
		>Rule 7-4: An element information item with a type definition validly derived from c:SchemaDocumentSetType MUST have a child element with an element declaration that is in the substitution group of c:XMLCatalog or c:SchemaDocument.</assert>
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

