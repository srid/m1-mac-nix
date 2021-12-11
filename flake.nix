{
  description = "Srid's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/f225322e3bea8638304adfcf415cd11de99f2208";
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

