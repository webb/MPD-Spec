<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns uri="http://example.com/cot-niem/0.8/" prefix="cot"/>
    <ns uri="http://example.com/milops/1.1/" prefix="mof"/>
    <ns uri="http://release.niem.gov/niem/niem-core/3.0/" prefix="nc"/>
    <ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <ns uri="http://release.niem.gov/niem/external/ogc/xls/1.1.0/dhs-gmo/2.1.0" prefix="xls"/>
    <pattern>
        <rule context="nc:DateTime">
            <assert test="ends-with(text(), 'Z')">nc:DateTime MUST use the Zulu timezone.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="nc:LocationArea">
            <assert test="cot:LocationEllipse or cot:LocationLineString or cot:LocationExternalPolygon or cot:LocationDXFShape">
                The child of nc:LocationArea MUST be one of cot:LocationEllipse, cot:LocationLineString, cot:LocationExternalPolygon, 
                cot:LocationDXFShape.
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="mof:EventLocation">
            <assert test="mof:LocationCylinder">
                mof:EventLocation MUST include mof:LocationCylinder.
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="mof:LocationCylinder">
            <assert test="mof:LocationCreationCode">
                mof:LocationCreationCode MUST appear within mof:LocationCylinder.
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="cot:Event">
            <let name="atree"  value="starts-with(cot:EventTypeCode,'ATOM.')"/>
            <let name="code"   value="cot:EventStandardIdentityCode"/>
            <let name="sidct"  value="count(cot:EventStandardIdentityCode)"/>
            <assert test="$atree = ($sidct>=1)">
                cot:EventStandardIdentityCode MUST appear IF AND ONLY IF EventType is in the ATOM subtree.
            </assert>
            <assert test="not($code='FAKER' or $code='JOKER') or cot:EventOPEXCode='EXERCISE'">
                MUST NOT use StandardIdentityCodes JOKER or FAKER unless OPEXCode is EXERCISE. 
            </assert>
        </rule>
    </pattern>
</schema>