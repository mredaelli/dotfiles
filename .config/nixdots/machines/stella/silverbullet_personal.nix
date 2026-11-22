{
  config,
  pkgs,
  lib,
  ...
}:
let
  sb2 = {
    name = "personal"; # used for unit/user/group names
    domain = "personal.typish.io"; # change me
    port = 9199;
    spaceDir = "/data/syncthing/data/nextcloud/kb/"; # vault location
    dbPath = "/data/silverbullet-personal/db.sqlite";
    envFile = null; # "/var/secrets/silverbullet-personal";  # optional; set to null to omit
  };
in
{
  # ── Instance 2 ─────────────────────────────────────────────────────────────
  users.users."silverbullet-${sb2.name}" = {
    isSystemUser = true;
    group = "silverbullet-${sb2.name}";
    description = "Silverbullet (${sb2.name}) daemon user";
  };
  users.groups."silverbullet-${sb2.name}" = { };
  users.users.nextcloud.extraGroups = [ "silverbullet-${sb2.name}" ];

  # Create the DB directory (space dir is handled via StateDirectory below).
  systemd.tmpfiles.rules = [
    # DB dir: private to Silverbullet.
    "d ${dirOf sb2.dbPath}    0750 silverbullet-${sb2.name} silverbullet-${sb2.name} -"
  ];

  systemd.services."silverbullet-${sb2.name}" = {
    description = "Silverbullet service (${sb2.name})";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "silverbullet-${sb2.name}";
      Group = "silverbullet-${sb2.name}";
      EnvironmentFile = lib.mkIf (sb2.envFile != null) sb2.envFile;
      Environment = [ "SB_KV_DB=${sb2.dbPath}" ];
      UMask = "0007"; # new files group-writable, so Nextcloud can edit them
      ExecStart = ''
        ${lib.getExe pkgs.unstable.silverbullet} --port ${toString sb2.port} --hostname '127.0.0.1' '${sb2.spaceDir}'
      '';
      Restart = "on-failure";
    };
  };

  services.nginx.virtualHosts.${sb2.domain} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:${toString sb2.port};
        proxy_pass_request_headers on;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
      '';
    };
  };
}
