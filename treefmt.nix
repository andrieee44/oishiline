{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    stylua.enable = true;

    nixfmt = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
    };
  };

  settings = {
    formatter = {
      nixfmt.options = [ "-s" ];

      stylua.options = [
        "--syntax"
        "Lua52"
      ];
    };

    global.excludes = [
      "LICENSE"
      ".direnv"
      ".envrc"
    ];
  };
}
