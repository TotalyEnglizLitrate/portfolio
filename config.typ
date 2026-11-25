#import "@preview/tufted:0.1.1"
#import "@preview/tufted:0.1.1": (
  make-header, template-figures, template-math, template-notes, template-refs,
)

#import "resume/contact.typ": github, linkedin, name

#let site-url = "https://engliz.dev"
#let default-description = name.text + "'s portfolio: resume, projects and cool stuff."

// Short form of the name for titles: the first word plus the initial of the
// second ("Narendra Sampath Kumar" -> "Narendra S").
#let short-name = {
  let parts = name.text.split(" ")
  if parts.len() > 1 { parts.first() + " " + parts.at(1).first() } else { parts.first() }
}

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
    © 2026 #name.text. All rights reserved. This page is excluded
    from the site's license.
  ] else [
    © 2026 #name.text. Licensed under
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
// as `--input path=...`. `noindex` keeps a page out of search results (404).
// `json-ld` is an optional dictionary embedded as schema.org structured data.
#let page(
  header-links: none,
  title: "",
  lang: "en",
  css: (),
  description: default-description,
  path: sys.inputs.at("path", default: none),
  noindex: false,
  json-ld: none,
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
      meta("property", "og:site_name", short-name + " | Engliz")
      meta("property", "og:title", title)
      meta("property", "og:description", description)
      if path != none and not noindex {
        meta("property", "og:url", site-url + path)
        html.link(rel: "canonical", href: site-url + path)
      }
      if noindex { html.meta(name: "robots", content: "noindex") }
      if json-ld != none {
        html.elem("script", attrs: (type: "application/ld+json"), json.encode(json-ld))
      }
      html.elem("link", attrs: (rel: "icon", href: "/favicon.ico", sizes: "32x32"))
      html.link(rel: "icon", href: "/favicon.svg", type: "image/svg+xml")
      html.elem("link", attrs: (rel: "apple-touch-icon", href: "/apple-touch-icon.png"))
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
  let title = named.remove("title", default: none)
  page(
    ..(
      header-links: (
        "/": "Home",
        "/resume/": "Resume",
        "/projects/": "Projects",
        "/cool-stuff/": "Cool stuff",
      ),
      title: if title == none { short-name + " | Engliz" } else {
        title + " | " + short-name
      },
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
      html.elem("script", attrs: (src: versioned("assets/nav.js"), defer: ""))
      content
      license-footer(reserved)
    },
  )
}
