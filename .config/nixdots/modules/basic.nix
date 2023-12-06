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
    ];
  };
}
