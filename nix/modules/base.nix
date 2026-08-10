{ pkgs, ... }: {
  # Required so nix-darwin knows which macOS user account it's managing
  # (home directory, Homebrew ownership, etc.)
  system.primaryUser = "punitsoni";

  # Bumping this triggers migration warnings between nix-darwin releases —
  # pin it to the version you first installed with, then update deliberately.
  system.stateVersion = 5;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
}
