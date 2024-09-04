{ pkgs, lib, inputs, ... }:
let
	terminal = "kitty";
in {
	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;


		settings = {

			monitor = ", 2560x1440@165, auto, auto";
			#"$terminal" = "kitty";
			env = [
				"XCURSOR_SIZE,20"
				"HYPRCURSOR_SIZE,24"
			];
			
			general = { 
				gaps_in = 5;
				gaps_out = 20;

				border_size = 2;

				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";

				resize_on_border = false;

				allow_tearing = false;

				layout = "dwindle";
			};

			decoration = {
				rounding = 10;

				active_opacity = 1.0;
				inactive_opacity = 1.0;

				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";

				blur = {
					enabled = true;
					size = 3;
					passes = 1;

					vibrancy = 0.1696;
				};
			};

			animations = {
				enabled = true;

				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

				animation = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"borderangle, 1, 8, default"
					"fade, 1, 7, default"
					"workspaces, 1, 6, default"
				];
			};

			dwindle = {
				pseudotile = true;
				preserve_split = true; 
			};

			master = {
				new_status = "master";
			};

			misc = { 
				force_default_wallpaper = -1; 
				disable_hyprland_logo = false;
			};

			input = {
				kb_layout = "us";
				kb_variant = "dvorak";

				follow_mouse = 1;

				sensitivity = 0; 

				touchpad = {
					natural_scroll = false;
				};
			};

			gestures = {
				workspace_swipe = false;
			};

			device = {
				name = "epic-mouse-v1";
				sensitivity = -0.5;
			};


			"$super" = "SUPER"; 

			bind = [
				''$super, RETURN, exec,	"${terminal}"''
				"$super, W, exec, wezterm"

				"$super, C, killactive,"
				"$super, M, exit,"
				"$super, E, exec, $fileManager"
				"$super, V, togglefloating,"
				"$super, R, exec, $menu"
				"$super, P, pseudo, # dwindle"
				"$super, J, togglesplit, # dwindle"

				"$super, left, movefocus, l"
				"$super, right, movefocus, r"
				"$super, up, movefocus, u"
				"$super, down, movefocus, d"

				"$super, 1, workspace, 1"
				"$super, 2, workspace, 2"
				"$super, 3, workspace, 3"
				"$super, 4, workspace, 4"
				"$super, 5, workspace, 5"
				"$super, 6, workspace, 6"
				"$super, 7, workspace, 7"
				"$super, 8, workspace, 8"
				"$super, 9, workspace, 9"
				"$super, 0, workspace, 10"

				"$super shift, 1, movetoworkspace, 1"
				"$super shift, 2, movetoworkspace, 2"
				"$super shift, 3, movetoworkspace, 3"
				"$super shift, 4, movetoworkspace, 4"
				"$super shift, 5, movetoworkspace, 5"
				"$super shift, 6, movetoworkspace, 6"
				"$super shift, 7, movetoworkspace, 7"
				"$super shift, 8, movetoworkspace, 8"
				"$super shift, 9, movetoworkspace, 9"
				"$super shift, 0, movetoworkspace, 10"

				"$super, s, togglespecialworkspace, magic"
				"$super shift, s, movetoworkspace, special:magic"

				"$super, mouse_down, workspace, e+1"
				"$super, mouse_up, workspace, e-1"
			];


			windowrulev2 = "suppressevent maximize, class:.*"; 
		};
	};
}
