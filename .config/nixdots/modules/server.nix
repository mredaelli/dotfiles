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

      bc
      ouch
      curl
      fzf
      bashmount
      direnv

      eza
      yazi
      fd
      ripgrep
      bat
      sd
      dua
      procs

      zoxide
      starship
      nix-your-shell

      neovim
      nixpkgs-fmt

      git
      gitAndTools.delta
    ];
    variables = {
      EDITOR = "nvim";
    };
    shells = [ pkgs.bash pkgs.fish ];
  };

  programs = {
    fish = {
      enable = true;
      promptInit = ''
        nix-your-shell fish | source
      '';
    };
    bash.completion.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
  };
}
