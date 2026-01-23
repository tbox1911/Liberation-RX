params ["_level"];

diag_log format ["--- LRX Enemy Patrol - trigger alert %1", _level];

GRLIB_patrol_current = GRLIB_patrol_current + 1;
publicVariable "GRLIB_patrol_current";

sleep (60 + (floor random 120));
while { combat_readiness < _level } do { sleep 120 };

private _opfor_veh = objNull;
private _opfor_grp = grpNull;
private _search_sectors_all = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors - GRLIB_patrol_sectors);
private _search_sectors = _search_sectors_all select {
	(count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) &&
	(count ([markerPos _x, GRLIB_sector_size] call F_getNearbyPlayers) == 0)
};

if (count _search_sectors > 0) then {
	private _sector = selectRandom _search_sectors;
	private _sector_pos = markerPos _sector;
	// 50% in vehicles
	if (floor random 100 > 50 && count militia_vehicles > 0) then {
		private _veh_type = selectRandom militia_vehicles;
		_opfor_veh = [_sector_pos, _veh_type, 3, GRLIB_side_enemy, "militia", true, true] call F_libSpawnVehicle;
		_opfor_grp = group (driver _opfor_veh);
		[_opfor_grp, _sector_pos, _opfor_veh] spawn add_civ_waypoints_veh;
		diag_log format ["--- LRX Enemy Patrol %1 (%2)", _opfor_grp, _veh_type];
	} else {
		_opfor_grp = [_sector_pos, (6 + floor random 6), "militia", false] call createCustomGroup;
		if (floor random 4 == 0) then {
			[_opfor_grp, _sector_pos, objNull] spawn add_civ_waypoints_veh;
		} else {
			[_opfor_grp, _sector_pos] spawn add_civ_waypoints;
		};
		diag_log format ["--- LRX Enemy Patrol %1", _opfor_grp];
	};

	sleep 1;
	if (isNull _opfor_grp) exitWith { deleteVehicle _opfor_veh };

	GRLIB_patrol_sectors pushBackUnique _sector;
	publicVariable "GRLIB_patrol_sectors";

	// Waiting
	private _unit_ttl = round (time + 1800);
	private _unit_pos = getPosATL (leader _opfor_grp);
	waitUntil {
		sleep 60;
		if (diag_fps <= 15) exitWith { true };
		if (alive (leader _opfor_grp)) then { _unit_pos = getPosATL (leader _opfor_grp) };
		(
			GRLIB_global_stop == 1 || (time > _unit_ttl) || ({alive _x} count (units _opfor_grp) == 0) ||
			([_unit_pos, GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount == 0)
		)		
	};

	// Cleanup
	waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_unit_pos, GRLIB_spawn_min, GRLIB_side_friendly] call F_getUnitsCount == 0) };

	if (isNull _opfor_veh) then {
		{ deleteVehicle _x } forEach (units _opfor_grp);
	} else {
		[_opfor_veh] call F_vehicleClean;
	};
	deleteGroup _opfor_grp;

	sleep 600;
	GRLIB_patrol_sectors = GRLIB_patrol_sectors - [_sector];
	publicVariable "GRLIB_patrol_sectors";
};

GRLIB_patrol_current = GRLIB_patrol_current - 1;
publicVariable "GRLIB_patrol_current";
