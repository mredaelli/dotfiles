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
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1/12th-gen"
  ];


  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vpl-gpu-rt
  ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  services.fprintd.enable = true;

  nixpkgs.overlays = [
    (self: super: {
    neovim = super.neovim.override { withPython3 = true; extraPython3Packages = p: with p; [ beancount ]; };
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

  virtualisation.docker.enable = true;
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

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "turing" ];

  programs = {
    adb.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.cups-brother-hl3140cw ];
    };
    fstrim.enable = true;
  };

  system.stateVersion = "18.03";
}
