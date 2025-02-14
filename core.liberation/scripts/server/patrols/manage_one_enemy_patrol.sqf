params ["_level"];

diag_log format ["--- LRX Enemy Patrol - trigger alert %1", _level];

GRLIB_patrol_current = GRLIB_patrol_current + 1;
publicVariable "GRLIB_patrol_current";

sleep (10 + (floor random 60));
while { combat_readiness < _level } do { sleep 60 };

private _opfor_veh = objNull;
private _opfor_grp = grpNull;
private _usable_sectors = [];
private _search_sectors = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors) call BIS_fnc_arrayShuffle;
{
	if ((count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) && (count ([markerPos _x, GRLIB_capture_size] call F_getNearbyPlayers) == 0)) exitWith {
		_usable_sectors pushback _x;
	};
	sleep 0.1;
} foreach _search_sectors;

if (count _usable_sectors > 0) then {
	private  _sector_pos = markerPos (selectRandom _usable_sectors);
	// 50% in vehicles
	if (floor random 100 > 50 && count militia_vehicles > 0) then {
		_opfor_veh = [_sector_pos, (selectRandom militia_vehicles)] call F_libSpawnVehicle;
		if !(isNull _opfor_veh) then {
			_opfor_grp = group (driver _opfor_veh);
			[_opfor_grp, _sector_pos] spawn add_civ_waypoints;
			{ _x setVariable ["GRLIB_mission_AI", true, true] } forEach (units _opfor_grp);
		};
	} else {
		_opfor_grp = [_sector_pos, (6 + floor random 6), "militia", true, 200] call createCustomGroup;
	};

	sleep 1;
	if (isNil "_opfor_grp") exitWith {};
	private _veh_type = "No vehicle";
	if !(isNull _opfor_veh) then { _veh_type = typeOf _opfor_veh };
	diag_log format ["--- LRX Enemy Patrol %1 (%2)", _opfor_grp, _veh_type];

	// Wait
	private _unit_ttl = round (time + 1800);
	private _unit_pos = getPosATL (leader _opfor_grp);
	private _radius = GRLIB_spawn_max * 1.5;
	waitUntil {
		if (alive (leader _opfor_grp)) then { _unit_pos = getPosATL (leader _opfor_grp) };
		sleep 60;
		if (round (speed vehicle leader _opfor_grp) == 0) then {[leader _opfor_grp] spawn F_fixPosUnit };
		(
			GRLIB_global_stop == 1 ||
			({alive _x} count (units _opfor_grp) == 0) ||
			([_unit_pos, _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
			(time > _unit_ttl)
		)
	};

	// Cleanup
	waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_unit_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
	[_opfor_veh] spawn cleanMissionVehicles;
	{ deleteVehicle _x } forEach (units _opfor_grp);
	deleteGroup _opfor_grp;
};

GRLIB_patrol_current = GRLIB_patrol_current - 1;
publicVariable "GRLIB_patrol_current";
