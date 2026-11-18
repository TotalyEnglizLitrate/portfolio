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

# Build the one-page resume PDF into the site assets
resume:
	@mkdir -p _site/assets
	typst compile --font-path fonts resume/resume.typ _site/assets/resume.pdf

# A clean rule to remove generated files
clean:
	rm -rf _site/*

.PHONY: html clean assets resume
