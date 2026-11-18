// Web layout for the resume. Content lives in content.typ; this file only
// decides how it looks. Spacing hints from the content are ignored here.
#let bar = [|]
#let LaTeX = [LaTeX]
#let approx = [≈]
#let small(body) = body
#let gap(n) = none

// Separators are marked with class "sep" so assets/theme.js can hide the ones
// that end up at the start or end of a wrapped line.
#let sep = html.elem("span", attrs: (class: "sep"), bar)

#let header(name, contacts) = html.elem("div", attrs: (style: "text-align: center;"))[
  = #name

  #contacts.join([ #sep ])
]

#let section(title, before: 0pt) = heading(level: 2, title)

// Two-column row: left content, right-aligned content (as in the PDF layout).
#let row(left, right) = html.elem("div", attrs: (style: "display: flex; justify-content: space-between; align-items: baseline; gap: 1em; font-size: 1.4rem; line-height: 2rem;"))[
  #html.elem("div", left)
  #html.elem("div", attrs: (style: "text-align: right; flex-shrink: 0;"), right)
]

#let subheading(a, b, c, d, top: 0pt) = {
  row(heading(level: 3, a), b)
  row(emph(c), emph(d))
}

#let projheading(a, b, c, d) = {
  row(heading(level: 3, a), b)
  row(emph(c), emph(d))
}

#let items(..xs) = list(..xs.pos())
#let sublist(..xs) = list(..xs.pos())
#let note(top: 0pt, body) = body

#let layout = (
  header: header, section: section, subheading: subheading, projheading: projheading,
  items: items, sublist: sublist, note: note, gap: gap, small: small,
  bar: bar, LaTeX: LaTeX, approx: approx,
)
