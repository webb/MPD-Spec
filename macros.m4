m4_dnl ensure this file doesn't change line numbers of resulting files
m4_changequote([[[,]]])m4_dnl
m4_changecom(,)m4_dnl
m4_dnl What will the final version of the document be?
m4_define(MACRO_target_document_version,[[[4.0]]])m4_dnl
m4_dnl What is the version of this copy of the document?
m4_define(MACRO_document_version,[[[MACRO_target_document_version[[[]]]alpha2]]])m4_dnl
m4_define(MACRO_document_base_uri,[[[http://reference.niem.gov/niem/specification/iepd/[[[]]]MACRO_target_document_version/]]])m4_dnl
m4_define(MACRO_namespace_iepd_catalog,[[[http://reference.niem.gov/niem/resource/iepd/catalog/MACRO_target_document_version/]]])m4_dnl
m4_define(MACRO_IEPD_conformance_target_identifier,[[[MACRO_document_base_uri[[[]]]#IEPD]]])m4_dnl
m4_define(MACRO_IEPD_catalog_xsd_name,[[[iepd-catalog.xsd]]])m4_dnl
m4_dnl =============================================================================
m4_dnl begin NDR stuff
m4_define(MACRO_NDR_version,[[[4.0]]])m4_dnl
m4_define(MACRO_NDR_document_base_uri,http://reference.niem.gov/niem/specification/naming-and-design-rules/MACRO_NDR_version/)m4_dnl
m4_define(MACRO_NDR_EXT_conformance_target_identifier,MACRO_NDR_document_base_uri#ExtensionSchemaDocument)m4_dnl
m4_define(MACRO_NDR_REF_conformance_target_identifier,MACRO_NDR_document_base_uri#ReferenceSchemaDocument)m4_dnl
m4_dnl end NDR stuff
m4_dnl =============================================================================
m4_dnl begin NIEM namespaces for NIEM 4.1
m4_define(MACRO_namespace_nc,http://release.niem.gov/niem/niem-core/4.0/)m4_dnl
m4_define(MACRO_namespace_appinfo,http://release.niem.gov/niem/appinfo/4.0/)m4_dnl
m4_define(MACRO_namespace_structures,http://release.niem.gov/niem/structures/4.0/)m4_dnl
m4_dnl temporary macros to resolve to new macros FIXME
m4_define(MACRO_namespace_mpd_catalog,MACRO_namespace_iepd_catalog)m4_dnl
m4_define(MACRO_MPD_conformance_target_identifier,MACRO_IEPD_conformance_target_identifier)m4_dnl
m4_define(MACRO_MPD_catalog_xsd_name,MACRO_IEPD_catalog_xsd_name)m4_dnl
