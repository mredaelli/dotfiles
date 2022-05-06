{ config, pkgs, options, ... }:
{
  imports = [
    ./server.nix
  ];
  environment = {
    systemPackages = with pkgs; [
      imagemagick
      restic
      bashmount
      so
      imagemagick
      restic

      gitui

      ultralist

      mu
      neomutt
      w3m
      urlscan
      ripmime
      isync
      khard
      vdirsyncer
      khal

      glow
    ];
  };
}
