{ config, pkgs, input, ... }:

{
  home.packages = with pkgs; [
	eww
  ];

  home.file = {
	".config/eww".source = ../../programs/eww_pc;
  };
}
