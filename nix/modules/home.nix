{ ... }: {
  # nix-darwin's system-level user record. The home-manager bridge reads
  # `home` from here to determine the user's home directory, so it must be set.
  users.users.punitsoni.home = "/Users/punitsoni";

  # --- home-manager <-> nix-darwin integration settings ---

  # Use the same nixpkgs the system uses (from the flake), rather than a
  # separate home-manager-managed one.
  home-manager.useGlobalPkgs = true;

  # Install user packages into the system profile alongside nix-darwin's,
  # instead of a separate ~/.nix-profile.
  home-manager.useUserPackages = true;

  # Per-user home configuration. Everything under here is scoped to my user
  # and my home directory (~), applied during `darwin-rebuild switch`.
  home-manager.users.punitsoni = { pkgs, ... }: {
    # Pins home-manager's own backward-compat defaults. Set once to the version
    # you start with; don't bump casually. (String, unlike system.stateVersion.)
    home.stateVersion = "24.05";

    # Let home-manager manage itself.
    programs.home-manager.enable = true;

    # User-level packages (on my PATH, no root). Empty for now.
    home.packages = with pkgs; [ ];
  };
}
