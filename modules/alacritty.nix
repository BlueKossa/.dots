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
        padding = {
          x = 10;
          y = 10;
        };
      };

      env = {
        TERM = "xterm-256color";
      };
    };
  };
}
