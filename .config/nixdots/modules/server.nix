{ config, pkgs, options, ... }: {
  environment = {
    systemPackages = with pkgs; [
      cachix
      yadm

      bash
      fish
      nix-your-shell

      lsof
      procs

      bc
      ouch
      curl
      fzf
      bashmount

      eza
      fd
      ripgrep
      bat
      sd
      dua
      duf
      procs

      nix-index

      neovim

      nil
      statix
      nixfmt-rfc-style
      sumneko-lua-language-server
      stylua

      git
      gitAndTools.delta
    ];
    variables = { EDITOR = "nvim"; };
    shells = [ pkgs.bash pkgs.fish ];
  };

  programs = {
    fish = {
      enable = true;
      promptInit = ''
        nix-your-shell fish | source
      '';
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batgrep ];
    };
    bash.completion.enable = true;
    direnv.enable = true;
    htop.enable = true;
    starship.enable = true;
    pay-respects.enable = true;
    yazi.enable = true;
  };

  users = { defaultUserShell = pkgs.fish; };
}
