{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/server.nix
    ../../modules/user.nix
    ../../modules/nginx_http2.nix
    ../../modules/postiz.nix
    ./nginx.nix
    ./vaultwarden.nix
    ./shiori.nix
    ./syncthing.nix
    ./postgres.nix
    ./miniflux.nix
    ./nextcloud.nix
    ./atuin.nix
    ./readeck.nix
    ./monica.nix
    ./silverbullet.nix
    ./silverbullet-sync.nix
    ./silverbullet_personal.nix
    ./wireguard.nix
    ./matrix.nix
  ];
  services.postiz = {
    enable = true;
    domain = "postiz.typish.dev";
    dataDir = "/data/postiz"; # default: /var/lib/postiz
    environmentFile = "/var/secrets/postiz.env"; # default: null (no extra env file)
  };

  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.blacklistedKernelModules = [
    "algif_aead"
    "esp4"
    "esp6"
    "rxrpc"
  ];

  networking = {
    hostName = "stella";
    hostId = "e8f1ee25";
    useDHCP = false;
    enableIPv6 = true;
    networkmanager.enable = true;
    interfaces.enp0s6.useDHCP = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };

  nix.settings.allowed-users = [ "@wheel" ];

  system.autoUpgrade.enable = true;

  services.openssh.enable = true;
  services.fail2ban.enable = true;

  services.zfs = {
    trim.enable = true;
    autoScrub = {
      enable = true;
    };
  };

  services.hister = {
    enable = true;
    dataDir = "/data/nogon";
    port = 8734;
    openFirewall = true;
    settings = {
      app = {
        search_url = "https://google.com/search?q={query}";
        log_level = "info";
      };
      server = {
        address = "100.96.0.1";
        database = "db.sqlite3";
      };
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

  services.gitolite = {
    enable = true;
    dataDir = "/data/gitolite";
    adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtRIecnDtJ+i39zl1U+bTQ//Q59ILtO4ZywRljOz6lx turing@gimli";
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

  system.stateVersion = "23.11";
}
