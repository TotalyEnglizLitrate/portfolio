#import "../config.typ": template, tufted
#import "../resume/contact.typ": email, github, linkedin, name, phone
#import "../link-icons.typ": with-icons
#show: template
#show: with-icons

= Me

#let about(..rows) = html.elem(
  "table",
  attrs: (
    style: "width: 100%; border-collapse: collapse; font-size: 1.4rem; line-height: 2rem;",
  ),
  html.elem("tbody", for (k, v) in rows.pos() {
    html.elem("tr", {
      html.elem(
        "th",
        attrs: (
          style: "text-align: left; vertical-align: top; padding: 0.3rem 1.5rem 0.3rem 0; white-space: nowrap;",
        ),
        k + [:],
      )
      html.elem(
        "td",
        attrs: (style: "vertical-align: top; padding: 0.3rem 0;"),
        v,
      )
    })
  }),
)

Hi, I'm #name.text.split(" ").first(). I like building backend systems, infrastructure and developer tools, mostly in Python, Rust and Nix.

#about(
  ([Name], name),
  ([Pseudonym], [TotalyEnglizLitrate, Engliz]),
  ([Studying], [B.Tech Computer Science & Engineering (Cybersecurity)]),
  ([At], [Shiv Nadar University, Chennai]),
  (
    [Open source],
    [
      #link("https://github.com/noctalia-dev/noctalia/pulls?q=is%3Apr+is%3Amerged+author%3ATotalyEnglizLitrate")[13 merged PRs in Noctalia],
      plus #link("https://github.com/search?q=author%3ATotalyEnglizLitrate+is%3Amerged+-user%3ATotalyEnglizLitrate+-repo%3Anoctalia-dev%2Fnoctalia+-repo%3Ar-ethan18%2FSupport-Ticketing-System&type=pullrequests")[nixpkgs, stylix and other misc projects]
    ],
  ),
  (
    [Community],
    [Coding Club cybersecurity vertical (\@ SNUC), Python Discord staff],
  ),
  ([Looking for], [Summer ’27 internship]),
)

See #link("/projects/")[Projects] for what I've built, or my #link("/resume/")[resume] for the full picture.

== Experience

*Cloud infrastructure, Sandbox Labs (intern, 2026).* I helped build a platform where people launch virtual computers for hands-on labs. I made saving and restoring those computers faster, added shareable lab templates, fixed speed and security problems, and helped run it on *Kubernetes*. Built with *Go*, *PostgreSQL* and *Redis* on top of *libvirt/KVM*.

*CTF platform, Edita CTF (from 2025 till date).* I help maintain a website for CTF competitions conducted by the SNUC Coding Club, used by about *1,000 people*. I made it faster, improved UX and made answer submission safer.

== Interests

*Systems that run other systems.* I'm happiest in the layer underneath the application: virtual machines, schedulers, permissions, tooling and deployment. Sandbox Labs was the first place I got to work on that professionally, and it's what I want to keep doing.

*Reproducible environments with Nix.* I run NixOS on all my machines with a plethora of reusable modules, host metadata that allows adapting to each machine's hardware (as an example, conditional fingerprint sensor config based on availability), and custom packages. It spills into my projects too, for example, #link("https://github.com/TotalyEnglizLitrate/nixcu")[nixcu] explores what's taking up space in a Nix store closure, because I wanted an easy way to browse disk usage by packages.

*Security and breaking things on purpose.* I help run the Coding Club's cybersecurity vertical, where I've led weekly CTFs and personally conducted a workshop on reverse engineering POSIX binaries. I placed 2nd in EditaCTF 2.0 (\@ SNUC) and in the top 25 at Binary Clash 360 (\@ IITM CyStar).

*Languages, compilers and terminal tools.* I like understanding how languages work, from implementing Lox in Rust (#link("https://github.com/TotalyEnglizLitrate/rlox")[rlox]) to taking a compiler design course. I also enjoy building TUIs with Textual, such as #link("https://github.com/TotalyEnglizLitrate/foodie")[Foodie], which lets you order from swiggy/zomato, right from your terminal.

== Elsewhere

- #phone
- #email
- #linkedin
- #github
