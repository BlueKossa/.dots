{ ... }:
let
  # Whatever you do do not change the — to a regular - in the tooltip because
  # for some fkn reason it just does not appear then. 
  playerctlSpotify = ''
        playerctl -p spotify metadata --format '{"text": "{{markup_escape(artist)}} - {{markup_escape(title)}}", "tooltip": "{{markup_escape(artist)}} — {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
in
{
    mainBar = {
        layer = "top";
        position = "left";
        spacing = 5;
        tray = {
            spacing = 5;
        };
        modules-left = [
          "tray"
          # "custom/padding"
          # "image"
          # "custom/spotifyicon"
           "cpu"
           "memory"
           "disk"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "battery"
          "pulseaudio"
          "group/clock"
          "custom/powermenu"
          "custom/padding"
          # "tray"
        ];

        "group/clock" = {
          orientation = "vertical";
          spacing = 5;
          modules = [
            "clock#hour"
            "clock#minsec"
          ];
        };

        "group/spotify" = {
          orientation = "vertical";
          spacing = 5;
          modules = [
            "image"
            "custom/spotifyicon"
          ];
        };
        # I would LOVE to have this as image#spotify but NO YOU CANNOT DO THAT BECAUSE ????
        # I have legit spent 5 hours trying to get it to work
        "image" = {
          escape = true;
          exec = "/home/bluecore/.dots/scripts/album_cover.sh";
          interval = 1;
          size = 50;
          on-click = "playerctl -p spotify previous";
          on-click-right = "playerctl -p spotify next";
          on-click-middle = "playerctl -p spotify play-pause";
          on-scroll-up = "playerctl -p spotify volume .1+";
          on-scroll-down = "playerctl -p spotify volume .1-";
        };

        "custom/padding" = {
          format = " ";
          tooltip = false;
        };

        # This was mostly copied from https://github.com/linuxmobile/kaku/blob/main/home/wayland/waybar/config.nix
        "custom/spotifyicon" = {
          escape = true;
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
            Playing = "<span foreground='#6791eb'>󰓇</span>";
            Paused = "<span foreground='#cdd6f4'>󰓇</span>";
          };
          tooltip-format = "{tooltip}";
        };
        #"custom/spotifyplaying" = {
        #  exec = "${playerctlSpotify}";
        #  format = "<span>{}</span>";
        #  return-type = "json";
        #  max-length = 40;
        #  on-click = "playerctl -p spotify previous";
        #  on-click-right = "playerctl -p spotify next";
        #  on-click-middle = "playerctl -p spotify play-pause";
        #  on-scroll-up = "playerctl -p spotify volume .1+";
        #  on-scroll-down = "playerctl -p spotify volume .1-";
        #};
        "custom/powermenu" = {
          format = "󰐥";
          on-click = "$HOME/.dots/scripts/power_menu.sh";
          tooltip = false;
        };

        memory = {
          format = "";
          format-alt = "{}%";
          interval = 2;
        };

        cpu = {
          format = "";
          format-alt = "{usage}%";
          interval = 2;
        };

        disk = {
          format = "󰋊";
          format-alt = "{percentage_used}%";
          interval = 30;
          path = "/";
        };
        battery = {
          format = "{icon}";
          format-alt = "{capacity}%";
          states = {
            "warning" = 30;
            "critical" = 15;
          };
          format-icons = ["" "" "" "" ""];
          interval = 10;
        };
        pulseaudio = {
          format = "{icon}";
          format-alt = "{volume}%";
          format-muted = "";
          format-source = "<span foreground='#00ff00'></span>";
          format-source-muted = "<span foreground='#ff0000'></span>";
          format-icons = {default = ["" "" "" "" "" ""];};
          scroll-step = 5;
          on-click-right = "pavucontrol";
          tooltip-format = "{volume}%";
        };

        "hyprland/workspaces" = {
            on-click = "activate";
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              default = "";
              "1" = "";
              "2" = "󰙯";
              "3" = "";
              "4" = "󰓇";
            };
        };
        "clock#hour" = {
            interval = 1;
            format = "{:%H}";
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
        "clock#minsec" = {
          interval = 1;
          format = "{:%M:%S}";
        };
    };
}
