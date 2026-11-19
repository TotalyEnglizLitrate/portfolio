// Shared layout for cool-stuff sub pages.
//   #import "../_layout.typ": cool-page
//   #show: cool-page.with(title: "My page", summary: "One line description.")
// Add `toc: true` to show an "On this page" index linking (#) to each section.
#import "../../config.typ": template
#import "../../link-icons.typ": with-icons

// Plain text of some content, and an anchor id made from it ("`nix run` and" -> "nix-run-and").
#let plain(c) = if type(c) == str { c } else if c.func() == text { c.text } else if c.func() == raw { c.text } else if c.has("children") { c.children.map(plain).join() } else if c.has("body") { plain(c.body) } else { " " }
#let slug(c) = lower(plain(c)).replace(regex("[^a-z0-9]+"), "-").trim("-")

#let cool-page(title: none, summary: none, toc: false, body) = template(
  title: title,
  description: summary,
  {
    show: with-icons
    link("/cool-stuff/")[← Cool stuff]
    heading(level: 1, title)
    if summary != none { emph(summary) }
    if toc {
      context html.elem("nav")[
        #html.elem("h2")[On this page]
        #html.elem("ul", attrs: (style: "list-style-type: none"))[
          #for h in query(heading.where(level: 2)) {
            html.elem("li", link("#" + slug(h.body), h.body))
          }
        ]
      ]
    }
    show heading.where(level: 2): it => html.elem("h3", attrs: (id: slug(it.body)), it.body)
    body
  },
)
