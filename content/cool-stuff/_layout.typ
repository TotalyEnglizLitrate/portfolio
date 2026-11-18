// Shared layout for cool-stuff sub pages.
//   #import "../_layout.typ": cool-page
//   #show: cool-page.with(title: "My page", summary: "One line description.")
#import "../../config.typ": template
#import "../../link-icons.typ": with-icons

#let cool-page(title: none, summary: none, body) = template(
  title: title,
  {
    show: with-icons
    link("/cool-stuff/")[← Cool stuff]
    heading(level: 1, title)
    if summary != none { emph(summary) }
    body
  },
)
