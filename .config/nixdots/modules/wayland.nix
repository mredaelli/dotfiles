{ config, pkgs, options, lib, ... }:
{
  # remember to load the video card kernel module in hardware-configuration

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # environment.noXlibs = true;

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      wrapperFeatures.base = true;
      extraSessionCommands = ''
        export GTK_THEME=Matcha-dark-sea
        export MOZ_ENABLE_WAYLAND=1
        export MOZ_WEBRENDER=1
        export QT_QPA_PLATFORM="wayland;xcb"
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export SDL_VIDEODRIVER=wayland
        export XCURSOR_SIZE=40
        export XCURSOR_THEME=Qogir-dark
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
        # export XWAYLAND_NO_GLAMOR=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme $XCURSOR_THEME || true
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-size $XCURSOR_SIZE || true
      '';
      extraPackages = with pkgs;
        [
          swaylock-fancy
          swayidle
          waybar
          playerctl
          wl-clipboard
          sway-contrib.grimshot
          swaynotificationcenter #mako
          rofi-wayland
          wlsunset
          xdg-desktop-portal-wlr
          xdg-desktop-portal
          xdg-desktop-portal-gtk
          xdg_utils
          imv
          kanshi
          firefox-wayland
          gsettings-desktop-schemas
        ];
    };
  };

  boot.kernelParams = [ "console=tty1" ];
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
}
