
ifeq ($(IEAD_TOOLS_ROOT),)
$(error Environment variable "IEAD_TOOLS_ROOT" is unset)
endif

TMP_DIR := tmp
TOKENS_DIR := tmp/tokens

BIN_DIR := $(IEAD_TOOLS_ROOT)/bin
XSDVALID := $(BIN_DIR)/xsdvalid

XML_PASS := $(wildcard examples/*.pass/*.xml)
XML_PASS_XSD_VALID_TOKENS := $(patsubst %,$(TOKENS_DIR)/xml-pass-xsd-valid/%,$(XML_PASS))

VALID_TOKENS := $(XML_PASS_XSD_VALID_TOKENS)

default:
	@echo Bravely doing nothing.

help:
	@echo valid: validate everything

valid: $(VALID_TOKENS) conformance-report.txt

$(TOKENS_DIR)/xml-pass-xsd-valid/%: %
	$(XSDVALID) -catalog xsd/catalog.xml $<
	mkdir -p $(dir $@)
	touch $@

.PHONY: html
html: mpd-catalog.html

.PHONY: mpd-catalog.html
mpd-catalog.html: 
	mkdir -p tmp
	$(BIN_DIR)/markup-schemas -out $@ -tmp tmp -title 'MPD catalog' $(shell find xsd -type f -name '*.xsd' -print)

.PHONY: conformance-report.txt
conformance-report.txt: 
	$(HOME)/working/ndr3/bin/validate --make xsd/mpd-catalog-3.0.xsd > $@ 
