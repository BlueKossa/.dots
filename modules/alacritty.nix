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
          family = "MonaspiceKr NF";
        };

        size = 10.;
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
