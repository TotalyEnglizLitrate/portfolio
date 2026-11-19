#import "@preview/tufted:0.1.1"

// Cache-busting: append the file's size to asset URLs, so an edited file is
// re-fetched instead of served from a browser/CDN cache.
#let versioned(path) = "/" + path + "?v=" + str(read(path, encoding: none).len())

#let footer-style = "margin-top: 4rem; font-size: 1.1rem; opacity: 0.7;"

// Footer shown on every page. Pages excluded from the CC license (the resume)
// pass `reserved: true` to the template.
#let license-footer(reserved) = html.elem("footer", attrs: (style: footer-style))[
  #if reserved [
    © 2026 Narendra Sampath Kumar. All rights reserved. This page is excluded
    from the site's license.
  ] else [
    © 2026 Narendra Sampath Kumar. Licensed under
    #link("https://creativecommons.org/licenses/by-sa/4.0/")[CC BY-SA 4.0],
    except the resume. The Makefile, scripts and custom styles are under the
    #link("https://opensource.org/license/mit")[MIT license].
  ]
  #html.elem("div")[
    Source on #link("https://github.com/TotalyEnglizLitrate/portfolio")[GitHub].
  ]
  // Moved into the page header by assets/theme.js; stays here without JS.
  #html.elem("div", attrs: (id: "made-with"))[
    Made with #link("https://typst.app/")[Typst] and
    #link("https://typst.app/universe/package/tufted")[Tufted].
  ]
]

// Wraps tufted's template and adds the light/dark toggle script
// (assets/theme.js, which attaches a button to the page header) and the
// license footer.
#let template(content, ..args) = {
  let named = args.named()
  let reserved = named.remove("reserved", default: false)
  tufted.tufted-web(
    ..(
      header-links: (
        "/": "Home",
        "/resume/": "Resume",
        "/projects/": "Projects",
        "/cool-stuff/": "Cool stuff",
      ),
      title: "Portfolio",
      css: (
        "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
        "/assets/tufted.css",
        versioned("assets/custom.css"),
        versioned("assets/theme.css"),
      ),
    ) + named,
    {
      html.elem("script", attrs: (src: versioned("assets/theme.js")))
      content
      license-footer(reserved)
    },
  )
}
