
ifeq ($(IEAD_ROOT),)
$(error variable IEAD_ROOT is unset)
endif

BIN_DIR := $(IEAD_ROOT)/C2Core/archive/trunk/bin
SAXON := $(BIN_DIR)/saxon

XSLEXT_XSL := $(IEAD_ROOT)/C2Core/archive/trunk/lib/xsl-extension.xsl

default: curie-tests.report.txt

curie-test.xsl: curie-test.xsl.xslext $(XSLEXT_XSL)
	$(SAXON) -in $< -out $@ -xsl $(XSLEXT_XSL) --readonly

curie-functions.xsl: curie-functions.xsl.xslext $(XSLEXT_XSL)
	$(SAXON) -in $< -out $@ -xsl $(XSLEXT_XSL) --readonly

curie-tests.report.txt: curie-tests.xml curie-test.xsl curie-functions.xsl xsl-functions.xsl
	$(SAXON) -in $< -out $@ -xsl curie-test.xsl --readonly

localize:
	install -m 400 $(IEAD_ROOT)/C2Core/archive/trunk/lib/xsl-functions.xsl xsl-functions.xsl

.PHONY: clean
clean:
	$(RM) curie-tests.report.txt

.PHONY: test
test: curie-tests.report.txt
	open $<
