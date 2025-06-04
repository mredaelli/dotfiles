{ config, pkgs, lib, options, ... }:
let
  nixos-hardware =
    builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
in {
  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad>
    ./wireguard.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/intel"
    <nixos-hardware/common/gpu/nvidia>
    "${nixos-hardware}/common/pc/ssd"
    "${nixos-hardware}/common/hidpi.nix"
    # ../../modules/intel.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
    ../../modules/laptop.nix
    ../../modules/zfs.nix
    # ../../modules/nvidia.nix
  ];

  hardware.nvidia.open = false;
  hardware.intelgpu.vaapiDriver = "intel-media-driver";

  hardware.enableAllFirmware = true;

  # erase your darlings
  environment.etc = {
    nixos.source = "/persistent/etc/nixos";
    # "NetworkManager/system-connections".source = "/persistent/etc/NetworkManager/system-connections";
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
  services.logind.lidSwitchExternalPower = "ignore";
  services.fprintd.enable = true;
  services.fwupd.enable = true;

  boot = {
    # blacklistedKernelModules = [ "nouveau" ];
    kernel.sysctl = { "vm.swappiness" = 10; };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 50000 50001 ];
      allowedUDPPorts = [ 50000 51820 ];
      checkReversePath = "loose";
    };
    hostId = "5f87931e";
    hostName = "orual";
    networkmanager.enable = true;
  };

  fonts = { packages = with pkgs; [ corefonts ]; };

  environment.systemPackages = with pkgs; [
    jp
    wally-cli
    vscode
    ungoogled-chromium
    zoom-us
    teams-for-linux
    psst
    devenv
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    autoPrune = {
      enable = true;
      flags = [ "until=240h" ];
    };
    listenOptions = [ "/run/docker.sock" "0.0.0.0:2376" ];
  };
  # netmaker
  environment.etc.hosts.mode = "0644";
  networking.hosts = {
    "159.100.245.195" = [ "headscale.lari.systems" ];
    "127.0.0.1" = [ "calcal.typish.io" ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  services = {
    zfs.autoSnapshot = {
      enable = true;
      monthly = 3;
    };
    fstrim.enable = true;
    thinkfan = { enable = true; };
    tailscale = { enable = true; };
    printing.enable = true;
    printing.drivers = [ pkgs.hplipWithPlugin ];
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    udev.extraRules = lib.concatStringsSep ", " [
      ''ACTION=="add"''
      ''SUBSYSTEM=="pci"''
      ''ATTR{vendor}=="0xa0ed"''
      ''ATTR{class}=="0x0c0330"''
      ''ATTR{power/wakeup}="disabled"''
    ];
  };
  programs.nix-ld.enable = true;

  system.stateVersion = "21.05";
}
