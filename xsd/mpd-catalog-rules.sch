<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns="http://purl.oclc.org/dsdl/schematron">

<title>Assertions about MPD Catalogs</title>

<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>
<ns prefix="xml-catalog" uri="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>
<ns prefix="structures" uri="http://release.niem.gov/niem/structures/3.0/"/>

<pattern>
  <rule context="/">
    <assert test="c:Catalog"
            >An MPD catalog must have document element c:Catalog.</assert>
  </rule>
</pattern>

<pattern>
  <rule context="c:MPD">
    <assert test="c:ReadMe">A c:MPD MUST have a c:ReadMe.</assert>
  </rule>
  <rule context="c:MPD">
    <assert test="c:MPDChangeLog">A c:MPD MUST have a c:MPDChangeLog.</assert>
  </rule>
</pattern>

<pattern>
  <rule context="*[@c:xmlCatalogURI]">
    <let name="uri" value="resolve-uri(@c:xmlCatalogURI, base-uri(.))"/>
    <assert test="doc-available($uri)"
            >An attribute c:xmlCatalogURI MUST resolve to an XML document.</assert>
    <assert test="not(doc-available($uri))
                  or doc($uri)/xml-catalog:catalog"
            >An attribute c:xmlCatalogURI MUST resolve to an XML catalog.</assert>
  </rule>
</pattern>

<pattern>
  <rule context="c:IEPConformanceTarget">
    <assert test="exists(@structures:id)"
            >An IEP conformance target MUST have an ID.</assert>
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
