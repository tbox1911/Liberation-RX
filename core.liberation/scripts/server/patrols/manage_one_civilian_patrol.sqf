GRLIB_civilians_current = GRLIB_civilians_current + 1;
publicVariable "GRLIB_civilians_current";

sleep (30 + (floor random 150));
while { diag_fps <= 20 } do { sleep 60 };

private _civ_veh = objNull;
private _civ_grp = grpNull;
private _usable_sectors = [];
private _search_sectors = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors) call BIS_fnc_arrayShuffle;
{
	if (count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) then {
		_usable_sectors pushback _x;
	};
	sleep 0.1;
} foreach _search_sectors;

if (count _usable_sectors > 0) then {
	private _sector_pos = markerPos (selectRandom _usable_sectors);
	// 40% in vehicles
	if (floor random 100 >= 60) then {
		private _spread = 3;
		private _spawn_pos = [(((_sector_pos select 0) + (75 * _spread)) - (floor random (150 * _spread))),(((_sector_pos select 1) + (75 * _spread)) - (floor random (150 * _spread))), 0.5];
		_civ_veh = [_spawn_pos, (selectRandom civilian_vehicles), 3, false, GRLIB_side_civilian, false] call F_libSpawnVehicle;
		_civ_grp = [_civ_veh, GRLIB_side_civilian, false] call F_forceCrew;
		[_civ_veh, _civ_grp] spawn civilian_ai_veh;
		_civ_veh lockCargo true;
		_civ_veh lockDriver true;
		{ _civ_veh lockTurret [_x, true] } forEach (allTurrets _civ_veh);
		_civ_veh setVehicleLock "LOCKED";
		[_civ_grp, _sector_pos, _civ_veh] call add_civ_waypoints_veh;
	} else {
		_civ_grp = [_sector_pos] call F_spawnCivilians;
		if (floor random 4 == 0) then {
			[_civ_grp, _sector_pos, objNull] call add_civ_waypoints_veh;
		} else {
			[_civ_grp, _sector_pos] call add_civ_waypoints;
		};
	};

	sleep 1;
	if (isNull _civ_grp) exitWith { deleteVehicle _civ_veh };
	sleep 60;

	// Waiting
	private _unit_ttl = round (time + 1800);
	private _unit_pos = getPosATL (leader _civ_grp);
	waitUntil {
		sleep 60;
		_unit_pos = getPosATL (leader _civ_grp);
		(
			GRLIB_global_stop == 1 || (time > _unit_ttl) || ({alive _x} count (units _civ_grp) == 0) ||
			([_unit_pos, GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount == 0)
		)
	};

	// Cleanup
	waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_unit_pos, GRLIB_spawn_min, GRLIB_side_friendly] call F_getUnitsCount == 0) };
	if (isNull _civ_veh) then {
		{ deleteVehicle _x } forEach (units _civ_grp);
	} else {
		[_civ_veh] call clean_vehicle;
	};
	deleteGroup _civ_grp;
};

GRLIB_civilians_current = GRLIB_civilians_current - 1;
publicVariable "GRLIB_civilians_current";
