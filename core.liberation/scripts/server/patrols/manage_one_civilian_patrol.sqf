private [
	"_usable_sectors",
	"_sectorpos",
	"_radius",
	"_civ_grp",
	"_civ_veh",
	"_unit_ttl",
	"_unit_pos"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 150));
	while { civcap > GRLIB_civilians_amount || (diag_fps < 20) } do {
		sleep 60;
	};

	_civ_veh = objNull;
	_civ_grp = grpNull;
	_usable_sectors = [];
	{
		if ( (count ([markerPos  _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) ) then {
			_usable_sectors pushback _x;
		};
		sleep 0.1;
	} foreach (sectors_bigtown + sectors_capture + sectors_factory + sectors_opfor - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_sectorpos = markerPos (selectRandom _usable_sectors);
		// 40% in vehicles
		if ( floor random 100 >= 60) then {
			_veh_class = selectRandom civilian_vehicles;
			_civ_veh = [_sectorpos, _veh_class, 3, false, GRLIB_side_civilian] call F_libSpawnVehicle;
			_civ_grp = group (driver _civ_veh);
			[_civ_grp, _sectorpos] spawn add_civ_waypoints;
			[_civ_veh] spawn civilian_ai_veh;
		} else {
			private _rndciv = [1,1,1,1,2,3];
			_civ_grp = [_sectorpos, (selectRandom _rndciv)] call F_spawnCivilians;
		};

		if (local _civ_grp) then {
			private _hc = [] call F_lessLoadedHC;
			if (!isNull _hc) then {
				_civ_grp setGroupOwner (owner _hc);
			};
		};

		// Wait
		_radius = GRLIB_spawn_max;
		if (_civ_veh isKindOf "Air") then {
			sleep 120;
			_radius = GRLIB_spawn_max * 2;
		};
		_unit_ttl = round (time + 1800);
		_unit_pos = getPosATL (leader _civ_grp);
		waitUntil {
			if (alive (leader _civ_grp)) then { _unit_pos = getPosATL (leader _civ_grp) };
			sleep 60;
			(
				GRLIB_global_stop == 1 ||
				(diag_fps < 25) ||
				({alive _x} count (units _civ_grp) == 0) ||
				([_unit_pos, _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
				(time > _unit_ttl)
			)
		};

		// Cleanup
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_unit_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		[_civ_veh] call clean_vehicle;
		{ deleteVehicle _x } forEach (units _civ_grp);
		deleteGroup _civ_grp;
	};
};