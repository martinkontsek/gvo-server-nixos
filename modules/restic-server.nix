{ pkgs, ... }:
{
  services.restic.server = {
    enable = true;
    extraFlags = [ "--no-auth" ];
    dataDir = "/data/restic";
  };

}
