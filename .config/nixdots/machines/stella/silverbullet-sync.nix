    { config, pkgs, ... }:
let
  space = config.services.silverbullet.spaceDir;
  key = "/data/silverbullet/id_ed25519";
in {
  systemd.tmpfiles.rules = [
    "d /data/silverbullet/ 0700 silverbullet silverbullet -"
  ];
  programs.ssh.knownHosts.stella.publicKeyFile = "/etc/ssh/ssh_host_ed25519_key.pub";

  systemd.services.silverbullet-git-sync = {
    path = [ pkgs.git pkgs.openssh ];
    serviceConfig = {
      Type = "oneshot";
      User = "silverbullet";
      Group = "silverbullet";
      WorkingDirectory = space;
      Environment = [
        "HOME=/data/silverbullet"
        "GIT_SSH_COMMAND='ssh -i ${key} -o IdentitiesOnly=yes'"
        "GIT_AUTHOR_NAME=silverbullet" "GIT_AUTHOR_EMAIL=silverbullet@stella"
        "GIT_COMMITTER_NAME=silverbullet" "GIT_COMMITTER_EMAIL=silverbullet@stella"
      ];
      ExecStart = pkgs.writeShellScript "sb-git-sync" ''
        set -euo pipefail
        git add -A
        git diff --cached --quiet || git commit -m "snapshot $(date -Is)"
        git pull --rebase --autostash
        git push
      '';
    };
  };

  systemd.timers.silverbullet-git-sync = {
    wantedBy = [ "timers.target" ];
    timerConfig = { OnBootSec = "2m"; OnUnitActiveSec = "5m"; Persistent = true; };
  };
}

