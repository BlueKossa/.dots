{ ... }:
let
  playerctlSpotify = ''
        playerctl -p spotify metadata --format '{"text": "{{markup_escape(artist)}} - {{markup_escape(title)}}", "tooltip": "{{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
in
{
    mainBar = {
        height = 30;
        layer = "top";
        position = "top";
        tray = {
            spacing = 5;
        };
        modules-left = [
          "custom/spotifyicon"
          "custom/spotifyplaying"
          "cpu"
          "memory"
          "disk"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "clock"
          "tray"
          "custom/powermenu"
        ];

        # This was mostly copied from https://github.com/linuxmobile/kaku/blob/main/home/wayland/waybar/config.nix
        "custom/spotifyicon" = {
          exec = "${playerctlSpotify}";
          format = "{icon}";
          return-type = "json";
          max-length = 40;
          on-click = "playerctl -p spotify previous";
          on-click-right = "playerctl -p spotify next";
          on-click-middle = "playerctl -p spotify play-pause";
          on-scroll-up = "playerctl -p spotify volume .1+";
          on-scroll-down = "playerctl -p spotify volume .1-";
          format-icons = {
            Playing = "<span foreground='#6791eb'>󰓇 </span>";
            Paused = "<span foreground='#cdd6f4'>󰓇 </span>";
          };
          tooltip = false;
        };
        "custom/spotifyplaying" = {
          exec = "${playerctlSpotify}";
          format = "<span>{}</span>";
          return-type = "json";
          max-length = 40;
          on-click = "playerctl -p spotify previous";
          on-click-right = "playerctl -p spotify next";
          on-click-middle = "playerctl -p spotify play-pause";
          on-scroll-up = "playerctl -p spotify volume .1+";
          on-scroll-down = "playerctl -p spotify volume .1-";
        };
        "custom/powermenu" = {
          format = "󰐥";
          on-click = "$HOME/.dots/scripts/power_menu.sh";
          tooltip = false;
        };

        memory = {
          format = " {}%";
          format-alt = " {used}/{total} GiB";
          interval = 2;
        };

        cpu = {
          format = " {usage}%";
          format-alt = " {avg_frequency} GHz";
          interval = 2;
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          format-alt = "󰋊 {used}/{total} GiB";
          interval = 30;
          path = "/";
        };
        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-muted = "";
          format-source = "<span foreground='#00ff00'></span>";
          format-source-muted = "<span foreground='#ff0000'></span>";
          format-icons = {default = ["" "" ""];};
          scroll-step = 5;
          on-click-right = "pavucontrol";
          tooltip = false;
        };

        "hyprland/workspaces" = {
            on-click = "activate";
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              default = "";
              active = "";
            };
        };
        clock = {
            interval = 1;
            format = " {:%H:%M:%S}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              weeks-pos = "left";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
        };
    };
}
