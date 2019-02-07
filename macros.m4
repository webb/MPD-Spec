m4_dnl ensure this file doesn't change line numbers of resulting files
m4_changequote([[[,]]])m4_dnl
m4_changecom(,)m4_dnl
m4_dnl What version of NIEM are we trying to define IEPDs for?
m4_define(MACRO_target_NIEM_version,4.0)m4_dnl
m4_dnl What is the version of this copy of the document?
m4_define(MACRO_document_version,4.0alpha1)m4_dnl
m4_dnl What will the final version of the document be?
m4_define(MACRO_target_document_version,4.0)m4_dnl
m4_define(MACRO_document_base_uri,http://reference.niem.gov/niem/specification/model-package-description/[[[]]]MACRO_target_document_version/)m4_dnl
m4_define(MACRO_MPD_conformance_target_identifier,MACRO_document_base_uri[[[]]]#MPD)m4_dnl
m4_define(MACRO_IEPD_conformance_target_identifier,MACRO_document_base_uri[[[]]]#IEPD)m4_dnl
m4_dnl NDR stuff
m4_define(MACRO_NDR_version,4.0)m4_dnl
m4_define(MACRO_NDR_document_base_uri,http://reference.niem.gov/niem/specification/naming-and-design-rules/MACRO_NDR_version/)m4_dnl
m4_define(MACRO_NDR_EXT_conformance_target_identifier,MACRO_NDR_document_base_uri#ExtensionSchemaDocument)m4_dnl
m4_define(MACRO_NDR_REF_conformance_target_identifier,MACRO_NDR_document_base_uri#ReferenceSchemaDocument)m4_dnl
