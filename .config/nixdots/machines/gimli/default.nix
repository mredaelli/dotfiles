{
  config,
  pkgs,
  options,
  lib,
  ...
}:
let
  nixos-hardware = builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
in
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
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/intel"
    "${nixos-hardware}/common/pc/ssd"
    "${nixos-hardware}/common/hidpi.nix"
    "${nixos-hardware}/lenovo/thinkpad/x1/12th-gen"
  ];

  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  hardware.enableAllFirmware = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  wayland.wm = "sway";
  #wayland.launcher = "albert";

  services.fprintd.enable = true;
  services.fwupd.enable = true;
  services.sanoid = {
    enable = true;
    datasets."rpool/enc/safe" = {
      useTemplate = [ "safe" ];
      recursive = true;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        withPython3 = true;
        extraPython3Packages = p: with p; [ beancount ];
      };
    })
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
  users.extraUsers.turing.hashedPasswordFile = "/persistent/etc/turing-password";
  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  # virtualisation.docker.enable = true;
  networking = {
    hostName = "gimli";
    hostId = "b93e7d6e";
    networkmanager.enable = true;
    firewall.enable = false;
    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.0.25.90/24" ];
        listenPort = 51820;
        privateKeyFile = "/persistent/wireguard/private_box";
        peers = [
          {
            publicKey = "VTaS8M1bema9RmA0RYYOiy1HiNPDVSCENBN/iRXeuUw=";
            allowedIPs = [ "10.0.25.0/24" ];
            endpoint = "sella.dalv.it:51820";
            persistentKeepalive = 25;
          }
        ];
      };
      wg1 = {
        address = [ "10.13.13.5/24" ];
        listenPort = 51821;
        autostart = false;
        dns = [ "10.8.6.4" ];
        privateKeyFile = "/persistent/wireguard/private_vpn";
        peers = [
          {
            publicKey = "exFbOwx7z57P3QZhA8OgkNRe8LjORNbsI/qUMDILLRQ=";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = "152.67.64.161:5000";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  programs = {
    adb.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    tailscale.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.cups-brother-hl3140cw ];
    };
  };
  systemd.user.services.atuind = {
    enable = true;

    environment = {
      ATUIN_LOG = "info";
    };
    serviceConfig = {
      ExecStart = "${pkgs.atuin}/bin/atuin daemon";
    };
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "18.03";
}
