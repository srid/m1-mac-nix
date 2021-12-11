{
  description = "Srid's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/581d2d6c9cd5c289002203581d8aa0861963a933";
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

