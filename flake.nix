{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      treefmtConfig = import ./treefmt.nix;

      eachSystem =
        f:
        inputs.nixpkgs.lib.genAttrs (import inputs.systems) (
          system: f inputs.nixpkgs.legacyPackages."${system}"
        );
    in
    {
      formatter = eachSystem (pkgs: inputs.treefmt-nix.lib.mkWrapper pkgs treefmtConfig);
      checks = eachSystem (pkgs: {
        formatting = (inputs.treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build.check inputs.self;
      });

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell { };
      });
    };
}
