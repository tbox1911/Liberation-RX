private _managed_units = [];

private ["_unit", "_spawn_life"];
while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 30));

	_unit = selectRandom (AllPlayers - (entities "HeadlessClient_F"));
	if (isNil "_unit") exitWith {};
	_spawn_life = (
		diag_fps > 35 && alive _unit && isNull objectParent _unit &&
		!([_unit, "LHD", GRLIB_sector_size] call F_check_near) &&
		(_unit distance2D (markerPos GRLIB_respawn_marker)) > GRLIB_sector_size &&
		!(([ GRLIB_sector_size ] call F_getNearestSector) in sectors_bigtown)
	);

	if (_spawn_life) then {
		_managed_units = ([getPos _unit] call F_spawnWildLife);
		//diag_log format [ "Done Spawning wildlife %1 %2 near %3 at %4", count _managed_units, typeOf (_managed_units select 0), name _unit, time ];
		waitUntil {
			sleep 42;
			(
				GRLIB_global_stop == 1 || (diag_fps < 20) ||
				({alive _x} count _managed_units) == 0 ||
				({_unit distance2D _x > GRLIB_sector_size} count _managed_units) > 0 
			)
		};

		//diag_log format ["Delete (%1) wildlife at %2", count _managed_units, time];
		{ deleteVehicle _x } forEach _managed_units;
	};
};
