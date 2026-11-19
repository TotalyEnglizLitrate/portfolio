#import "../_layout.typ": cool-page
// Title and summary: shown on this page and on the Cool stuff index.
#let title = "Tools I use"
#let summary = "Software, setups and workflows I rely on day to day."
#show: cool-page.with(title: title, summary: summary, toc: true)

The tools I use every day, from command-line programs to desktop tweaks. Most are set up through my NixOS configuration so every machine of mine behaves the same; the Windows section at the end covers the exception.

== In the terminal

- #link("https://fishshell.com")[fish] with #link("https://starship.rs")[starship]: the shell I use and the prompt that tells me where I am and what state the repo is in. Yes fish isn't POSIX but it is just so much friendlier (pun un-intended) to use.
- #link("https://zellij.dev")[zellij]: a terminal multiplexer with panes, tabs and sessions that survive a closed terminal, with a batteries-included approach that makes it friendlier than tmux.
- #link("https://github.com/sharkdp/bat")[bat]: `cat` with syntax highlighting, line numbers, git changes and paging. I have `cat` aliased to it.
- #link("https://github.com/eza-community/eza")[eza] and #link("https://github.com/sharkdp/fd")[fd]: modern replacements for `ls` and `find`, with icons, colours and saner defaults.
- #link("https://github.com/ajeetdsouza/zoxide")[zoxide]: a smarter `cd` that learns which directories I visit, so `z proj` jumps straight to the right folder.
- #link("https://poppler.freedesktop.org")[poppler-utils]: command-line PDF tools (`pdfunite`, `pdfseparate`, `pdftotext`, `pdftoppm`, `pdfimages`) that have completely replaced iLovePDF for me. Merging, splitting, pulling out text and images, and turning pages into pictures all work offline, with no uploading files to a website.
- #link("https://codeberg.org/wvhulle/bootvine")[bootvine]: a live tree of the jobs your system is starting during boot and shutdown, on systemd or OpenRC, so you can see what's running and what everything is waiting on instead of a stream of one line logs.

== Building things

- #link("https://neovim.io")[Neovim]: my editor, with a custom setup packaged through Nix. #link("https://zed.dev")[Zed] is my pick when I want something graphical.
- #link("https://github.com/jesseduffield/lazygit")[lazygit]: a terminal UI for git that's just as good as (if not better than) the GUIs. Staging individual lines, rebasing interactively and resolving conflicts are all a few keypresses instead of a pile of commands.
- #link("https://textual.textualize.io")[Textual]: a Python framework for building terminal apps (TUIs) with a ton of features I bet you didn't even know was possible in the terminal. I used it for #link("https://github.com/TotalyEnglizLitrate/foodie")[Foodie], #link("https://github.com/TotalyEnglizLitrate/nixcu")[nixcu] and #link("https://github.com/TotalyEnglizLitrate/anywayd")[anywayd].
- #link("https://typst.app/")[Typst]: a modern alternative to LaTeX. It builds my assignments, resume, other documents and this whole site.

== Nix

Ever run into the "works on my machine" problem? Nix is the answer: deterministic builds that work on every machine. My entire operating system is built this way, and devshells for most of my projects are also handled by it.

The latter also has the added benefit of removing the classic compiled-language headache, where a project's dependencies expect system libraries that are missing or the wrong version on your machine: the devshell pins them all, so it builds the same everywhere, regardless of what exists (or doesn't) system-wide. Anyhoo, here are a few cool Nix tools that I use.

- #link("https://github.com/maralorn/nix-output-monitor")[nix-output-monitor]: turns the wall of text from a Nix build into a live progress tree, much like bootvine.
- #link("https://github.com/nix-community/stylix")[Stylix]: themes the whole system (colours, fonts, wallpaper) from one place. Heck, it even themes my TTYs!
- #link("https://github.com/manic-systems/tack")[tack]: flake-like TOML pins for Nix, fetched lazily. Pins can follow each other like flake inputs do (`nixpkgs.follows`), and its `all_follow` setting makes every input share one nixpkgs, so builds hit the binary cache instead of rebuilding or downloading several copies.
- #link("https://github.com/nix-community/nixos-cli")[nixos-cli]: a unified replacement for the `nixos-*` tools such as `nixos-rebuild`. Mine builds through nix-output-monitor and shows what changed with nvd.
- #link("https://github.com/pyproject-nix/uv2nix")[uv2nix]: turns a uv workspace into Nix packages and devshells, so Python projects with native dependencies just work.

You can find more at the #link("https://github.com/nix-community/awesome-nix")[Awesome Nix repository].

== Desktop

- #link("https://github.com/YaLTeR/niri")[niri]: a Wayland compositor where windows sit on an infinitely scrolling strip.
- #link("https://github.com/noctalia-dev/noctalia")[Noctalia]: the desktop shell I run on top of niri, and one I contribute to.
- #link("https://gitlab.freedesktop.org/rncbc/qpwgraph")[qpwgraph]: a graph view of everything PipeWire is routing. Drag cables between apps and devices to decide where each sound goes. Extremely handy for connecting multiple devices to the same audio source.
- #link("https://sr.ht/~emersion/kanshi/")[kanshi]: automatic display layouts for Wayland. I define profiles, such as docked with the laptop screen off or the external monitor extended to the right, and it applies the matching one whenever I plug in or unplug a monitor.

== Websites

- #link("https://time.is")[time.is]: a quick time lookup where the URL is the query. Put a timezone, city or country after the slash, for example #link("https://time.is/Tokyo")[time.is/Tokyo], and you get the current time there.
- #link("https://bitwarden.garudalinux.org")[bitwarden.garudalinux.org]: a free #link("https://github.com/dani-garcia/vaultwarden")[Vaultwarden] host run by the Garuda Linux project, so you get a Bitwarden-compatible password manager without hosting anything yourself.
- #link("https://www.seedr.cc")[seedr.cc] and #link("https://torbox.app")[TorBox]: torrenting on the go. They fetch the torrent on their servers, so I can grab the finished files over a normal download from any device without running a torrent client.

== Making Windows usable

When I have to use Windows, these make it bearable.

- #link("https://github.com/ChrisTitusTech/winutil")[Chris Titus's WinUtil]: a one-script tool for debloating Windows, applying tweaks and installing apps in one go.
- #link("https://github.com/Klocman/Bulk-Crap-Uninstaller")[Bulk Crap Uninstaller]: removes unwanted programs in bulk and cleans up the leftover files and registry entries that the regular uninstaller leaves behind.
- #link("https://windhawk.net")[Windhawk]: a catalogue of small mods for customizing the Windows interface, from the taskbar to the Start menu, without replacing the shell.
- #link("https://www.autohotkey.com")[AutoHotkey]: a scripting language for remapping keys and automating anything repetitive, so Windows gets the shortcuts it should have shipped with.
