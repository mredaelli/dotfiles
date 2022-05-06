{ config, pkgs, ... }:
{
  services.postfix = {
    enable = true;
    domain = "typish.io";
  };
}
