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
      unstable.wezterm
      libnotify
      pavucontrol
      imv
      nitrogen
      tridactyl-native
      zathura
      mpv
      transmission-gtk
      rmlint
      i3status-rust
      alsaUtils
      matcha-gtk-theme
      qogir-icon-theme
    ];
  morePackages = with pkgs; [
    ncspot
    gthumb
    mdcat
    viddy
    zk
    zotero
    libreoffice
    gimp
    calibre
    nextcloud-client
    pass
    pass-secret-service
    visidata
    fx
  ];
    devPackages = with pkgs;
  [
  nix-direnv
    git-trim
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
    full = lib.mkOption {
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

      systemPackages = packages ++ (if config.workstation.full then (devPackages ++ morePackages) else [ ]);
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
      gnupg.agent = {
        enable = true;
        pinentryFlavor = "curses";
        enableSSHSupport = true;
      };
    };

    security.pam.services.turing.gnupg.enable = true;

    services = {
      pcscd.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
      dbus.packages = with pkgs; [
        pass-secret-service
      ];
    };
  };
  }
