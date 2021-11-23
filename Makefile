all:
	$$(nix build .#darwinConfigurations.air.system --no-link --json | jq -r '.[].outputs.out')/sw/bin/darwin-rebuild switch --flake .