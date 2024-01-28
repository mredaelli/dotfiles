{ config, pkgs, options, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export DRI_PRIME=pci-0000_01_00_0 
    export __VK_LAYER_NV_optimus=NVIDIA_only 
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    exec "$@"
  '';
  extraEnv = {
    WLR_NO_HARDWARE_CURSORS = "1";
    # Gives problems with wezterm
    # WLR_RENDERER = "vulkan";
  };
in
{
  # hardware.opengl.extraPackages = with pkgs; [
  #   vulkan-validation-layers
  # ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  environment.variables = extraEnv;
  environment.sessionVariables = extraEnv;
  environment.systemPackages = with pkgs; [
    nvidia-offload
    glxinfo
    vulkan-tools
    glmark2
  ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    #  videoDrivers = [ "nouveau" ];
  };
}
