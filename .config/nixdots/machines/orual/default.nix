{ config, pkgs, lib, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad>
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
    machine-id.source = "/persistent/etc/machine-id";
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
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 50000 50001 ];
      allowedUDPPorts = [ 50000 ];
    };
    hostId = "5f87931e";
    hostName = "orual";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    jp
    rtorrent
    wally-cli
    keepassxc
    unstable.innernet
    kanshi
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "until=240h" ];
    };
  };

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
    udev.extraRules = ''
       # Remove NVIDIA USB xHCI Host Controller devices, if present
       ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
       # Remove NVIDIA USB Type-C UCSI devices, if present
       ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
       # Remove NVIDIA Audio devices, if present
       ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
       # Remove NVIDIA VGA/3D controller devices
       ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
     '';
     thinkfan = {
       enable = true;
     };
  };

  system.stateVersion = "21.05";
}
