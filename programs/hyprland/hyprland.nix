{ pkgs, lib, inputs, ... }:

let
	startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
		swww init &
		sleep 1
		swww img ${/home/jay/Pictures/Wallpapers/Mountains-Nord.jpg} &
		ags
	'';
in {
	home.packages = with pkgs; [
		swww
		bibata-cursors
	];

	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;


		settings = {

			exec-once = [
				"${startupScript}/bin/start"
			];

			monitor = ", 2560x1440@165, auto, auto";
			"$terminal" = "kitty";
			"$filebrowser" = "thunar";

			env = [
				"QT_QPA_PLATFORM,wayland"
				"QT_QPA_PLATFORMTHEME,qt5ct"
			];
			
			general = { 
				gaps_in = 5;
				gaps_out = 5;

				border_size = 3;

				#"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				#"col.inactive_border" = "rgba(595959aa)";

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
				#"col.shadow" = "rgba(1a1a1aee)";

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
				disable_hyprland_logo = false;
				vrr = 2;
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
				"$super, RETURN, exec, $terminal"

				"$super, W, exec, firefox"
				"$super, C, killactive,"
				"$super, E, exec, $fileManager"
				"$super, F, togglefloating,"
				"$super, R, exec, $menu"
				"$super, P, pseudo, # dwindle"
				"$super, J, togglesplit, # dwindle"
				"$super, D, exec, rofi -modi drun -show drun -show-icons -config ~/.config/rofi/rofidmenu.rasi"

				"$super, H, movefocus, l"
				"$super, S, movefocus, r"
				"$super, N, movefocus, u"
				"$super, T, movefocus, d"

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

				"$super, M, togglespecialworkspace, magic"
				"$super shift, M, movetoworkspace, special:magic"

				"$super, mouse_down, workspace, e+1"
				"$super, mouse_up, workspace, e-1"

			];

			bindm = [
				"$super, mouse:272, movewindow"
				"$super, mouse:273, resizewindow"
			];

			binde = [
				", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
				", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
				", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
				", XF86MonBrightnessUp, exec, brightnessctl set +10%"
				", XF86MonBrightnessDown, exec, brightnessctl set -10%"
			];

			bindl = [
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPrev, exec, playerctl previous"
				", XF86AudioNext, exec, playerctl next"
			];


			windowrulev2 = [
				"suppressevent maximize, class:.*"
				"workspace 1, class:(kitty)$, title:(kitty)$"
				"workspace 2, initialTitle:(Mozilla Firefox)$"
				"workspace 5, class:(org.telegram.desktop)$, initialTitle:(Telegram)$"
				"float, class:(org.telegram.desktop)$, initialTitle:^(?!.*Telegram*.)$"
				"workspace 5, class:(whatsapp-for-linux)$"
				"workspace 7, class:(webcord)$, title:(webcord)$"
				"workspace 9, initialTitle:^(Spotify( Premium)?)$"
			];
		};

		extraConfig = ''
			bind = $super, R, submap, resize

			submap = resize
			binde = , S, resizeactive, 20 0
			binde = , H, resizeactive, -20 0
			binde = , T, resizeactive, 0 20
			binde = , N, resizeactive, 0 -20
			bind = , escape, submap, reset
			submap = reset
		'';
	};

}
