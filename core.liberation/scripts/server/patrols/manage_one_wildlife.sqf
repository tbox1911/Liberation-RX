waitUntil {sleep 1; !isNil "sectors_allSectors" };

while { GRLIB_endgame == 0 } do {
	sleep (30 + random 60);

	private _unit = selectRandom (allPlayers - (entities "HeadlessClient_F"));
	private _fobdistance = round (_unit distance2D ([] call F_getNearestFob));
	private _sector = [ GRLIB_sector_size, getPos _unit ] call F_getNearestSector;

	if (_unit distance2D lhd >= GRLIB_sector_size && _fobdistance > GRLIB_sector_size && vehicle _unit == _unit && !(_sector in sectors_bigtown)) then {
		private _managed_units = ( [ getPos _unit ] call F_spawnWildLife );
		sleep 0.2;

		while { ({alive _x} count _managed_units) > 0 && ({_unit distance2D _x > GRLIB_sector_size} count _managed_units) == 0 && alive _unit } do { sleep (10 + random 10) };
		{ deleteVehicle _x } forEach _managed_units;
		diag_log format [ "Done Delete wildlife at %1", time ];
	};

};
