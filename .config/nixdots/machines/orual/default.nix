{ config, pkgs, lib, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad>
    ./wireguard.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
    ../../modules/laptop.nix
    ../../modules/zfs.nix
  ];

  # erase your darlings
  environment.etc = {
    nixos.source = "/persistent/etc/nixos";
    "NetworkManager/system-connections".source = "/persistent/etc/NetworkManager/system-connections";
    adjtime.source = "/persistent/etc/adjtime";
    machine-id = {
      source = "/persistent/etc/machine-id";
      mode = "0444";
    };
  };
  systemd.tmpfiles.rules = [
    "L+ /var/lib/systemd/backlight - - - - /persistent/var/lib/systemd/backlight"
  ];
  # users.extraUsers.turing.passwordFile = "/persistent/etc/turing-password";
  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  boot = {
    # extraModprobeConfig = ''
    #   blacklist nouveau
    #   options nouveau modeset=0
    # '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 50000 50001 ];
      allowedUDPPorts = [ 50000 ];
      checkReversePath = "loose";
    };
    hostId = "5f87931e";
    hostName = "orual";
    hosts = {
      "104.199.65.124" = [ "ap-gew4.spotify.com" ];
    };
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    jp
    jesec-rtorrent
    flood
    wally-cli
    keepassxc
    innernet
    kanshi
    signal-desktop
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "until=240h" ];
    };
  };
  # netmaker
  environment.etc.hosts.mode = "0644";

  services = {
    openssh.enable = true;
    cron = {
      enable = true;
      systemCronJobs = [
        "0 */4 * * *      turing    . /etc/profile ;DISPLAY=:0.0 vdirsyncer sync calendar > /tmp/calsync.log 2>&1"
        "9,19,29,39,49,59 * * * *      turing    . /etc/profile; DISPLAY=:0.0 /home/turing/bin/reminders"
      ];
    };
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
    fstrim.enable = true;
    thinkfan = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
  };

  system.stateVersion = "21.05";
}
