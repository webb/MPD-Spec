<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Assertions from milops-future reference schema, auto-contextualized by hand.
-->
<schema 
    xmlns="http://purl.oclc.org/dsdl/schematron" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    queryBinding="xslt2">
    <ns prefix="cot" uri="http://example.com/cot-niem/0.8/"/>
    <ns prefix="mof" uri="http://example.com/milops/1.1/"/>
    <ns prefix="xls" uri="http://release.niem.gov/niem/external/ogc/xls/1.1.0/dhs-gmo/2.1.0"/>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <xsl:import-schema schema-location="../extension/milops-future.xsd" namespace="http://example.com/milops/1.1/"/>
    <xsl:import-schema schema-location="../extension/cot-niem.xsd" namespace="http://example.com/cot-niem/0.8/"/>
    <pattern>
        <rule context="element(*,mof:EllipseType)">
            <assert test="xls:Ellipse/xls:majorAxis/@uom='meter' and xls:Ellipse/xls:minorAxis/@uom='meter'">
                Elements of mof:EllipseType MUST use meters for length values.
            </assert>
            <assert test="xls:Ellipse/xls:rotation/@uom='degree'">
                Elements of mof:EllipseType MUST use degrees for angle values.
            </assert>
            <assert test="xls:Ellipse/gml:pos[ancestor-or-self::*[exists(@srsName)][1]/@srsName = 'http://metadata.ces.mil/mdr/ns/GSIP/crs/WGS84E_3D']"> 
                Elements of mof:EllipseType MUST use the WGS84 coordinate reference system. 
            </assert>
        </rule>
        <rule context="element(*,mof:LineStringType)">
            <assert test="count(gml:LineString/gml:pointProperty)+count(gml:LineString/gml:pointRep)+count(gml:LineString/gml:posList)+count(gml:LineString/gml:coordinates)=0">
                Elements of mof:LineStringType MUST use gml:pos.
            </assert>
            <assert test="gml:LineString/gml:pos[ancestor-or-self::*[exists(@srsName)][1]/@srsName = 'http://metadata.ces.mil/mdr/ns/GSIP/crs/WGS84E_3D']"> 
                Elements of mof:LineStringType MUST use the WGS84 coordinate reference system. 
            </assert>
        </rule>
        <rule context="element(*,mof:ExternalPolygonType)">
            <assert test="gml:Polygon/gml:exterior/gml:LinearRing">
                Elements of mof:ExternalPolygonType MUST use gml:exterior and gml:LinearRing.
            </assert>
            <assert test="not(gml:Polygon/gml:interior)">
                Elements of mof:ExternalPolygonType MUST NOT use gml:interior.
            </assert>
            <assert test="gml:Polygon/gml:exterior/gml:LinearRing[count(gml:pointProperty)+count(gml:pointRep)+count(gml:posList)+count(gml:coordinates)=0]">
                Elements of mof:ExternalPolygonType MUST use gml:pos.
            </assert>
            <assert test="gml:Polygon/gml:exterior/gml:LinearRing/gml:pos[ancestor-or-self::*[exists(@srsName)][1]/@srsName = 'http://metadata.ces.mil/mdr/ns/GSIP/crs/WGS84E_3D']"> 
                Elements of mof:ExternalPolygonType MUST use the WGS84 coordinate reference system. 
            </assert>
        </rule>
        <rule context="element(*,mof:LocationPointType)">
            <assert test="gml:Point/gml:pos">
                Elements of mof:LocationPointType MUST use gml:pos.
            </assert>
            <assert test="gml:Point/*[ancestor-or-self::*[exists(@srsName)][1]/@srsName = 'http://metadata.ces.mil/mdr/ns/GSIP/crs/WGS84E_3D']">
                Elements of mof:LocationPointType MUST use the WGS84 coordinate reference system.
            </assert>
        </rule>
    </pattern>
</schema>