{ pkgs, ... }:
{
  virtualisation.incus.enable = true;
  
  virtualisation.incus.preseed = {
    profiles = [
      {
        devices = {
          eth0 = {
            name = "eth0";
	    nictype = "macvlan";
            parent = "sw0.3";
            type = "nic";
          };
          root = {
            path = "/";
            pool = "lxd-data1";
            type = "disk";
          };
        };
        name = "default";
      }
    ];
    storage_pools = [
      {
        config = {
          source = "/data/lxd/storage-pools/lxd-data1";
        };
        driver = "dir";
        name = "lxd-data1";
      }
    ];
  };

  networking.nftables.enable = true;
  users.users.kontsek.extraGroups = [ "incus-admin" ];

}
