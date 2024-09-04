{
	description = "main setup";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		#hyprland-plugins = {
		#	url = "github:hyprwm/hyprland-plugins";
		#	inputs.hyprland.follows = "hyprland";
		#};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: 
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
			commonConfiguration = ./profiles/personal/configuration.nix;
			commonHomeConfiguration = ./profiles/personal/home.nix;
		in {
			nixosConfigurations = {
				pc = lib.nixosSystem {
					specialArgs = { inherit inputs; };
					inherit system; 
					modules = [
						commonConfiguration
						./hardware/hardware-configuration-pc.nix
						./programs/syncthing/syncthing-pc.nix
						./profiles/personal/is-pc.nix
					];
				};
				office-pc = lib.nixosSystem {
					specialArgs = { inherit inputs; };
					inherit system; 
					modules = [
						commonConfiguration
						./hardware/hardware-configuration-office.nix
					];
				};
				laptop = lib.nixosSystem {
					specialArgs = { inherit inputs; };
					inherit system; 
					modules = [
						commonConfiguration
						./hardware/hardware-configuration-laptop.nix
						./programs/syncthing/syncthing-laptop.nix
						./suspend-then-hibernate.nix
						./profiles/personal/is-laptop.nix
					];
				};
			};
			homeConfigurations = {
				jay-laptop = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = { inherit inputs; };
					modules = [ 
						commonHomeConfiguration
						./programs/eww/eww-laptop.nix
					];
				};
				jay-pc = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = { inherit inputs; };
					modules = [ 
						commonHomeConfiguration
						./programs/eww/eww-pc.nix
						./programs/gaming/proton/proton.nix
						./programs/gaming/bottles/bottles.nix
					];
				};
				office-pc = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = { inherit inputs; };
					modules = [ 
						./profiles/office/home.nix 
						./programs/eww/eww-pc.nix
					];
				};
			};
		};

}
