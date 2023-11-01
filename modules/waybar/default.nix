{
  inputs,
  pkgs,
  ...
}:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
  waybarStyle = import ./style.nix { inherit pkgs-unstable; };
  waybarConfig = import ./config.nix { inherit pkgs-unstable; };
in
{
  home.packages = with pkgs; [
    pavucontrol
  ];
  programs.waybar = {
      enable = true;
      package = pkgs-unstable.waybar;
      style = waybarStyle;
      settings = waybarConfig;
  };
}
