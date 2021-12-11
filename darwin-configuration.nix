{ config, pkgs, rosettaPkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    ripgrep
    sd
    tig
    direnv
    nix-direnv
    tmux
    pass
    # rosettaPkgs.agda
    (rosettaPkgs.agda.withPackages (p: [ p.standard-library ]))
    rosettaPkgs.coq
    # (rosettaPkgs.haskellPackages.callHackage "agda-language-server" "0.2.1" { })
  ];

  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowBroken = true;

  services.lorri.enable = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
