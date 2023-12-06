{ config, pkgs, options, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
    ../../modules/laptop.nix
    ../../modules/zfs.nix
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1"
  ];

  # erase your darlings
  environment.etc = {
    nixos.source = "/persistent/etc/nixos";
    "NetworkManager/system-connections".source = "/persistent/etc/NetworkManager/system-connections";
    adjtime.source = "/persistent/etc/adjtime";
    machine-id.source = "/persistent/etc/machine-id";
  };
  systemd.tmpfiles.rules = [
    "L+ /var/lib/systemd/backlight - - - - /persistent/var/lib/systemd/backlight"
  ];
  users.extraUsers.turing.passwordFile = "/persistent/etc/turing-password";
  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/enc/local/root@blank
        zfs rollback -r rpool/enc/local/var@blank
      '';
    };
  };

  networking = {
    hostName = "gimli";
    hostId = "b93e7d6e";
    networkmanager.enable = true;
    firewall.enable = false;
    wireguard.interfaces = {
      #   wg0 = {
      #     ips = [ "10.0.25.90/24" ];
      #     listenPort = 51820;
      #     privateKeyFile = "/persistent/wireguard/private";
      #     peers = [
      #       {
      #         publicKey = "VTaS8M1bema9RmA0RYYOiy1HiNPDVSCENBN/iRXeuUw=";
      #         allowedIPs = [ "10.0.25.0/24" ];
      #         endpoint = "88.198.194.32:51820";
      #         persistentKeepalive = 25;
      #       }
      #     ];
      #   };
    };
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "turing" ];

  programs = {
    adb.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };

    syncthing = {
      enable = true;
      user = "turing";
      dataDir = "/home/turing/sync";
      configDir = "/home/turing/sync/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "lightsong" = { id = "4K4M525-DTMUO2S-6BLRAWU-DW4PIRM-X5LUXJP-2R7G5IU-N7LHIM5-JPI5WAD"; };
        "salsiccia" = { id = "BZVCRAX-RABVSZT-EI3G25R-JS3AB4G-PCSD75V-D5OKJM7-SSWNKFY-JWL3DQ6"; };
        "tablet" = { id = "XL44HFN-ZVOEC4Y-333RP5A-ETT7LIH-K7U7TCP-JXDN67G-BOGSYUE-LWBZUQT"; };
      };
      folders = {
        "Sync" = {
          path = "/home/turing/sync";
          devices = [ "lightsong" ];
        };
        "kb" = {
          path = "/home/turing/carte/kb";
          devices = [ "lightsong" ];
        };
        "zotero" = {
          path = "/home/turing/Zotero/tablet";
          devices = [ "lightsong" ];
        };
      };
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "0 */4 * * *      turing   . /etc/profile;DISPLAY=:0.0 time vdirsyncer sync > /tmp/davsync.log 2>&1"
      ];
    };

    printing = {
      enable = true;
      drivers = [ pkgs.cups-brother-hl3140cw ];
    };
    fstrim.enable = true;
  };

  system.stateVersion = "18.03";
}
