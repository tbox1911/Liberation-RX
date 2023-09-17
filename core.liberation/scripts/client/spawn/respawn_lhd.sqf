player setVariable ["GRLIB_action_inuse", true, true];
player setPosATL (getposATL lhd vectorAdd [floor(random 5), floor(random 5), 0]);
GRLIB_player_spawned = ([] call F_getValid);
cinematic_camera_started = false;
sleep 3;
player setVariable ["GRLIB_action_inuse", false, true];
