private [
	"_usable_sectors",
	"_sector_pos",
	"_radius",
	"_civ_grp",
	"_civ_veh",
	"_unit_ttl",
	"_unit_pos"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + (floor random 150));
	while { civcap > GRLIB_civilians_amount || (diag_fps < 20) } do {
		sleep 60;
	};

	_civ_veh = objNull;
	_civ_grp = grpNull;
	_usable_sectors = [];
	{
		if ( (count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) ) then {
			_usable_sectors pushback _x;
		};
		sleep 0.1;
	} foreach (sectors_allSectors + sectors_opforSpawn - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_sector_pos = markerPos (selectRandom _usable_sectors);
		// 40% in vehicles
		if (floor random 100 >= 60) then {
			_civ_veh = [_sector_pos, (selectRandom civilian_vehicles), 3, false, GRLIB_side_civilian] call F_libSpawnVehicle;
			if !(isNull _civ_veh) then { _civ_grp = group (driver _civ_veh) };
		} else {
			_civ_grp = [_sector_pos] call F_spawnCivilians;
		};

		if (isNull _civ_grp) exitWith {};

		private _hc = [] call F_lessLoadedHC;
		if (!isNull _hc) then {
			_civ_grp setGroupOwner (owner _hc);
			sleep 1;
		};

		if (isNull _civ_veh) then {
			[_civ_grp, _sector_pos] spawn civilian_ai;
		} else {
			[_civ_grp, _sector_pos] spawn add_civ_waypoints;
			[_civ_veh] spawn civilian_ai_veh;
		};

		sleep 60;

		// Wait
		_unit_ttl = round (time + 1800);
		_unit_pos = getPosATL (leader _civ_grp);
		_radius = GRLIB_spawn_max * 2;
		waitUntil {
			if (alive (leader _civ_grp)) then { _unit_pos = getPosATL (leader _civ_grp) };
			sleep 60;
			if (round (speed vehicle leader _civ_grp) == 0) then {[leader _civ_grp] spawn F_fixPosUnit };
			(
				GRLIB_global_stop == 1 ||
				(diag_fps < 25) ||
				({alive _x} count (units _civ_grp) == 0) ||
				([_unit_pos, _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
				(time > _unit_ttl)
			)
		};

		// Cleanup
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || (diag_fps < 25) || [_unit_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		[_civ_veh] call clean_vehicle;
		{ deleteVehicle _x } forEach (units _civ_grp);
		deleteGroup _civ_grp;
	};
};