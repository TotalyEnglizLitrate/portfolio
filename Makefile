# SPDX-License-Identifier: MIT
# Find all .typ files in content/ that don't start with an underscore in their path
TYP_FILES := $(shell find content -name '*.typ' -not -path '*/_*')

# The Cool stuff index lists pages from _pages.typ and reads each page's title
# and summary from its index.typ, so rebuild it when any of them change.
_site/cool-stuff/index.html: content/cool-stuff/_pages.typ $(wildcard content/cool-stuff/*/index.typ)

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

# Latin Modern fonts for the resume PDF (GUST Font License). They aren't kept
# in git; they're downloaded on demand into fonts/ and verified against
# fonts.sha256, so a bad mirror or a changed file can't alter the PDF.
# Mirrors are tried in order; mirrors.ctan.org redirects to a random mirror,
# so it goes last.
CTAN_LM := fonts/lm/fonts/opentype/public/lm
FONT_MIRRORS := https://ctan.math.illinois.edu/$(CTAN_LM) \
                https://mirrors.mit.edu/CTAN/$(CTAN_LM) \
                https://mirror.las.iastate.edu/CTAN/$(CTAN_LM) \
                https://mirrors.ctan.org/$(CTAN_LM)
FONT_NAMES := lmroman12-bold lmroman8-bold lmroman8-italic lmroman8-regular \
              lmroman9-bold lmroman9-italic lmroman9-regular lmromancaps10-regular
FONT_FILES := $(addprefix fonts/,$(addsuffix .otf,$(FONT_NAMES)))

fonts/%.otf:
	@mkdir -p fonts
	@want=$$(awk -v f="$@" '$$2==f {print $$1}' fonts.sha256); \
	for base in $(FONT_MIRRORS); do \
	  echo "fetching $* from $$base"; \
	  if curl -fsSL --retry 3 --max-time 120 -o "$@.tmp" "$$base/$*.otf" \
	     && [ "$$(sha256sum "$@.tmp" | cut -d' ' -f1)" = "$$want" ]; then \
	    mv "$@.tmp" "$@" && exit 0; \
	  fi; \
	  echo "  failed, trying the next mirror" >&2; \
	done; \
	rm -f "$@.tmp"; echo "could not download $@ from any mirror" >&2; exit 1

fonts: $(FONT_FILES)

# Build the one-page resume PDF into the site assets
resume: $(FONT_FILES)
	@mkdir -p _site/assets
	typst compile --font-path fonts resume/resume.typ _site/assets/resume.pdf

# A clean rule to remove generated files
clean:
	rm -rf _site/*

.PHONY: html clean assets resume fonts
