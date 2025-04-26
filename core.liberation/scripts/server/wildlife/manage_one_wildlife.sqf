sleep (30 + floor(random 30));

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	while { diag_fps <= 35 } do { sleep 60 };
	private _unit = selectRandom (AllPlayers - (entities "HeadlessClient_F"));
	if (isNil "_unit") exitWith {};

	private _spawn_life = (
		alive _unit && isNull objectParent _unit &&
		!([_unit, "LHD", GRLIB_sector_size] call F_check_near) &&
		(_unit distance2D (markerPos GRLIB_respawn_marker)) > GRLIB_sector_size &&
		!(([GRLIB_sector_size, _unit] call F_getNearestSector) in sectors_bigtown)
	);

	if (_spawn_life) then {
		// Create wildlife
		private _spawn_pos = _unit getPos [100 + floor random 100, floor random 360];
		private _managed_units = ([_spawn_pos] call F_spawnWildLife);

		// Loop
		waitUntil {
			sleep 42;
			(
				GRLIB_global_stop == 1 || (diag_fps < 25) ||
				({alive _x} count _managed_units) == 0 ||
				({_unit distance2D _x > GRLIB_sector_size} count _managed_units) > 0 
			)
		};

		// Cleanup
		{ deleteVehicle _x; sleep 0.1 } forEach _managed_units;
	};

	sleep 30;
};
