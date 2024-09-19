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

  networking = {
    hostName = "stella";
    hostId = "e8f1ee25";
    useDHCP = false;
    enableIPv6 = true;
    networkmanager.enable = true;
    interfaces.enp0s6.useDHCP = true;
    firewall.allowedTCPPorts = [ 22 80 443 ];
  };

  services.zfs = {
    trim.enable = true;
    autoSnapshot = {
      enable = true;
      frequent = 0;
      hourly = 12;
      daily = 3;
      weekly = 0;
      monthly = 0;
    };
    autoScrub = {
      enable = true;
    };
  };

  systemd.services.b2Backup = {
    enable = true;
    script =
      let
        zfs = "${pkgs.zfs}/bin/zfs";
      in
      ''
        if ${zfs} list -t snapshot | ${pkgs.busybox}/bin/grep "rpool@backup" ; then
          echo Destroying leftover backup
          ${zfs} destroy -r rpool@backup
        fi

        echo Creating new backup snapshot
        ${zfs} snapshot -r rpool@backup

        echo Backing up on b2
        ${pkgs.restic}/bin/restic backup /.zfs/snapshot/backup/var/lib/ /data/.zfs/snapshot/backup/ /var/lib/private/.zfs/snapshot/backup/

        echo Destroying local backup snapshot
        ${zfs} destroy -r rpool@backup

        echo Cleaning up snapshots on b2
        ${pkgs.restic}/bin/restic forget --keep-daily 7 --keep-weekly 6 --keep-monthly 12 --keep-yearly 45

        echo Done
      '';
    startAt = "Every Night";
    serviceConfig = {
      EnvironmentFile = "/var/secrets/restic.env";
      Type = "oneshot";
      User = "root";
    };
  };

  nix.settings.allowed-users = [ "@wheel" ];

  system.autoUpgrade.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
