{ config, pkgs, options, lib, ... }:
let
  packages = with pkgs; [
    wezterm
    libnotify
    pavucontrol
    imv
    nitrogen
    tridactyl-native
    zathura
    mpv
    transmission_4-gtk
    rmlint
    alsa-utils
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
    fx
    tlrc
  ];
  devPackages = with pkgs;
    [
      so
      cht-sh
      gitui
      nix-direnv
      devenv
      git-trim
      yamllint
      vim-vint
      shfmt
      sumneko-lua-language-server
      nixd
      nixfmt-classic
      shfmt
      stylua
      vimPlugins.sniprun
      markdown-oxide
    ] ++ (with pkgs.nodePackages; [
      vim-language-server
      bash-language-server
      yaml-language-server
    ]);
in {
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

    xdg.mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "writer.desktop";
      "application/vnd.oasis.opendocument.text" = "writer.desktop";
      "image/jpg" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
    };

    environment = {
      pathsToLink = [ "/share/nix-direnv" ];
      homeBinInPath = true;

      systemPackages = packages ++ (if config.workstation.full then
        (devPackages ++ morePackages)
      else
        [ ]);
    };

    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        noto-fonts
        gentium
        alegreya
        corefonts
        nerd-fonts.jetbrains-mono
      ];
    };

    programs = {
      dconf.enable = true;
      gnupg.agent = {
        enable = true;
        # pinentryFlavor = "curses";
        enableSSHSupport = true;
      };
      zoxide.enable = true;
    };

    security.pam.services.turing.gnupg.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      pcscd.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
    };
  };
}
