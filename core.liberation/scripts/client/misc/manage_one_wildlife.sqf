waitUntil {sleep 1; !isNil "sectors_allSectors" };
waitUntil {sleep 1; GRLIB_player_spawned};

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 30));

	private _spawn_life = (
		diag_fps > 35 && alive player && vehicle player == player &&
		!([player, "LHD", GRLIB_sector_size] call F_check_near) &&
		(player distance2D (getmarkerpos GRLIB_respawn_marker)) > GRLIB_sector_size &&
		!(([ GRLIB_sector_size, getPosATL player ] call F_getNearestSector) in sectors_bigtown)
	);

	if (_spawn_life) then {
		private _unit = player;
		private _managed_units = ([getPos _unit] call F_spawnWildLife);

		waitUntil {
			sleep 20;
			( GRLIB_global_stop == 1 || (diag_fps < 20) || (!alive _unit) || ({alive _x} count _managed_units) == 0 || ({_unit distance2D _x > GRLIB_sector_size || surfaceIsWater (getPos _x)} count _managed_units) > 0 )
		};

		{ deleteVehicle _x } forEach _managed_units;
		diag_log format [ "Done Delete wildlife at %1", time ];
	};
};
