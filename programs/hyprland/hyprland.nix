{ pkgs, lib, inputs, ... }:

{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			input = {
				kb_layout = "us";
				kb_variant = "dvorak";
			};

			monitor = ", 2560x1440@165, auto, auto";
			"$terminal" = "kitty";
			env = "XCURSOR_SIZE,20";
			
			general = { 
				gaps_in = 5;
				gaps_out = 20;

				border_size = 2;

				# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";

				# Set to true enable resizing windows by clicking and dragging on borders and gaps
				resize_on_border = false;

				# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
				allow_tearing = false;

				layout = "dwindle";
			};

			decoration = {
				rounding = 10;

				# Change transparency of focused and unfocused windows
				active_opacity = 1.0;
				inactive_opacity = 1.0;

				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";

				# https://wiki.hyprland.org/Configuring/Variables/#blur
				blur = {
					enabled = true;
					size = 3;
					passes = 1;

					vibrancy = 0.1696;
				};
			}
		};
	};
}
