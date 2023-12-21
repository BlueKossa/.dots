{ inputs, config, pkgs, unstable, ... }:

let
  p10kTheme = "$HOME/.config/zsh/.p10k.zsh";

  dotRoot = "/home/bluecore/.dots";
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
  };
  home.shellAliases = {
      dev = "nix develop --command zsh";
      dev-setup = "echo 'use flake' >> .envrc && direnv allow";
      screen = ''grim -g "$(slurp)" - | wl-copy'';
      home = "home-manager $@ --flake ${dotRoot}";
      system = "sudo nixos-rebuild $@ --flake ${dotRoot}";
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
        wp=$(cat $HOME/.cache/current_wallpaper)
        wal -q -i "$HOME/.dots/wallpapers/$wp"
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
        # Plugins
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'niksingh710/minimal-tmux-status'
        run -b '~/.dots/dots/tmux/plugins/tpm/tpm'
        '';
    };
  };

  # https://github.com/nix-community/home-manager/issues/2942
  

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
    unstable.xwaylandvideobridge
    pamixer
    grim
    slurp
    wl-clipboard
    pywal
    obs-studio
    wlr-randr
    gimp
    expect
    ripgrep
    # Terminal shit
    alacritty
    tmux
    wezterm
    # Editors
    unstable.neovim
    
    # Programming
    # Zig
    unstable.zig
    zls
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
      playsound
    ]))

    # C / Other
    openssl
    pkg-config
    cmake
    alsa-lib
    gdb

    

    # Music / Sound
    spotify
    playerctl
    mpg123
    ffmpeg-full

    # Gaming
    steam

    # Latex
    zathura
    texlive.combined.scheme-medium

    # Fonts
    (unstable.nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    inputs.fonts.packages.x86_64-linux.monaspace
  ];
}
