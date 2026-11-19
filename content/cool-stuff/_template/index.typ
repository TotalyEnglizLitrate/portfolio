// To add a page: copy this whole `_template/` folder to
// `content/cool-stuff/<slug>/`, set the title and summary below, write the
// page, then add the slug to `../_pages.typ`. (Folders and files starting
// with `_` are not built, so this skeleton stays hidden.)
#import "../_layout.typ": cool-page, on-this-page
// Title and summary: shown on this page and on the Cool stuff index.
#let title = "Page title"
#let summary = "One line describing this page."
#show: cool-page.with(title: title, summary: summary)

Write the page here, in normal Typst markup.

// Optional: an "On this page" index of the `==` sections, placed after the intro.
// #on-this-page()

== A section

Text, #link("https://example.com")[links] and lists all work:

- an item
- another item
