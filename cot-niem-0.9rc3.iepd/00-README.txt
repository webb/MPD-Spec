CoT-NIEM is a NIEM 3.0-conformant Information Exchange Package
Description (IEPD) designed to be an equivalent representation of the
information in a CoT 2.0 message. It provides illustrative examples of
several new features in NIEM 3.0.

== OUTLINE

* Design goals for the IEPD design
* Description of the NIEM 3.0 features illustrated in this IEPD
* Performance results for EXI serialization of this IEPD

== DESIGN GOALS

The design goals, in priority order, are:

1. Support lossless round-trip translation from CoT 2.0 to CoT-NIEM
   and vice versa

2. Use GML components for geospatial information (following the
   recommendations from OGC's Geo4NIEM interoperability pilot)

3. Reuse components from the NIEM core and domains

4. Design components we wish we had found in the NIEM MilOps domain

5. Provide illustrating examples of helpful NIEM features and practices

The IEPD includes components for CoT 2.0 core, plus all stable
subschemas. Of the stable subschemas:

   * Shape     is captured in nc:LocationArea
   * Track     is mof:EventMotion
   * Spatial   is mof:RelativeOrientation
   * Remarks   is mof:EventComment
   * UID       is cot:EventExternalIDList
   * Link      is cot:EventLink
   * Image     is cot:EventImage
   * Sensor    is cot:EventSensor
   * Contact   is cot:EventContact
   * Request   is cot:EventRequest
   * Flowtag   is cot:EventMessageFlowtag

== NIEM 3.0 FEATURES ILLUSTRATED

This IEPD provides illustrating examples of:

1. Proper MPD format, including the mpd-catalog.xsd file
2. Proposed new/modified components for NIEM MilOps
3. Business rules for an IEPD, and for reference schema components
4. Alternate schema set for optimized EXI serialization
5. Correct ISM and NTK markings
6. OWL taxonomies in RDF/XML format

This IEPD is distributed as a ZIP archive.  The directory structure
follows the recommendations in the MPD specification, appendix F.

The IEPD includes a "milops-future" subset schema. This schema defines
elements and types to be proposed for NIEM MilOps, connected with the
general-purpose Event element and the Cursor-on-Target-equivalent
version of that element.  This schema document is a subset schema with
cardinality established for the NIEM-CoT IEPD.

The IEPD also includes a "milops-future-ref" reference schema. For
development convenience this schema was created after the stable version
of "milops-future".  "Milops-future" is a subset of "milops-future-ref".

The CoT-NIEM <event> element is derived from the milops-future <event>.
Other similar what-where-when loose-coupler messages may also be derived
from the milops-future <event>; for example, messages in the emergency
responder domain.

This IEPD demonstrates two methods of writing Schematron business
rules. The first method is illustrated by "schematron/business-
rules.sch", which contains business rules written specifically for the
IEP class defined in this IEPD. This file is referenced in the IEP class
constraints section of the mpd-catalog file.

The second method is experimental and is illustrated by the business
rules embedded in type definitions within the "milops-future" schema;
these rules apply to all elements with those types or derived types.
Those embedded rules can be automatically contextualized into an
executable Schematron document; when this is done, the file
"schematron/schema-rules.sch" is the result.

This IEPD also demonstrates the use of an alternate schema set for
implementation purposes.  IEP conformance is defined by the "base-xsd"
schemas plus the Schematron business rules.  However, these schemas are
not optimal for Efficient XML Interchange (EXI) serialization.  The
mpd-catalog file directs Implementors to use the schemas in "exi-xsd"
when producing or consuming an EXI version of the IEPs defined in this
IEPD.  Performance results appear in the next section.

It is always possible to apply correct ISM and NTK security markings to
a properly-designed NIEM 3.0 IEP, and CoT-NIEM is no exception to this
rule. The "iep-sample/IC-examples" directory contains a set of example
IEPs with various security markings (all for test purposes only; the
esxamples are actually unclassified).  These messages were validated
against the Schematron rules for ISM v13 and NTK v10.

This IEPD includes two taxonomy specifications provided in OWL using the
RDF/XML serialization.  The file "tax-milstd-2525C-sym.owl" is an
experimental OWL taxonomy for MILSTD-2525C symbol codes.  The file
"tax-event-type-code.owl" is an OWL taxonomy for the CoT event type
code; it contains mappings from CoT codes to equivalent 2525C codes.

All of the URIs defined in this developmental IEPD are created in the
"example.com" domain.  URIs in the final released version will be
created in the appropriate domain.

=== EXI performance results

We tried EXI on two test messages: "iep1", which exercises the entire
message specification, and "iep2", which contains the minimum base
information with no details.  Resulting file sizes (in bytes):

                                large           small
                                IEP1            IEP2
                                -----           -----

CoT-NIEM IEP                    10236           2035
(.xml)   

GZIP'd IEP                       2428            736
(.gz)

EXI serialization                 711            142
(.exi)

CoT-2.0 equivalent               3211            461
(cot20.xml)

GZIP'd CoT 2.0                   1201            310
(cot20.gz)

Conclusions:

* CoT-NIEM messages are much larger than CoT-2.0 (300%-450%)
* CoT-NIEM messages in EXI are much smaller than CoT-2.0 (25%-40%)
* CoT-NIEM messages in EXI are smaller than CoT-2.0 in GZIP (61%-67%)


