{ config, pkgs, options, lib, ... }:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Matcha-dark-sea'
        gsettings set $gnome_schema cursor-theme Qogir-dark
        gsettings set $gnome_schema cursor-size 40
      '';
  };

in
{
  # remember to load the video card kernel module in hardware-configuration

  hardware.graphics.enable = true;

  # environment.noXlibs = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      # wrapperFeatures.base = true;
      # extraSessionCommands = ''
      #   export GTK_THEME=Matcha-dark-sea
      #   export MOZ_ENABLE_WAYLAND=1
      #   export MOZ_WEBRENDER=1
      #   export QT_QPA_PLATFORM="wayland;xcb"
      #   export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      #   export SDL_VIDEODRIVER=wayland
      #   export XCURSOR_SIZE=40
      #   export XCURSOR_THEME=Qogir-dark
      #   export XDG_CURRENT_DESKTOP=sway
      #   export XDG_SESSION_TYPE=wayland
      #   # export XWAYLAND_NO_GLAMOR=1
      #   export _JAVA_AWT_WM_NONREPARENTING=1
      #   ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme $XCURSOR_THEME || true
      #   ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-size $XCURSOR_SIZE || true
      # '';
      # extraPackages = with pkgs;
      #   [
      #     swaylock-fancy
      #     swayidle
      #     waybar
      #     playerctl
      #     wl-clipboard
      #     sway-contrib.grimshot
      #     swaynotificationcenter #mako
      #     rofi-wayland
      #     wlsunset
      #     xdg-desktop-portal-wlr
      #     xdg-desktop-portal
      #     xdg-desktop-portal-gtk
      #     xdg_utils
      #     imv
      #     kanshi
      #     firefox-wayland
      #     gsettings-desktop-schemas
      #   ];
    };
  };
  environment.systemPackages = with pkgs; [
    dbus # make dbus-update-activation-environment available in the path
    dbus-sway-environment
    configure-gtk
    wayland
    glib # gsettings
    swaylock-fancy
    swayidle
    waybar
    playerctl
    wl-clipboard
    sway-contrib.grimshot
    swaynotificationcenter #mako
    rofi-wayland
    wlsunset
    xdg_utils
    imv
    kanshi
    firefox-wayland
    # wdisplays # tool to configure displays
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  boot.kernelParams = [ "console=tty1" ];
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd 'sway --unsupported-gpu'";
        user = "greeter";
      };
    };
  };
}
