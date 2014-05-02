<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

<title>Rules about MPD catalog artifacts</title>

<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
<ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
<ns prefix="c" uri="http://reference.niem.gov/niem/resource/mpd/catalog/3.0/"/>
<ns prefix="structures" uri="http://release.niem.gov/niem/structures/3.0/"/>

<pattern>
  <rule context="c:IEPConformanceTarget">
    <assert test="exists(@structures:id)"
      >Rule 4-21: A c:IEPConformanceTarget element MUST own a structures:id attribute.</assert>
</pattern>

</schema>
<!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->
