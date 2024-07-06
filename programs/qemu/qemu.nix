{ config, pkgs, lib, ... }:

{
	services.qemuGuest = {
		enable = true;
		vms = {
			eosVM = {
				memorySize = "2048M";
				disk Size = "10G";
				diskImage = /home/jay/.VM/
				installationMedia = ./images/EndeavourOS_Endeavour-2024.06.25.iso;
				sharedFolders = {
					"/home/VMShared/" = "/home/VMShared";
				};
			};
		};
	};

	networking.bridges.virbr0.interfaces = [];
	  networking.interfaces.virbr0.ipv4.addresses = lib.mkOverride 0 [
		{ address = "192.168.122.1"; prefixLength = 24; }
	  ];
	
	environment.systemPackages = with pkgs; [
		qemu
	];
