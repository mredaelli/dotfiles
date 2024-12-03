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
    # ../../modules/nvidia.nix
    # <nixos-hardware/common/gpu/nvidia/disable.nix>
  ];


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

  boot = {
    # blacklistedKernelModules = [ "nouveau" ];
    kernel.sysctl = { "vm.swappiness" = 10; };
    # kernelPackages = pkgs.linuxPackages_6_10;
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


  environment.systemPackages = with pkgs; [
    jp
    wally-cli
    vscode
    ungoogled-chromium
    zoom-us
    teams-for-linux
    psst
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
  
  # Intel graphics
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    onevpl-intel-gpu
  ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # power off NVIDIA
  hardware.bumblebee.enable = true;
  nixpkgs.overlays = [ # https://github.com/NixOS/nixpkgs/issues/319838
     (self: super: {
       bumblebee = super.bumblebee.override {
         nvidia_x11_i686 = null;
         libglvnd_i686 = null;
       };
       primus = super.primus.override {
         primusLib_i686 = null;
       };
     })
  ];

  services = {
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
