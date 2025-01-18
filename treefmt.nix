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
        "LuaJit"
      ];
    };

    global.excludes = [
      "LICENSE"
      ".direnv"
      ".envrc"
      "oishiline.3"
    ];
  };
}
