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
    # --- core CLI ---
    git
    neovim
    ripgrep
    fd
    bat
    lsd
    tree
    fzf
    jq
    wget
    tmux
    zellij
    ranger

    # --- git tooling ---
    gh
    delta # brew: git-delta
    lazygit

    # --- build / dev ---
    gnumake # brew: make
    pkgconf
    clang-tools # provides clang-format
    cppcheck
    shellcheck

    # --- language / package managers ---
    uv
    pipx
    rclone

    # --- net ---
    autossh
    mosh

    # --- media ---
    ffmpeg

    # --- text / misc ---
    gawk
    recode
    cowsay
    lolcat
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "none"; # additive only — never removes internally/manually installed packages

    taps = [
      "nikitabobko/tap" # aerospace
    ];

    brews = [
      "herdr" # terminal agent multiplexer; not in nixpkgs, so installed via brew
    ];

    casks = [
      # apps
      "aerospace"
      "finicky"
      "ghostty"
      "mos"
      "visual-studio-code"
      # "wezterm"
      # fonts
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-symbols-only-nerd-font"
    ];
  };
}
