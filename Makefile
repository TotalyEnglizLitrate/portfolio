# Find all .typ files in content/ that don't start with an underscore in their path
TYP_FILES := $(shell find content -name '*.typ' -not -path '*/_*')

# Generate corresponding HTML file paths in _site/
HTML_FILES := $(patsubst content/%.typ,_site/%.html,$(TYP_FILES))

# The main target 'html' depends on all generated HTML files and assets
html: $(HTML_FILES) assets resume

# Pattern rule to compile .typ files to .html files
# $< is the first prerequisite (the .typ file)
# $@ is the target (the .html file)
# $(@D) is the directory part of the target
_site/%.html: content/%.typ
	@mkdir -p $(@D)
	typst compile --root .. --features html --format html $< $@
	@# Tufte emits the nav links with no whitespace between them, so text browsers
	@# (lynx, w3m) run them together; add a space (invisible in the flex layout).
	@sed -i 's#</a><a href#</a> <a href#g' $@

assets:
	@mkdir -p _site/assets
	@cp -r assets/* _site/assets/
	@# Root-level files (favicon.ico etc.) that browsers look for at /
	@cp -r static/* _site/

# Latin Modern fonts for the resume PDF (GUST Font License) downloaded on demand into fonts/ (identical to the CTAN files).
FONT_URL := https://mirrors.ctan.org/fonts/lm/fonts/opentype/public/lm
FONT_NAMES := lmroman12-bold lmroman8-bold lmroman8-italic lmroman8-regular \
              lmroman9-bold lmroman9-italic lmroman9-regular lmromancaps10-regular
FONT_FILES := $(addprefix fonts/,$(addsuffix .otf,$(FONT_NAMES)))

fonts/%.otf:
	@mkdir -p fonts
	curl -fsSL --retry 3 -o $@.tmp $(FONT_URL)/$*.otf && mv $@.tmp $@

fonts: $(FONT_FILES)

# Build the one-page resume PDF into the site assets
resume: $(FONT_FILES)
	@mkdir -p _site/assets
	typst compile --font-path fonts resume/resume.typ _site/assets/resume.pdf

# A clean rule to remove generated files
clean:
	rm -rf _site/*

.PHONY: html clean assets resume fonts
