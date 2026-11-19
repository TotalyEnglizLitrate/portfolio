#import "../config.typ": template, versioned
#show: template.with(title: "Page not found")

// Behaviour of the two buttons lives in assets/lost.js
#html.elem("script", attrs: (src: versioned("assets/lost.js")))

// A plain cookie drawn for this page: a circle with a bite out of it, plus chips.
#let cookie = html.elem(
  "svg",
  attrs: (
    id: "cookie",
    class: "cookie",
    xmlns: "http://www.w3.org/2000/svg",
    viewBox: "0 0 24 24",
    fill: "none",
    stroke: "currentColor",
    "stroke-width": "1.4",
    "stroke-linecap": "round",
    "stroke-linejoin": "round",
    "aria-hidden": "true",
  ),
  {
    html.elem("path", attrs: (
      d: "M21.4 8.58A10 10 0 1 1 15.42 2.6A3.2 3.2 0 0 0 17.56 6.44A3.2 3.2 0 0 0 21.4 8.58Z",
    ))
    for (x, y) in (
      (8, 9),
      (14.5, 15.5),
      (10.5, 14),
      (7, 14.5),
      (12.5, 18.5),
      (15, 10.5),
    ) {
      html.elem("circle", attrs: (
        cx: str(x),
        cy: str(y),
        r: "1",
        fill: "currentColor",
        stroke: "none",
      ))
    }
  },
)

#html.elem("div", attrs: (class: "lost"))[
  #cookie

  = Uh oh, you seem lost!

  Here, have a cookie. I promise this one doesn't steal your data.

  #html.elem("div", attrs: (class: "lost-buttons"))[
    #html.elem("button", attrs: (
      type: "button",
      id: "take-cookie",
      class: "btn",
    ))[Take cookie]
    #html.elem("a", attrs: (href: "/", class: "btn"))[Take me home]
  ]
]
