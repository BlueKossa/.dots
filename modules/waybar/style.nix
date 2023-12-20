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
    opacity: 0.7;
    border-bottom: none;
}

window#waybar > * {
    opacity: 1;
}



#cpu, #memory, #disk, #pulseaudio, #clock, #tray, #custom-spotifyplaying, #custom-powermenu {
    background: transparent;
    color: @foreground;
    border: none;
}

/* 
#custom-spotifyplaying, #cpu, #memory, #disk {
    border-right: 1px solid @foreground;
}
*/

#custom-spotifyicon {
    font-size: 30px;
}

#clock.hour {
    font-size: 30px;
}

#modules-left {
  padding-top: 20px;
}


/*
#pulseaudio, #clock, #tray, #custom-powermenu {
    border-left: 1px solid @foreground;
}
*/

#pulseaudio, #cpu, #memory, #disk {
    font-size: 30px;
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

#workspaces label {
    font-size: 30px;
}

#workspaces button.active {
  color: @color1;
  background: transparent;
}

#workspaces button:hover {
  color: @color2;
  background: transparent;
}

#custom-powermenu {
  font-size: 30px;
}

#custom-padding {
  padding: 0px 15px;
}
''
