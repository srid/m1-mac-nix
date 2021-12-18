{
  description = "Srid's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/03ec468b14067729a285c2c7cfa7b9434a04816c";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }: {
    darwinConfigurations."air" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        rosettaPkgs = import nixpkgs { system = "x86_64-darwin"; };
      };
      modules = [
        ./darwin-configuration.nix
        ./features/nix-direnv.nix
      ];
    };
  };
}

