all:
	$$(nix build --extra-experimental-features "flakes nix-command" .#darwinConfigurations.air.system --no-link --json | jq -r '.[].outputs.out')/sw/bin/darwin-rebuild switch --flake .
