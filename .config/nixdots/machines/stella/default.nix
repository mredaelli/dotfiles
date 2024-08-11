{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common_settings.nix
      ../../modules/server.nix
      ../../modules/user.nix
      ./nginx.nix
      ./poetry.nix
      ./vaultwarden.nix
      ./shiori.nix
      ./syncthing.nix
      ./postgres.nix
      ./miniflux.nix
      ./nextcloud.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  networking.hostName = "stella";
  networking.hostId = "e8f1ee25";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.enableIPv6 = true;
  networking.interfaces.enp0s6.useDHCP = true;

  system.autoUpgrade.enable = true;

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  system.stateVersion = "23.11";
}
