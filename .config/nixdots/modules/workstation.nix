{ config, pkgs, options, ... }:
{
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment = {
    pathsToLink = [
      "/share/nix-direnv"
    ];
    homeBinInPath = true;
    systemPackages = with pkgs; [
      kitty
      wezterm
      libnotify
      pavucontrol
      imv
      nitrogen
      tridactyl-native
      libreoffice
      gimp
      zathura
      mpv
      zotero
      transmission-gtk
      calibre
      nextcloud-client
      pass
      pass-secret-service
      visidata
      fx
      mdcat
      rmlint
      gthumb

      git-trim

      ncspot

      yamllint
      vim-vint
      shellcheck
      shfmt
      sumneko-lua-language-server
      stylua
      pandoc
      zk

      i3status-rust

      nix-direnv

      alsaUtils

      matcha-gtk-theme
      qogir-icon-theme
    ] ++ (with nodePackages; [
      vim-language-server
      bash-language-server
    ]);
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
}
