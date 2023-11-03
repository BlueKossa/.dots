{ inputs, config, pkgs, ... }:

let
  p10kTheme = "$HOME/.config/zsh/.p10k.zsh";

  dotRoot = "/home/bluecore/.dots";
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in
{
  imports = [
    ../modules/waybar
    ../modules/alacritty.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bluecore";
  home.homeDirectory = "/home/bluecore";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  # };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bluecore/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
  home.shellAliases = {
      dev = "nix develop --command zsh";
      dev-setup = "echo 'use flake' >> .envrc && direnv allow";
      screen = ''grim -g "$(slurp)" - | wl-copy'';
      home = "home-manager $@ --flake ${dotRoot}";
      system = "nixos-rebuild $@ --flake ${dotRoot}";
  };
  home = {
    file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotRoot}/dots/nvim";
        recursive = true;
      };
      ".config/hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotRoot}/dots/hypr";
        recursive = true;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs = {
    zsh = {
      initExtra = ''
        [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
        wal -q -i "$HOME/.cache/current_wallpaper.jpg"
      '';
      enable = true;
      dotDir = ".dots/dots/zsh";
      oh-my-zsh = {
      	enable = true;
        plugins = [ "git" ];
        custom = "$HOME/.oh-my-zsh/custom";
        theme = "powerlevel10k/powerlevel10k";
      };
    };
    tmux = {
        enable = true;
        baseIndex = 1;
        escapeTime = 0;
        extraConfig = ''
        # Colors
        set -g default-terminal "screen-256color"
        set -as terminal-features ",xterm-256color:RGB"
        # Scrolling
        set -g mouse on
        '';
    };
  };

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = _: true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Misc
    git
    gh
    discord
    wget
    lorien
    dolphin
    flatpak
    fd
    ripgrep
    screenkey
    killall
    jq
    pkgs-unstable.xwaylandvideobridge
    pamixer
    grim
    slurp
    wl-clipboard
    pywal
    obs-studio
    wlr-randr
    gimp
    # Terminal shit
    alacritty
    tmux
    wezterm
    # Editors
    pkgs-unstable.neovim
    
    # Programming
    # Rust
    rustup

    # js
    nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server

    # lua
    lua
    luajitPackages.lua-lsp

    # python
    (python311.withPackages (p: with p; [
      pip
      jedi-language-server
      pycairo
      pygobject3
    ]))

    # C / Other
    libcxxabi
    libcxx
    openssl
    pkg-config
    gcc
    cmake
    alsa-lib

    

    # Music
    spotify
    playerctl

    # Fonts
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
  ];
}
