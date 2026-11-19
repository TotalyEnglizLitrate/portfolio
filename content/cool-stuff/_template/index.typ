// To add a page: copy this whole `_template/` folder to
// `content/cool-stuff/<slug>/`, set the title and summary below, write the
// page, then add the slug to `../_pages.typ`. (Folders and files starting
// with `_` are not built, so this skeleton stays hidden.)
#import "../_layout.typ": cool-page
// Title and summary: shown on this page and on the Cool stuff index.
#let title = "Page title"
#let summary = "One line describing this page."
// Set toc to true to add an "On this page" index linking to each `==` section.
#show: cool-page.with(title: title, summary: summary, toc: false)

Write the page here, in normal Typst markup.

== A section

Text, #link("https://example.com")[links] and lists all work:

- an item
- another item
