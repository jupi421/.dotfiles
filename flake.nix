{
  description = "main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	#xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        #inherit system; 
		specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      jay = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
		modules = [ ./home.nix ];
      };
    };
  };

}
