params ["_level"];

GRLIB_patrol_current = GRLIB_patrol_current + 1;
publicVariable "GRLIB_patrol_current";

sleep (60 + (floor random 120));
while { opforcap > GRLIB_patrol_cap || (diag_fps < 35.0) || combat_readiness < _level } do {
	sleep 60;
};

private _opfor_veh = objNull;
private _opfor_grp = grpNull;
private _usable_sectors = [];
{
	if ( (count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) && (count ([markerPos _x, GRLIB_capture_size] call F_getNearbyPlayers) == 0) ) then {
		_usable_sectors pushback _x;
	};
	sleep 0.1;
} foreach (sectors_allSectors + sectors_opforSpawn - active_sectors);
{ _usable_sectors pushBack (_x select 0) } forEach SpawnMissionMarkers;

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

	if (isNull _opfor_grp) exitWith {};
	private _veh_type = "No vehicle";
	if !(isNull _opfor_veh) then { _veh_type = typeOf _opfor_veh };
	diag_log format ["--- LRX Spawn Enemy Patrol %1 (%2) - trigger alert %3", _opfor_grp, _veh_type, _level];


	sleep 60;

	// Wait
	private _unit_ttl = round (time + 1800);
	private _unit_pos = getPosATL (leader _opfor_grp);
	private _radius = GRLIB_spawn_max * 2;
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
