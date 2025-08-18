{
  description = "GVO server flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {

    nixosConfigurations = {
      server1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server1/configuration.nix
        ]; 
      };

      server2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server2/configuration.nix
        ]; 
      };

      nas = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nas/configuration.nix
        ]; 
      };

    };
  };
}
