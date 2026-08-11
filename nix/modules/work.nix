{ pkgs, ... }: {
  # Extra packages installed only on top of base, for work machines.
  environment.systemPackages = with pkgs; [
  ];
}
