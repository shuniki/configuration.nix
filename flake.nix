{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #stylix.url = "github:danth/stylix";
    
     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."shuniki" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [ 
      #inputs.stylix.nixosModules.stylix
      ./configuration.nix
      inputs.home-manager.nixosModules.default
     ];
    };
  };
}
