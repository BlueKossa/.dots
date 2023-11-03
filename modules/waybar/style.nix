{ pkgs-unstable, ... }:
''
@import '/home/bluecore/.cache/wal/colors-waybar.css';
${builtins.readFile "${pkgs-unstable.waybar}/etc/xdg/waybar/style.css"}


* {
    font-weight: bold;
    font-family: UbuntuMono Nerd Font Mono;
    font-size: 16px;
}

window#waybar {
    background: @background;
    border-bottom: none;
}



#cpu, #memory, #disk, #pulseaudio, #clock, #tray, #custom-spotifyplaying, #custom-powermenu {
    background: transparent;
    color: @foreground;
    border: none;
    padding: 0px 8px;
}

#custom-spotifyplaying, #cpu, #memory, #disk {
    border-right: 1px solid @foreground;
}

#custom-spotifyplaying {
    padding-left: 0px;
}

#custom-spotifyicon {
    padding-left: 8px;
}

#pulseaudio, #clock, #tray, #custom-powermenu {
    border-left: 1px solid @foreground;
}


button:hover {
    box-shadow: inherit;
    text-shadow: inherit;
}

#workspaces {
    background: transparent;
}

#workspaces button {
    transition: all 0.2s ease-in-out;
    color: @foreground;
    background: transparent;
    border: none;
    padding: 0px 8px;
}

#workspaces button.active {
  color: @color1;
}

#workspaces button:hover {
  color: @color2;
}
''
