private _civ_veh = objNull;
private _civ_grp = grpNull;
private _sector_pos = markerPos (selectRandom GRLIB_civilian_sectors_list);
if ([_sector_pos, GRLIB_spawn_max, GRLIB_side_civilian, 11] call F_getUnitsCount > 10) exitWith {};

GRLIB_civilians_current = GRLIB_civilians_current + 1;
publicVariable "GRLIB_civilians_current";

// 40% in vehicles
if (floor random 100 >= 60) then {
	private _spread = 3;
	private _spawn_pos = [(((_sector_pos select 0) + (75 * _spread)) - (floor random (150 * _spread))),(((_sector_pos select 1) + (75 * _spread)) - (floor random (150 * _spread))), 0.5];
	_civ_veh = [_spawn_pos, (selectRandom civilian_vehicles), 3, GRLIB_side_civilian, "", true, true] call F_libSpawnVehicle;
	_civ_grp = group (driver _civ_veh);
	if (isNull _civ_grp) exitWith {};
	[_civ_veh, _civ_grp] spawn civilian_ai_veh;
	_civ_veh lockCargo true;
	_civ_veh lockDriver true;
	{ _civ_veh lockTurret [_x, true] } forEach (allTurrets _civ_veh);
	_civ_veh setVehicleLock "LOCKED";
	[_civ_grp, _sector_pos, _civ_veh] call add_civ_waypoints_veh;
} else {
	_civ_grp = [_sector_pos] call F_spawnCivilians;
	if (isNull _civ_grp) exitWith {};
	{ [_x] call F_fixPosUnit } forEach (units _civ_grp);
	if (floor random 4 == 0) then {
		[_civ_grp, _sector_pos, objNull] call add_civ_waypoints_veh;
	} else {
		[_civ_grp, _sector_pos] call add_civ_waypoints;
	};
};

sleep 1;
if (isNull _civ_grp || count (units _civ_grp) == 0) exitWith {
	deleteVehicle _civ_veh;
	GRLIB_civilians_current = (GRLIB_civilians_current - 1) max 0;
	publicVariable "GRLIB_civilians_current";
};

// Waiting
private _unit_ttl = round (time + 1800);
private _unit_pos = getPosATL (units _civ_grp select 0);
private _unit_range = GRLIB_spawn_max;
if (_civ_veh isKindOf "LandVehicle") then { _unit_range = GRLIB_spawn_max * 1.5 };
if (_civ_veh isKindOf "Air") then { _unit_range = GRLIB_spawn_max * 2; sleep 60 };

if (isNull _civ_veh) then {
	waitUntil {
		sleep 60;
		if (diag_fps <= 25) exitWith { true };
		private _last_unit = (units _civ_grp) select { alive _x };
		if (count _last_unit > 0) then { _unit_pos = getPosATL (_last_unit select 0) };
		(
			GRLIB_global_stop == 1 || (time > _unit_ttl) || (count _last_unit == 0) ||
			([_unit_pos, _unit_range, GRLIB_side_friendly, 1] call F_getUnitsCount == 0)
		)
	};
} else {
	waitUntil {
		sleep 60;
		if (diag_fps <= 25) exitWith { true };
		private _last_unit = (units _civ_grp) select { alive _x };
		_unit_pos = getPosATL _civ_veh;
		(
			GRLIB_global_stop == 1 || (time > _unit_ttl) || (count _last_unit == 0) ||
			([_unit_pos, _unit_range, GRLIB_side_friendly, 1] call F_getUnitsCount == 0)
		)
	};
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || diag_fps <= 25 || [_unit_pos, GRLIB_spawn_max, GRLIB_side_friendly, 1] call F_getUnitsCount == 0) };

if (isNull _civ_veh) then {
	{ deleteVehicle _x } forEach (units _civ_grp);
} else {
	[_civ_veh] call F_vehicleClean;
};
deleteGroup _civ_grp;

GRLIB_civilians_current = (GRLIB_civilians_current - 1) max 0;
publicVariable "GRLIB_civilians_current";
