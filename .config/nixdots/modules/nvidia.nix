{ config, pkgs, options, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export DRI_PRIME=pci-0000_01_00_0 
    export __VK_LAYER_NV_optimus=NVIDIA_only 
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    exec "$@"
  '';
  # https://github.com/TLATER/dotfiles/blob/e633196dca42d96f42f9aa9016fa8d307959232f/nixos-config/yui/nvidia.nix#L33
  extraEnv = {
    WLR_NO_HARDWARE_CURSORS = "1";
    # Gives problems with wezterm
    # WLR_RENDERER = "vulkan";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
    EGL_PLATFORM = "wayland";
    # WLR_RENDERER = "gles2";
  };
in
{
  # boot.extraModprobeConfig =
  #   "options nvidia "
  #   + lib.concatStringsSep " " [
  #     # nvidia assume that by default your CPU does not support PAT,
  #     # but this is effectively never the case in 2023
  #     # "NVreg_UsePageAttributeTable=1"
  #     # This may be a noop, but it's somewhat uncertain
  #     # "NVreg_EnablePCIeGen3=1"
  #     # This is sometimes needed for ddc/ci support, see
  #     # https://www.ddcutil.com/nvidia/
  #     #
  #     # Current monitor does not support it, but this is useful for
  #     # the future
  #     # "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
  #     # When (if!) I get another nvidia GPU, check for resizeable bar
  #     # settings
  #   ];
  hardware.opengl.extraPackages = with pkgs; [
    # vulkan-validation-layers
    nvidia-vaapi-driver
  ];

  environment.variables = extraEnv;
  environment.sessionVariables = extraEnv;
  environment.systemPackages = with pkgs; [
    nvidia-offload
    glxinfo
    # vulkan-tools
    # glmark2
  ];
  hardware.nvidia = {
    # open = false;
    open = true;
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "550.67";
    #   sha256_64bit = "sha256-mSAaCccc/w/QJh6w8Mva0oLrqB+cOSO1YMz1Se/32uI=";
    #   sha256_aarch64 = "sha256-+UuK0UniAsndN15VDb/xopjkdlc6ZGk5LIm/GNs5ivA=";
    #   openSha256 = "sha256-M/1qAQxTm61bznAtCoNQXICfThh3hLqfd0s1n1BFj2A=";
    #   settingsSha256 = "sha256-FUEwXpeUMH1DYH77/t76wF1UslkcW721x9BHasaRUaM=";
    #   persistencedSha256 = "sha256-ojHbmSAOYl3lOi2X6HOBlokTXhTCK6VNsH6+xfGQsyo=";
    # };
    # config.boot.kernelPackages.nvidiaPackages.stable;
    # nvidiaSettings = true;
    # nvidiaSettings = false;
    # nvidiaPersistenced = true;
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    #  videoDrivers = [ "nouveau" ];
  };
}
