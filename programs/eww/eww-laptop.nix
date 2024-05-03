{ config, pkgs, input, ... }:

{
  home.packages = with pkgs; [
	eww
  ];

  home.file = {
	".config/eww".source = ./eww_laptop;
  };
}
