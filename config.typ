#import "@preview/tufted:0.1.1"
#import "@preview/tufted:0.1.1": (
  make-header, template-figures, template-math, template-notes, template-refs,
)

#let site-url = "https://engliz.dev"
#let default-description = "Narendra Sampath Kumar's portfolio: resume, projects and cool stuff."

// Cache-busting: append the file's size to asset URLs, so an edited file is
// re-fetched instead of served from a browser/CDN cache.
#let versioned(path) = (
  "/" + path + "?v=" + str(read(path, encoding: none).len())
)

#let footer-style = "margin-top: 4rem; font-size: 1.1rem; opacity: 0.7;"

// Footer shown on every page. Pages excluded from the CC license (the resume)
// pass `reserved: true` to the template.
#let license-footer(reserved) = html.elem("footer", attrs: (
  style: footer-style,
))[
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


// Derived from `tufted-web` in Tufted 0.1.1
// (https://github.com/vsheg/tufted, src/tufted.typ).
// Copyright (c) 2025 Vsevolod Shegolev. MIT License; the full text is in
// THIRD_PARTY_NOTICES.md. Tufted's <head> can't be extended, so this copy adds a
// description and Open Graph / Twitter tags, which make link
// previews (WhatsApp, Signal, Discord...) show a title, description and image.
// `path` is the page's URL path, e.g. "/projects/", passed in by the Makefile
// as `--input path=...`.
#let page(
  header-links: none,
  title: "",
  lang: "en",
  css: (),
  description: default-description,
  path: sys.inputs.at("path", default: none),
  content,
) = {
  show: template-math
  show: template-refs
  show: template-notes
  show: template-figures

  set text(lang: lang)

  let meta(key, value, content) = html.elem("meta", attrs: ((key): value, content: content))
  html.html(lang: lang, {
    html.head({
      html.meta(charset: "utf-8")
      html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      html.title(title)
      html.meta(name: "description", content: description)
      meta("property", "og:type", "website")
      meta("property", "og:site_name", "Narendra S | Engliz")
      meta("property", "og:title", title)
      meta("property", "og:description", description)
      if path != none { meta("property", "og:url", site-url + path) }
      meta("property", "og:image", site-url + "/og.png")
      meta("property", "og:image:width", "1200")
      meta("property", "og:image:height", "630")
      meta("name", "twitter:card", "summary_large_image")
      for css-link in css { html.link(rel: "stylesheet", href: css-link) }
    })
    html.body({
      make-header(header-links)
      html.article(html.section(content))
    })
  })
}

// Wraps tufted's template and adds the light/dark toggle script
// (assets/theme.js, which attaches a button to the page header) and the
// license footer.
#let template(content, ..args) = {
  let named = args.named()
  let reserved = named.remove("reserved", default: false)
  page(
    ..(
      header-links: (
        "/": "Home",
        "/resume/": "Resume",
        "/projects/": "Projects",
        "/cool-stuff/": "Cool stuff",
      ),
      title: "Narendra S | Engliz",
      css: (
        "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
        "/assets/tufted.css",
        versioned("assets/custom.css"),
        versioned("assets/theme.css"),
      ),
    )
      + named,
    {
      html.elem("script", attrs: (src: versioned("assets/theme.js")))
      content
      license-footer(reserved)
    },
  )
}
