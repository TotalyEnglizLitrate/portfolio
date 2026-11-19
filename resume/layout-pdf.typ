// PDF layout for the resume: US-letter, LaTeX-style typography.
// Content lives in content.typ; this file only decides how it looks.
// Optical-size Latin Modern (bundled in fonts/) matches LaTeX's cmr9/cmr8; falls back to New Computer Modern.
#let f9 = ("Latin Modern Roman 9", "New Computer Modern")
#let f8 = ("Latin Modern Roman 8", "New Computer Modern")

/// Page-level rules, applied with `#show: setup`.
#let setup(body) = {
  set page(paper: "us-letter", margin: (x: 0.5in, top: 0.5in, bottom: 0.4in))
  set text(
    font: f9,
    size: 9pt,
    lang: "en",
    ligatures: true,
    top-edge: 7.7pt,
    bottom-edge: -3.3pt,
  )
  set par(leading: 0pt, spacing: 0pt, justify: false)
  set block(spacing: 0pt)
  set list(marker: [•], indent: 11pt, body-indent: 2.7pt, spacing: 0.75pt)
  body
}

#let sm = 8pt
#let ind = 10.8pt
#let LaTeX = {
  [L]
  h(-0.36em)
  box(baseline: -0.0pt, move(dy: -0.2em, text(size: 0.7em)[A]))
  h(-0.15em)
  [T]
  h(-0.1667em)
  box(move(dy: 0.22em)[E])
  h(-0.125em)
  [X]
}
#let bar = $|$
#let small(body) = text(
  font: f8,
  size: sm,
  top-edge: 6.3pt,
  bottom-edge: -2.7pt,
  body,
)

#let section(title, before: 0pt) = {
  v(before)
  block(width: 100%, {
    text(
      font: ("Latin Modern Roman Caps", "New Computer Modern"),
      size: 10pt,
      top-edge: 8.4pt,
      bottom-edge: -3.6pt,
      title,
    )
    v(0pt)
    line(length: 100%, stroke: 0.4pt)
    v(2pt)
  })
}

#let subheading(a, b, c, d, top: 0.5pt) = block(
  width: 100%,
  inset: (left: ind, right: 5.2pt, top: top, bottom: 0.5pt),
  {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      row-gutter: 1pt,
      strong(a), b,
      small(emph(c)), small(emph(d)),
    )
  },
)

#let projheading(a, b, c, d) = block(
  width: 100%,
  inset: (left: ind, right: 5.2pt, top: 4.25pt, bottom: 0.5pt),
  {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      row-gutter: 2pt,
      small(a), small(b),
      small(emph(c)), small(emph(d)),
    )
  },
)

#let items(..xs) = block(inset: (left: ind), {
  set text(font: f8, size: sm, top-edge: 6.3pt, bottom-edge: -2.7pt)
  list(..xs.pos())
  v(0pt)
})

#let gap(n) = v(n)
#let approx = box[$approx$]
#let sublist(..xs) = block(inset: (left: 0pt), list(
  marker: [∗],
  indent: 9pt,
  body-indent: 4.8pt,
  ..xs.pos(),
))
#let note(top: 0pt, body) = block(inset: (left: ind, top: top), small(body))

// The PDF header also lists the personal site; the web page header does not.
#import "contact.typ": website
#let header(name, contacts) = align(center)[
  #text(
    font: ("Latin Modern Roman 12", "New Computer Modern"),
    size: 17pt,
    top-edge: 11.9pt,
    bottom-edge: -5.1pt,
    weight: "bold",
  )[#name] \
  #small[#(contacts + (website,)).join([ #bar ])]
]

#let layout = (
  header: header,
  section: section,
  subheading: subheading,
  projheading: projheading,
  items: items,
  sublist: sublist,
  note: note,
  gap: gap,
  small: small,
  bar: bar,
  LaTeX: LaTeX,
  approx: approx,
)
