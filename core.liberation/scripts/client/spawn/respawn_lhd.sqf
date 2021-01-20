private [ "_lhd_x", "_lhd_y", "_lhd_z", "_spread", "_rotation", "_posx", "_posy" ];

player setposasl (getposasl lhd vectorAdd [random 5, random 5, GRLIB_spawn_altitude]);
GRLIB_player_spawned = ([] call F_getValid);

