{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common_settings.nix
      ../../modules/server.nix
      ../../modules/user.nix
      ./nginx.nix
      # ./seafile.nix
      ./poetry.nix
      ./dedications.nix
      ./calcal.nix
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
    autoScrub = {
      enable = true;
    };
  };
  services.sanoid = {
    enable = true;
    
   templates.production = {
      hourly = 12; 
      daily = 10; 
      monthly = 2;
      autoprune = true;
      autosnap = true;
    };
    datasets."rpool" = {
      useTemplate = [ "production" ];
      recursive = true;
    };
  };

  services.monica = {
    enable = true;
    hostname = "monica.typish.io";
    dataDir = "/data/monica";
    appKeyFile = "/var/secrets/monica";
    nginx = {
       enableACME = true;
       forceSSL = true;
    };
    config = { APP_DISABLE_SIGNUP = "true"; };
  };
  services.atuin = {
    enable = true;
    openFirewall=true;
    host="0.0.0.0";
  };
  services.nginx.virtualHosts."atuin.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:8888;
        proxy_pass_request_headers on;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      600s;
        proxy_send_timeout      600s;
      '';
    };
  };

  services.nginx.virtualHosts."calcal.typish.dev" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:7777;
        proxy_pass_request_headers on;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      600s;
        proxy_send_timeout      600s;
      '';
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
        ${pkgs.restic}/bin/restic backup /.zfs/snapshot/backup/var/secrets/ /.zfs/snapshot/backup/var/lib/ /data/.zfs/snapshot/backup/ /var/lib/private/.zfs/snapshot/backup/

        echo Destroying local backup snapshot
        ${zfs} destroy -r rpool@backup

        echo Cleaning up snapshots on b2
        ${pkgs.restic}/bin/restic forget --keep-daily 7 --keep-weekly 6 --keep-monthly 12 --keep-yearly 45

        echo Done
      '';
    startAt = "daily";
    serviceConfig = {
      EnvironmentFile = "/var/secrets/restic.env";
      Type = "oneshot";
      User = "root";
    };
  };

  nix.settings.allowed-users = [ "@wheel" ];

  system.autoUpgrade.enable = true;

  services.openssh.enable = true;
  services.fail2ban.enable = true;

  system.stateVersion = "23.11";
}
