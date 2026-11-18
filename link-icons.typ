// Link icons, shared by every page. Use as a show rule or wrapper:
//   #show: with-icons
// Every external link gets an icon matching its destination. Site-internal
// links ("/projects/", "#section") are left alone.
// ---- Link icons (Feather icon paths, MIT) ----
#let icon-paths = (
  phone: ((tag: "path", d: "M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"),),
  mail: (
    (tag: "path", d: "M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"),
    (tag: "polyline", points: "22,6 12,13 2,6"),
  ),
  github: ((tag: "path", d: "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"),),
  linkedin: (
    (tag: "path", d: "M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"),
    (tag: "rect", x: "2", y: "9", width: "4", height: "12"),
    (tag: "circle", cx: "4", cy: "4", r: "2"),
  ),
  // Simple Icons (CC0, copied from the official simple-icons package); filled, not stroked
  discord: ((tag: "path", d: "M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z"),),
  codeberg: ((tag: "path", d: "M11.955.49A12 12 0 0 0 0 12.49a12 12 0 0 0 1.832 6.373L11.838 5.928a.187.14 0 0 1 .324 0l10.006 12.935A12 12 0 0 0 24 12.49a12 12 0 0 0-12-12 12 12 0 0 0-.045 0zm.375 6.467l4.416 16.553a12 12 0 0 0 5.137-4.213z"),),
  gitlab: ((tag: "path", d: "m23.6004 9.5927-.0337-.0862L20.3.9814a.851.851 0 0 0-.3362-.405.8748.8748 0 0 0-.9997.0539.8748.8748 0 0 0-.29.4399l-2.2055 6.748H7.5375l-2.2057-6.748a.8573.8573 0 0 0-.29-.4412.8748.8748 0 0 0-.9997-.0537.8585.8585 0 0 0-.3362.4049L.4332 9.5015l-.0325.0862a6.0657 6.0657 0 0 0 2.0119 7.0105l.0113.0087.03.0213 4.976 3.7264 2.462 1.8633 1.4995 1.1321a1.0085 1.0085 0 0 0 1.2197 0l1.4995-1.1321 2.4619-1.8633 5.006-3.7489.0125-.01a6.0682 6.0682 0 0 0 2.0094-7.003z"),),
  sourcehut: ((tag: "path", d: "M12 0C5.371 0 0 5.371 0 12s5.371 12 12 12 12-5.371 12-12S18.629 0 12 0Zm0 21.677A9.675 9.675 0 0 1 2.323 12 9.675 9.675 0 0 1 12 2.323 9.675 9.675 0 0 1 21.677 12 9.675 9.675 0 0 1 12 21.677Z"),),
  link: (
    (tag: "path", d: "M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"),
    (tag: "path", d: "M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"),
  ),
)

// Brand icons are filled shapes; the generic ones are stroked outlines.
#let filled-kinds = ("discord", "codeberg", "gitlab", "sourcehut")

#let icon-kind(dest) = {
  if type(dest) != str { "link" }
  else if dest.starts-with("tel:") { "phone" }
  else if dest.starts-with("mailto:") { "mail" }
  else if dest.contains("github.com") { "github" }
  else if dest.contains("codeberg.org") { "codeberg" }
  else if dest.contains("gitlab.") { "gitlab" }
  else if dest.contains("://sr.ht") or dest.contains(".sr.ht") { "sourcehut" }
  else if dest.starts-with("https://discord.gg/") or dest.starts-with("https://discord.com/") { "discord" }
  else if dest.contains("linkedin.com") { "linkedin" }
  else { "link" }
}

#let icon(kind) = html.elem("svg", attrs: (
  xmlns: "http://www.w3.org/2000/svg",
  viewBox: "0 0 24 24",
  width: "1em",
  height: "1em",
  fill: if kind in filled-kinds { "currentColor" } else { "none" },
  stroke: if kind in filled-kinds { "none" } else { "currentColor" },
  "stroke-width": "2",
  "stroke-linecap": "round",
  "stroke-linejoin": "round",
  "aria-hidden": "true",
  style: "vertical-align: -0.125em; margin-right: 0.35em;",
), {
  for (tag: tag, ..attrs) in icon-paths.at(kind) {
    html.elem(tag, attrs: attrs)
  }
})

/// For GitHub/LinkedIn/Discord links whose visible text is "domain/slug",
/// show only "/slug" (the icon already says which site it is).
#let strip-domain(kind, body) = {
  if kind in ("github", "linkedin", "discord", "codeberg", "gitlab", "sourcehut") and body.has("text") {
    let t = body.text
    let domains = ("github.com/", "linkedin.com/", "discord.gg/", "discord.com/", "codeberg.org/", "gitlab.com/", "sr.ht/", "git.sr.ht/")
    if domains.any(d => t.starts-with(d)) { "/" + t.split("/").filter(x => x != "").last() } else { body }
  } else { body }
}

#let site-names = (github: "GitHub", linkedin: "LinkedIn", discord: "Discord", codeberg: "Codeberg", gitlab: "GitLab", sourcehut: "SourceHut")

/// Give every external link an icon matching its destination.
#let with-icons(body) = {
  // Emit a raw <a> instead of `link`, so this rule doesn't recurse.
  show link: it => if type(it.dest) == str and not it.dest.starts-with("/") and not it.dest.starts-with("#") {
    html.elem("a", attrs: (href: it.dest, style: "white-space: nowrap;"), {
      let kind = icon-kind(it.dest)
      icon(kind)
      let shown = strip-domain(kind, it.body)
      // The icon is invisible to text browsers and screen readers, so name
      // the site in visually-hidden text (inline style, no CSS file needed).
      if shown != it.body {
        html.elem("span", attrs: (style: "position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap;"))[#site-names.at(kind): ]
      }
      shown
    })
  } else { it }
  body
}
