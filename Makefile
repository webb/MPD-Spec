
ifeq ($(IEAD_TOOLS_ROOT),)
$(error Environment variable "IEAD_TOOLS_ROOT" is unset)
endif

TMP_DIR := tmp
TOKENS_DIR := tmp/tokens

BIN_DIR := $(IEAD_TOOLS_ROOT)/bin
XSDVALID := $(BIN_DIR)/xsdvalid
PROCESS_DOC = $(BIN_DIR)/process-doc

DOC_NAME = mpd-spec
DOC_SRC = $(DOC_NAME).xml
DOC_DEST_HTML = $(DOC_NAME).html

XML_PASS := $(wildcard examples/*.pass/*.xml)
XML_PASS_XSD_VALID_TOKENS := $(patsubst %,$(TOKENS_DIR)/xml-pass-xsd-valid/%,$(XML_PASS))

VALID_TOKENS := $(XML_PASS_XSD_VALID_TOKENS)



default:
	@echo Bravely doing nothing.
	@ $(MAKE) help

help:
	@echo targets:
	@echo ' ' all: generate all files
	@echo ' ' doc: regenerate the HTML
	@echo ' ' clean: clean up temporaries and junk
	@echo ' ' distclean: clean up everything that could be generated
	@echo ' ' valid: validate test instances against schemas

all: $(DOC_DEST_HTML)

$(DOC_DEST_HTML): $(DOC_SRC)
	$(PROCESS_DOC) -html -in $< -out $@
	$(RM) tmp.$(DOC_SRC).html $(DOC_SRC).xhtml


valid: $(VALID_TOKENS) conformance-report.txt

$(TOKENS_DIR)/xml-pass-xsd-valid/%: %
	$(XSDVALID) -catalog xsd/catalog.xml $<
	mkdir -p $(dir $@)
	touch $@

.PHONY: xsd-html
xsd-html: mpd-catalog.html

.PHONY: mpd-catalog.html
mpd-catalog.html: 
	mkdir -p tmp
	$(BIN_DIR)/markup-schemas -out $@ -tmp tmp -title 'MPD catalog' $(shell find xsd -type f -name '*.xsd' -print)

.PHONY: conformance-report.txt
conformance-report.txt: 
	$(HOME)/working/ndr3/bin/validate --make xsd/mpd-catalog-3.0.xsd > $@ 

.PHONY: clean
clean:
	$(RM) $(wildcard *~) $(wildcard tmp.*) 

.PHONY: distclean
distclean: clean
	$(RM) $(DOC_DEST_HTML) $(DOC_SRC).xhtml

.PHONY: doc
doc:
	$(RM) $(DOC_DEST_HTML)
	$(MAKE) $(DOC_DEST_HTML)
