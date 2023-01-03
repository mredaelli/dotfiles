{ config
, pkgs
, options
, lib
, ...
}:
let
  packages = with pkgs;
    [
      kitty
      wezterm
      libnotify
      pavucontrol
      imv
      nitrogen
      tridactyl-native
#      libreoffice
#      gimp
      zathura
      mpv
#      zotero
      transmission-gtk
#      calibre
#      nextcloud-client
#      pass
#      pass-secret-service
#3      visidata
 #     fx
      mdcat
      rmlint
      gthumb
      viddy

      git-trim

      ncspot

#      pandoc
#      zk

      i3status-rust

      nix-direnv

      alsaUtils

      matcha-gtk-theme
      qogir-icon-theme
    ];
  devPackages = with pkgs; [
    yamllint
    vim-vint
    shellcheck
    shfmt
    sumneko-lua-language-server
    stylua
  ]
  ++ (with pkgs.nodePackages;
    [
      vim-language-server
      bash-language-server
    ]);
in
{
  options.workstation = {
    withDev = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    nix.extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    environment = {
      pathsToLink = [
        "/share/nix-direnv"
      ];
      homeBinInPath = true;

      systemPackages = packages ++ (if config.workstation.withDev then devPackages else [ ]);
    };

    fonts = {
      fontDir.enable = true;
      fonts = with pkgs; [
        noto-fonts
        gentium
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
    };

    programs = {
      dconf.enable = true;
#      gnupg.agent = {
#        enable = true;
#        pinentryFlavor = "curses";
#        enableSSHSupport = true;
#      };
    };

#    security.pam.services.turing.gnupg.enable = true;

    services = {
      pcscd.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
 #     dbus.packages = with pkgs; [
 #       pass-secret-service
 #     ];
    };
  };
}
