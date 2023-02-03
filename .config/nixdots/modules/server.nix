{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      cachix
      yadm

      bash
      fish

      lsof
      procs
      htop
      bottom

      bc
      zip
      unzip
      curl
      fzf
      bashmount
      direnv

      exa
      ranger
      fd
      ripgrep
      bat
      sd
      dua
      procs

      zoxide
      starship
      any-nix-shell

      neovim
      nixpkgs-fmt

      git
      gitAndTools.delta

      lnav
    ];
    variables = {
      EDITOR = "nvim";
    };
    shells = [ pkgs.bash pkgs.fish ];
  };

  programs = {
    fish = {
      # enable = true;
      promptInit = ''
        any-nix-shell fish --info-right | source
      '';
    };
    bash.enableCompletion = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
  };
}
