{ pkgs, ... }: {
  # Required so nix-darwin knows which macOS user account it's managing
  # (home directory, Homebrew ownership, etc.)
  system.primaryUser = "punitsoni";

  # Bumping this triggers migration warnings between nix-darwin releases —
  # pin it to the version you first installed with, then update deliberately.
  system.stateVersion = 5;

  # Determinate manages the Nix installation via its own daemon, so nix-darwin
  # must not try to manage Nix itself (this also disables the nix.* settings).
  nix.enable = false;

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "none"; # additive only — never removes internally/manually installed packages

    brews = [
      "herdr" # terminal agent multiplexer; not in nixpkgs, so installed via brew
    ];

    casks = [
      "visual-studio-code"
    ];
  };
}
