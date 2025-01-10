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
    text = ''
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Matcha-dark-sea'
      gsettings set $gnome_schema cursor-theme Qogir-dark
      gsettings set $gnome_schema cursor-size 40
    '';
  };
  rofi-stuff = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
      rofi-emoji-wayland
      rofi-top
      rofi-bluetooth
      rofi-power-menu
      rofi-file-browser
    ];
  };
in {

  options.wayland = {
    wm = lib.mkOption {
      type = lib.types.enum [ "sway" "niri" ];
      default = "sway";
    };
    launcher = lib.mkOption {
      type = lib.types.enum [ "rofi" "albert" ];
      default = "rofi";
    };
  };

  config = let
    useSway = options.wayland.wm == "sway";
    sessionCmd = if useSway then "sway" else "niri-session";
    sessions =
      "${pkgs.niri}/share/wayland-sessions:${pkgs.sway}/share/wayland-sessions";
  in {
    hardware.graphics.enable = true;

    # environment.noXlibs = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    security.pam.services.swaylock = { };
    environment.systemPackages = with pkgs; [
      dbus # make dbus-update-activation-environment available in the path
      dbus-sway-environment
      configure-gtk
      wayland
      glib # gsettings

      swaylock-fancy
      swaylock-effects
      swayidle
      waybar
      playerctl
      wl-clipboard
      sway-contrib.grimshot
      swaynotificationcenter
      wlsunset
      xdg-utils
      imv
      kanshi
      firefox-wayland
      # wdisplays # tool to configure displays

      sway
      rofi-stuff

      niri
      xwayland-satellite
      albert
    ];
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };

    boot.kernelParams = [ "console=tty1" ];
    services.greetd = {
      enable = true;
      vt = 2;
      settings = {
        default_session = {
          command = "${
              lib.makeBinPath [ pkgs.greetd.tuigreet ]
            }/tuigreet --time --cmd '${sessionCmd}' --remember-session --remember --user-menu --asterisks --sessions ${sessions}";
          user = "greeter";
        };
      };
    };
  };
}
