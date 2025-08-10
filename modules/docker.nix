{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ docker-compose ];

  # Docker can also be run rootless
  virtualisation.docker = {
    enable = true;
  };
  # User permissions 
  users.users.kontsek.extraGroups = [ "docker" ];
}
