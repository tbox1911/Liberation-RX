private [ "_lhd_x", "_lhd_y", "_lhd_z", "_spread", "_rotation", "_posx", "_posy" ];

player setPosATL (getposATL lhd vectorAdd [floor(random 5), floor(random 5), 0]);
GRLIB_player_spawned = ([] call F_getValid);
cinematic_camera_started = false;
