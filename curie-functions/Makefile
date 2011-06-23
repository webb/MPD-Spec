
ROOT_DIR := $(HOME)/r/datastrategy
BIN_DIR := $(ROOT_DIR)/bin
SAXON := $(BIN_DIR)/saxon

XSLEXT_XSL := $(ROOT_DIR)/lib/xsl-extension.xsl

default: curie-tests.report.txt

curie-test.xsl: curie-test.xsl.xslext $(XSLEXT_XSL)
	$(SAXON) -in $< -out $@ -xsl $(XSLEXT_XSL) --readonly

curie-functions.xsl: curie-functions.xsl.xslext $(XSLEXT_XSL)
	$(SAXON) -in $< -out $@ -xsl $(XSLEXT_XSL) --readonly

curie-tests.report.txt: curie-tests.xml curie-test.xsl curie-functions.xsl xsl-functions.xsl
	$(SAXON) -in $< -out $@ -xsl curie-test.xsl --readonly

localize:
	install -m 400 $(ROOT_DIR)/lib/xsl-functions.xsl xsl-functions.xsl
