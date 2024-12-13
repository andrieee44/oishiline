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
      stylua.options = [
        "--syntax"
        "Lua52"
      ];
      nixfmt.options = [ "-s" ];
    };

    global.excludes = [
      "LICENSE"
      ".direnv"
    ];
  };
}
