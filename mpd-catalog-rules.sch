<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

<title>Assertions about MPD Catalogs</title>

<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>

<pattern>
  <rule context="/*">
    <assert test="self::c:Catalog"
       >An MPD Catalog must have document element of c:Catalog</assert>
  </rule>
</pattern>

<pattern>
  <rule context="xs:MPD[@c:mpdClassCode = ('iepd', 'eiem')]">
    <assert test="count(c:BaseSchemaDocSet) = 1"
       >An MPD that is an IEPD or EIEM MUST have exactly one base schema document set.</assert>
  </rule>
</pattern>

<!-- add: consistency of @c:pathID of a fileset with the pathID of its
children: the pathID of a child MUST start with the pathID of the
parent.  AND anything with a pathID of the parent MUST occur as a
descendant of the parent. -->

</schema>
<!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->
