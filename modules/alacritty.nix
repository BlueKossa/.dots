{
  inputs,
  ...
}:
let
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "UbuntuMono Nerd Font Mono";
        };

        size = 12;
      };

      window = {
        dynamic_padding = true;
        decorations = "none";
      };

      env = {
        TERM = "xterm-256color";
      };
    };
  };
}
