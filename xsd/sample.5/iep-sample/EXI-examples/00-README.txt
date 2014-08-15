A note about schema assembly for EXI serialization

NIEM 3.0 designers can use the <EXIXMLCatalog> element in the
mpd-catalog file to specify the exact schema for EXI serialization.
That element provides a starting schema document and an XML Catalog
file.  Load that schema document, resolve every import/include according
to the catalog, and you will have the correct schema.  Presto!

Alas, the EXI serialization tools do not yet have built-in support for
XML Catalog resolution.  In order to obtain the EXI test results in this
directory, we had to adopt a work-around:

1. We created "exi-xsd/exi-schemas.xsd" to load the schema documents
   that catalog-aware resolution would load.

2. We replaced "base-xsd/niem/external/ogc/gml/3.2.1/gml.xsd" with a
   hard link to "exi-xsd/gml.xsd".

This results in the schema we want, the same schema that we would get
via catalog-aware resolution.

The EXI files in this directory were produced with AgileDelta's EFX v5.0
command-line interface, as follows:

  efx.sh -strict -schema ../../exi-xsd/exi-schemas.xsd iep1.xml -o iep1.exi
  efx.sh -strict -schema ../../exi-xsd/exi-schemas.xsd iep2.xml -o iep2.exi

