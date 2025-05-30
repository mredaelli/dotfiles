{ config, pkgs, options, ... }:
let baseConfig = { allowUnfree = true; };
in {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "turing" ];
  };

  system.rebuild.enableNg = true;

  documentation = {
    doc.enable = false;
    info.enable = false;
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "it_IT.UTF-8/UTF-8" ];

  imports = [ ../cachix.nix ];

  nixpkgs.overlays = [
    (self: super:
      with super;
      {
        # spotifyd = super.spotifyd.override { withMpris = true; };
      })
  ];

  nixpkgs.config = baseConfig // {
    allowUnfree = true;
    android_sdk.accept_license = true;
    pulseaudio = true;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
      jre = pkgs.jdk11;
      fenix = import (fetchTarball
        "https://github.com/nix-community/fenix/archive/main.tar.gz") { };
    };
  };

  console.useXkbConfig = true;

  time.timeZone = "Europe/Rome";

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AcceptEnv = "VTE_VERSION TERM COLORTERM TERMPROGRAM";
      };
    };
  };
}
