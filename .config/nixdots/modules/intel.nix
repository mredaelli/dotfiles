{ config, pkgs, options, lib, ... }:
{
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vpl-gpu-rt
  ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
