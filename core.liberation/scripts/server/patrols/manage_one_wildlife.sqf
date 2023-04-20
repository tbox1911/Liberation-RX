waitUntil {sleep 1; !isNil "sectors_allSectors" };

while { GRLIB_endgame == 0 } do {
	sleep (30 + floor(random 30));

	private _unit_lst = [allPlayers, {
		alive _x && vehicle _x == _x && isPlayer _x &&
		(_x distance2D lhd) > GRLIB_sector_size &&
		(_x distance2D (getmarkerpos GRLIB_respawn_marker)) > GRLIB_sector_size &&
		(_x distance2D ([getPos _x] call F_getNearestFob)) > GRLIB_sector_size &&
		!(([ GRLIB_sector_size, getPos _x ] call F_getNearestSector) in sectors_bigtown)
	}] call BIS_fnc_conditionalSelect;

	if (count _unit_lst > 0) then {
		private _unit = selectRandom _unit_lst;
		private _managed_units = ([getPos _unit] call F_spawnWildLife);
		sleep 1;

		waitUntil {
			sleep (30 + floor(random 30));
			( (!alive _unit) || ({alive _x} count _managed_units) == 0 || ({_unit distance2D _x > GRLIB_sector_size} count _managed_units) > 0 )
		};

		{ deleteVehicle _x } forEach _managed_units;
		diag_log format [ "Done Delete wildlife at %1", time ];
	};
};
