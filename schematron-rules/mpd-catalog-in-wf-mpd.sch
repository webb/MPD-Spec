<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">
   xmlns:lf="http://niem.gtri.gatech.edu/local-functions/2014-04-30-1349">

<title>Rules about an MPD catalog document in a well-formed MPD</title>

<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
<ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>
<ns prefix="structures" uri="http://release.niem.gov/niem/structures/3.0/"/>
<ns prefix="xmlcatalog" uri="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>>
<ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>

<xsl:function name="lf:has-effective-conformance-target-identifier" as="xs:boolean">
  <xsl:param name="context" as="element()"/>
  <xsl:param name="match" as="xs:anyURI"/>
  <xsl:variable name="effective-conformance-targets-attribute" 
            as="attribute()?"
            select="(root($context)//*[exists(@ct:conformanceTargets)])[1]/@ct:conformanceTargets"/>
  <xsl:sequence select="if (empty($effective-conformance-targets-attribute))
                    then false()
                    else some $effective-conformance-target-string
                         in tokenize(normalize-space(string($effective-conformance-targets-attribute)), ' ')
                         satisfies (
                           $effective-conformance-target-string castable as xs:anyURI
                           and xs:anyURI($effective-conformance-target-string) = $match)"/>
</xsl:function>


<pattern>
  <rule context="c:*[exists(@c:pathURI)]">
    <assert test="unparsed-text-available(resolve-uri(@c:pathURI, base-uri(.)))"
      >Rule 5-2: The value of a c:pathURI attribute MUST resolve to a resource.</assert>
</pattern>

<pattern>
  <rule context="c:XMLCatalog[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/xmlcatalog:catalog)"
      >Rule 5-3: The value of a c:pathURI attribute owned by an element c:XMLCatalog MUST resolve to an XML catalog document.</assert>
</pattern>

<pattern>
  <rule context="c:IEPSampleXMLDocument[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies
                    doc-available($uri)"
      >Rule 5-6: The value of a c:pathURI attribute owned by an element c:IEPSampleXMLDocument MUST resolve to an XML document.</assert>
</pattern>

<pattern>
  <rule context="c:ExternalSchemaDocument[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/xs:schema)"
      >Rule 5-8: The value of a c:pathURI attribute owned by an element c:ExternalSchemaDocument MUST resolve to an XML schema document.</assert>
</pattern>

<pattern>
  <rule context="c:ReferenceSchemaDocument[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/xs:schema
                    and lf:has-effective-conformance-target-identifier(doc($uri)/xs:schema,
                            'http://reference.niem.gov/niem/specification/naming-and-design-rules/3.0/#ReferenceSchemaDocument'))"
      >Rule 5-9: The value of a c:pathURI attribute owned by an element c:ReferenceSchemaDocument MUST resolve to a NIEM reference schema document.</assert>
</pattern>

<pattern>
  <rule context="c:ExtensionSchemaDocument[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/xs:schema
                    and lf:has-effective-conformance-target-identifier(doc($uri)/xs:schema,
                            'http://reference.niem.gov/niem/specification/naming-and-design-rules/3.0/#ExtensionSchemaDocument'))"
      >Rule 5-10: The value of a c:pathURI attribute owned by an element c:ExtensionSchemaDocument MUST resolve to a NIEM extension schema document.</assert>
</pattern>

<pattern>
  <rule context="c:SubsetSchemaDocument[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/xs:schema)"
      >Rule 5-11: The value of a c:pathURI attribute owned by an element c:SubsetSchemaDocument MUST resolve to an XML schema document.</assert>
</pattern>

<pattern>
  <rule context="c:SchematronSchema[exists(@c:pathURI)]">
    <assert test="some $uri in resolve-uri(@c:pathURI, base-uri(.)) satisfies (
                    doc-available($uri)
                    and doc($uri)/sch:schema)"
      >Rule 5-13: The value of a c:pathURI attribute owned by an element c:SchematronSchema MUST resolve to a Schematron schema.</assert>
</pattern>

</schema>
<!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->
