{
  config,
  pkgs,
  options,
  lib,
  ...
}:
let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
        gnome_schema = "org.gnome.desktop.interface";
        gsettings = "${pkgs.glib}/bin/gsettings";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        ${gsettings} set ${gnome_schema} gtk-theme 'Matcha-dark-sea-hdpi'
        ${gsettings} set ${gnome_schema} icon-theme Quintom_Ink
        # Put this also in sway config, as `seat seat0 xcursor_theme Quintom_Ink 40`
        ${gsettings} set ${gnome_schema} cursor-theme Quintom_Ink
        ${gsettings} set ${gnome_schema} cursor-size 40
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
in
{

  options.wayland = {
    wm = lib.mkOption {
      type = lib.types.enum [
        "sway"
        "niri"
      ];
      default = "sway";
    };
    launcher = lib.mkOption {
      type = lib.types.enum [
        "rofi"
        "albert"
      ];
      default = "rofi";
    };
  };

  config =
    let
      useSway = options.wayland.wm == "sway";
      sessionCmd = if useSway then "sway" else "niri-session";
      sessions = "${pkgs.niri}/share/wayland-sessions:${pkgs.sway}/share/wayland-sessions";
    in
    {
      hardware.graphics.enable = true;

      # environment.noXlibs = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      security.pam.services.swaylock = { };
      environment.systemPackages = with pkgs; [
        dbus-sway-environment
        configure-gtk

        swaylock-fancy
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

        # sway
        rofi-stuff

        niri
        xwayland-satellite
        albert

        matcha-gtk-theme
        quintom-cursor-theme
      ];
      programs = {
        sway = {
          enable = true;
          wrapperFeatures = {
            base = true;
            gtk = true;
          };
          extraSessionCommands = ''
            configure-gtk
          '';
        };
      };
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-gtk
        ];
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
