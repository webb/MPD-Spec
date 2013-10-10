ifeq ($(IEAD_TOOLS_ROOT),)
$(error variable IEAD_TOOLS_ROOT is unset)
endif

MPDS = $(wildcard sample.*)

MPD_CATALOGS = $(MPDS:%=%/mpd-catalog.xml)

XSDS = mpd-catalog-3.0.xsd $(shell find niem -type f -name '*.xsd')

TEMP_DIR = tmp
TOKENS_DIR = $(TEMP_DIR)/tokens

VALID_TOKENS = \
	$(XSDS:%=$(TOKENS_DIR)/xmllint/%) \
	$(MPD_CATALOGS:%=$(TOKENS_DIR)/xmllint/%) \
	$(MPD_CATALOGS:%=$(TOKENS_DIR)/mpd-catalog-xml--xsd-valid/%) \
	$(MPD_CATALOGS:%=$(TOKENS_DIR)/mpd-catalog-xml--sch-valid/%) \

help:
	@echo pick a target:
	@echo ' ' valid
	@echo ' ' clean

valid: $(VALID_TOKENS)

$(TOKENS_DIR)/xmllint/%: %
	xmllint -noout $< 
	@ mkdir -p $(dir $@)
	@ touch $@

$(TOKENS_DIR)/mpd-catalog-xml--xsd-valid/%: % xml-catalog.xml $(XSDS)
	MPD=$(patsubst %/mpd-catalog.xml,%,$<); \
	EXT=$$MPD/mpd-catalog-extension-xml-catalog.xml; \
	if [[ -f $$EXT ]]; \
		then EXTCAT="-catalog $$EXT"; \
		else EXTCAT=""; \
	fi; \
	$(IEAD_TOOLS_ROOT)/bin/xsdvalid -catalog xml-catalog.xml $$EXTCAT $<
	@ mkdir -p $(dir $@)
	@ touch $@

$(TOKENS_DIR)/mpd-catalog-xml--sch-valid/%: % mpd-catalog-rules.sch
	$(IEAD_TOOLS_ROOT)/bin/schematron -schema mpd-catalog-rules.sch $<
	@ mkdir -p $(dir $@)
	@ touch $@

.PHONY: clean
clean:
	$(RM) $(shell find . -type f -name '*~') $(wildcard tmp.*) mpd-catalog-rules.sch.text.xsl
	$(RM) -r tmp
