#import "../_layout.typ": cool-page
// Title and summary: shown on this page and on the Cool stuff index.
#let title = "Bet you didn't know ..."
#let summary = "Underrated tools/tidbits of information that I feel more people should know of"
#show: cool-page.with(title: title, summary: summary)

Tools and tricks that deserve more attention than they get. A lot of them turned up while working on my NixOS configuration and my own projects.

== systemd-inhibit

#link("https://www.freedesktop.org/software/systemd/man/latest/systemd-inhibit.html")[`systemd-inhibit`] runs a command and stops the machine from sleeping, idling or shutting down until that command exits. It's perfect for a long download, a big build or a copy to a slow disk, with no need to change your power settings and then remember to change them back.

```sh
systemd-inhibit --what=sleep:idle --why="long build" make
systemd-inhibit --list   # see what is currently being held, and by whom
```

== kexec

#link("https://man7.org/linux/man-pages/man8/kexec.8.html")[`kexec`] boots a new kernel straight from the running one, skipping the firmware and the bootloader. Reboots get much faster on machines with a slow POST. Load a kernel, then jump into it:

```sh
sudo kexec -l /path/to/vmlinuz --initrd=/path/to/initrd.img --reuse-cmdline
sudo systemctl kexec
```

== Reboot into another OS, once

If you use systemd-boot on a dual/multi-boot machine, `systemctl reboot --boot-loader-entry=<entry>` restarts straight into a chosen boot entry, just for that one boot. My desktop shell's power menu has a "Reboot to Windows" button that runs exactly this, so I never have to catch the boot menu in time. `systemctl reboot --boot-loader-entry=help` lists the entries available, and the default stays untouched.

== `nix run` and `nix shell`

You almost never need to install a program just to try it. `nix run` runs a package straight from a flake, and `nix shell` drops you into a shell with a few packages on the `PATH`. Neither installs anything permanently, and the next `nix store gc` cleans them up.

```sh
nix run nixpkgs#cowsay -- hello
nix shell nixpkgs#ffmpeg nixpkgs#yt-dlp
nix run github:TotalyEnglizLitrate/nixcu
```

== tack

#link("https://github.com/manic-systems/tack")[tack] keeps flake-style pins in plain TOML and fetches them lazily, so you only download the inputs a build actually needs. Pins can follow each other like flake inputs, which keeps everything on one nixpkgs. There's a little more about it on the #link("/cool-stuff/tools/")[tools page].

== Gaze

#link("https://github.com/GunduLabs/gaze")[Gaze] from Gundu Labs is facial authentication for Linux. It recognises faces on the device, supports infrared cameras and has liveness checks against photo spoofing. It plugs into PAM, so it can unlock `sudo`, the login screen and the lock screen. Keep your normal password login as a fallback, as the project itself recommends.

== qalc

#link("https://github.com/Qalculate/libqalculate")[qalc] is the command-line version of Qalculate!, a calculator that understands units, currencies and plain-English-ish expressions, so conversions are just typing what you mean. It is faster than a search engine and works offline.

```text
❯ qalc
> 72 kg to lb

  72 kilograms = 158 lb + (531848864/45359237) oz ≈ 158 lb + 11.72526037 oz

> 255 to hex

  255 = 0xFF

> (31.5 GiB) / (4 MB/s) to min

  (31.5 gibibytes) / (4 megabytes/second) =
  140 min + (870576/15625) s =
  140 min + 55.716864 s
```

== The Python interpreter as a scratchpad

A bare `python3` prompt is a great tool for all the small, mundane questions: how long is the key I just copied, what is this number in binary, how many people actually registered for the event? No script, no spreadsheet, and the answer is one line away.

```python
>>> len("AKIAIOSFODNN7EXAMPLE")
20
>>> bin(1337)
'0b10100111001'
>>> import csv
>>> rows = list(csv.DictReader(open("registrations.csv")))
>>> len({r["email"] for r in rows})   # unique sign-ups
```

I use it for events too: deduplicating, filtering and cross-checking registration data takes a few lines in the REPL.

== bass

#link("https://github.com/edc/bass")[bass] lets fish use utilities that only ship as bash scripts, such as environment setup scripts. It runs the script in bash, notices which environment variables changed, and replays those changes in fish. No rewriting required.

```fish
bass source some-bash-setup.sh
```
