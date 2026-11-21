{ ... }:
let
  baseConfig = {
    allowUnfree = true;
  };
  micasa-flake = builtins.getFlake "github:micasa-dev/micasa";
  llm-agents-flake = builtins.getFlake "github:numtide/llm-agents.nix";
in
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "configurable-impure-env"
      ];
      trusted-users = [
        "root"
        "turing"
      ];
      extra-substituters = [ "https://cache.numtide.com" ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "it_IT.UTF-8/UTF-8"
  ];

  imports = [ ../cachix.nix ];

  nixpkgs.overlays = [
    (
      self: super: with super; {
        # spotifyd = super.spotifyd.override { withMpris = true; };
      }
    )
    # Steam's 32-bit support pulls a 32-bit pipewire whose scons-based audio
    # backends (ffado/roc/spandsp) transitively build numpy -> openblas for
    # i686-linux. That openblas build hangs forever in its check phase on
    # i686 (zblat3 deadlock), which is upstream issue NixOS/nixpkgs#534670,
    # fixed by NixOS/nixpkgs#534770 (merged 2026-06-24). Our channel snapshot
    # predates that merge, so apply the same fix until the channel catches up:
    # skip the broken test suite on the i686 openblas build.
    (self: super: {
      pkgsi686Linux = super.pkgsi686Linux.extend (
        s: o: {
          openblas = o.openblas.overrideAttrs (_: {
            doCheck = false;
          });
        }
      );
    })
  ];

  nixpkgs.config = baseConfig // {
    allowUnfree = true;
    android_sdk.accept_license = true;
    pulseaudio = true;

    packageOverrides =
      let
        unstable = import <nixos-unstable> { config = baseConfig; };
      in
      pkgs: {
        inherit unstable;
        jre = pkgs.jdk11;
        fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz") { };
        micasa = micasa-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
        llm-agents = llm-agents-flake.packages.${pkgs.stdenv.hostPlatform.system};
      };
  };

  console.useXkbConfig = true;

  time.timeZone = "Europe/Rome";

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AcceptEnv = [
          "VTE_VERSION"
          "TERM"
          "COLORTERM"
          "TERMPROGRAM"
        ];
      };
    };
    sanoid = {
      templates.safe = {
        hourly = 12;
        daily = 10;
        monthly = 2;
        autoprune = true;
        autosnap = true;
      };
    };
  };
}
