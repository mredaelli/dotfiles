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
