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
      gitui

      mu
      aerc
      w3m
      urlscan
      ripmime
      isync
    ];
  };
}
