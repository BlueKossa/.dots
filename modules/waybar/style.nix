{ pkgs-unstable, ... }:
''
${builtins.readFile "${pkgs-unstable.waybar}/etc/xdg/waybar/style.css"}

@define-color bg rgba(31,31,40,1.);
@define-color fg rgba(255,255,255,.85);
@define-color color0 rgba(31,31,40,.85);



* {
    font-weight: bold;
    font-family: UbuntuMono Nerd Font Mono;
    font-size: 16px;
}

window#waybar {
    background: @bg;
    border-bottom: none;
}



#cpu, #memory, #disk, #pulseaudio, #clock, #tray, #custom-spotifyplaying {
    background: transparent;
    color: @fg;
    border: none;
    padding: 0px 8px;
}

#custom-spotifyplaying, #cpu, #memory, #disk {
    border-right: 1px solid @fg;
}

#custom-spotifyplaying {
    padding-left: 0px;
}

#custom-spotifyicon {
    padding-left: 8px;
}

#pulseaudio, #clock, #tray {
    border-left: 1px solid @fg;
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
    color: @fg;
    background: transparent;
    border: none;
    padding: 0px 8px;
}

#workspaces button.active {
  color: green;
}

#workspaces button:hover {
  color: yellow;

}
''
