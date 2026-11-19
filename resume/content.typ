// Resume content, independent of layout.
// `resume(layout)` takes a dictionary of layout functions (see layout-pdf.typ
// and layout-html.typ) and renders the content with them. Spacing arguments
// (`before:`, `top:`, `gap`) are hints that only the PDF layout uses.
#import "contact.typ": contacts, name

#let resume(layout) = {
  let (
    header,
    section,
    subheading,
    projheading,
    items,
    sublist,
    note,
    gap,
    small,
    bar,
    LaTeX,
    approx,
  ) = layout
  [
    // ---------------- header ----------------
    #header(name, contacts)

    // ---------------- education ----------------
    #gap(0.5pt)
    #section(before: 9.5pt)[Education]
    #subheading[Shiv Nadar University][Chennai, IN][B.Tech CSE with Cybersecurity][Sept. 2024 -- May 2028]
    #note(top: 2.5pt)[*CGPA*: 8.15/10 across 4 Semesters]

    // ---------------- skills ----------------
    #section(before: 2.5pt)[Technical Skills]
    #note(top: 2pt)[
      *Languages*: *Python*, *Rust*, fish, bash, *nix*, Go, C++, Java, JavaScript/TypeScript, #LaTeX, Typst \
      *Databases*: PostgreSQL, Redis, SQLite, Supabase, Firebase/Firestore \
      *Frameworks & Libraries*: FastAPI, axum, tokio, Textual, rich, SQLAlchemy, sqlx, pgx, go-redis, React, Node.js, Next.js \
      *Tools & DevOps*: *Git*, GitHub/Codeberg, *Docker*, Kubernetes, *Linux*, *Nix(OS)*, helm, fluxcd, *uv*, *cargo*, *devbox*
    ]

    // ---------------- experience ----------------
    #section(before: 9.5pt)[Experience]
    #projheading(
      [*Sandbox Labs* #bar #emph[libvirt/KVM, Go, PostgreSQL, Redis, goose, MinIO, k8s]],
      [#link("https://sandboxlabs.in/")[Site] #bar Chennai, IN],
      [Cloud lab platform #bar Backend/Infrastructure Engineer (Intern)],
      [Feb. 2026 -- Aug. 2026],
    )
    #items(
      [Built VM snapshots as registry images: offline capture, multi-layer backing chains],
      [Shipped community scoped lab templates: role-gated export, clone-to-personal-lab, cascade cleanup],
      [Cut noVNC latency (WS keepalive, per-VM session caps); fixed libvirt provisioning & domain-XML bugs],
      [Closed a privilege-escalation gap by bounding permission grants to the caller's own rights],
      [Deployed services on Kubernetes via Helm + Flux GitOps],
    )

    // ---------------- projects ----------------
    #section(before: 5.5pt)[Projects]
    #projheading(
      [*Edita CTF* #bar #emph[TypeScript, Next.js, Supabase, cmd-ts]],
      [#link("https://github.com/FrenzyVJN/EditaCTF_CLI")[GitHub] #bar #link(
          "https://editactf.snuc.cc",
        )[Site]],
      [Co-maintainer],
      [Oct. 2025 -- Present],
    )
    #items(
      [Terminal-emulator CTF platform (Next.js, Supabase) hosting SNUC Coding Club competitions],
      [Active userbase of #approx 1000],
      [Rebuilt the in-browser CLI on cmd-ts with path tab-completion and tabulated output; added lazy file loading and bundled #box[challenge/hint] caching to cut round-trips],
      [Hardened the flag-submission API with server-side validation and error handling],
    )
    #projheading(
      [*Foodie - A unified swiggy/zomato tui* #bar #emph[Python, FastAPI, MCP, Textual]],
      [#link("https://github.com/TotalyEnglizLitrate/foodie")[GitHub]],
      [Designer/Developer],
      [Oct. 2026 -- Present],
    )
    #items(
      [Leverages Swiggy/Zomato's MCPs to provide a full fledged ordering experience],
      [Allows comparison of prices across the two providers],
      [Full ordering flow in the terminal: cart, UPI QR or cash-on-delivery payment, and order tracking, with credentials kept in the system keyring],
    )
    #projheading(
      [*Merklin* #bar #emph[Python, FastAPI, Merkle trees, cryptography, Firestore]],
      [#link("https://github.com/TotalyEnglizLitrate/merklin")[GitHub]],
      [Designer/Developer],
      [Dec. 2025 -- Jan. 2026],
    )
    #items(
      [Tamper-evident logging via a from-scratch Merkle-tree library; signed logs for non-repudiation],
      [Client package with websocket log transport, key management, and a CLI],
      [Server package with challenge generator/verifier, email alerts and authentication],
    )
    #projheading(
      [*NixOS Configuration* #bar #emph[Nix flakes, Home-Manager, Packaging]],
      [#link("https://github.com/TotalyEnglizLitrate/nix-config")[GitHub]],
      [Developer],
      [Feb. 2025 -- Present],
    )
    #items(
      [Built a flake-based NixOS/Home Manager platform for 4 machines with 20+ reusable modules],
      [Designed typed host metadata to adapt configuration to GPUs, displays, VRR, laptops, and biometrics],
      [Packaged custom software and overlays, including Neovim and PAM fingerprint authentication.],
      [Automated hardware-specific features including ROCm, IR/fingerprint login, input remapping, and virtual cameras.],
    )

    // ---------------- achievements ----------------
    #section(before: 6.5pt)[Achievements & Honours]
    #gap(2pt)
    #items(
      [*Open-source*: 13 merged PRs (features & fixes) in #link("https://github.com/noctalia-dev/noctalia")[Noctalia], a C++23 Wayland desktop shell; merged changes in nixpkgs, stylix and elephant],
      [*EditaCTF 2.0*: Placed 2nd in the flagship CTF event held by the SNUC Coding Club],
      [*Binary Clash 360 (IIT-M CyStar)*: Top 25 in prelims; bootcamp on Linux/Android binary reverse engineering, on-site CTF at IIIT-DM],
      [Completed #link("https://github.com/TotalyEnglizLitrate/Advent-of-Code")[*Advent of Code*] #link("https://github.com/TotalyEnglizLitrate/Advent-of-Code/tree/main/2025")[2025]],
      [Volunteer Staff in the Python Discord server (#link("https://www.pythondiscord.com/")[Site] #bar #link("https://discord.gg/python")[discord.gg/python])],
      [#link("https://archive.nptel.ac.in/content/noc/NOC25/SEM1/Ecertificates/106/noc25-cs13/Course/NPTEL25CS13S124320441204260818.pdf")[*Compiler Design*] #bar NPTEL - IIT Kharagpur (Apr. 2025)],
    )

    // ---------------- EAA ----------------
    #section(before: 2.5pt)[Extra Academic Activities]
    #subheading[Coding Club #bar Cybersecurity Vertical][SNU Chennai][Senior Core Member][Mar. 2025 -- Present]
    #items(
      [Helped conduct and organize various events, CTFs and workshops],
      [Personally spearheaded weekly CTFs for multiple weeks and conducted a POSIX binary reverse engineering workshop],
    )
    #subheading(
      top: 2pt,
    )[Teaching Club #bar Technical and Teaching vertical][SNU Chennai][Senior Core Member][Sept. 2025 -- Present]
    #items(
      [Co-ordinated internal technical requirements],
      [Conducted revision sessions for:
        #sublist(
          [Programming in C - theory & lab (separate)],
          [Data Structures - theory],
        )],
    )
  ]
}
