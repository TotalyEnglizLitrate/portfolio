# SPDX-License-Identifier: MIT
{
  description = "Dev shell for the portfolio site (Typst + Tufted)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          typst
          typstyle
          tinymist
          gnumake
          curl
          gawk
          python3
          wrangler
          alejandra
        ];

        # Typst and tinymist both read these, so editor diagnostics see the
        # same fonts (fonts/, filled by `make fonts`) as the build does.
        shellHook = ''
          export TYPST_FONT_PATHS="$PWD/fonts"
        '';
      };
    });
  };
}
