params [ ["_mission_cost", 0], "_caller" ];

private _all_possible_sectors = ([SpawnMissionMarkers] call checkSpawn) apply { _x select 0 };
if (count _all_possible_sectors == 0) exitWith { [gamelogic, "Could not find position for fob hunting mission"] remoteExec ["globalChat", 0] };

private _missionPos = [_all_possible_sectors, 40] call F_findFlatPlace;
if (count _missionPos == 0) exitWith { [gamelogic, "Could not find position for fob hunting mission"] remoteExec ["globalChat", 0] };

private _spawn_marker = [GRLIB_sector_size, _missionPos, _all_possible_sectors] call F_getNearestSector;
GRLIB_secondary_used_positions pushbackUnique _spawn_marker;

private _msg = "Secondary Mission: Fob Hunting";
diag_log format ["--- LRX %1 start at %2", _msg, time];
[gamelogic, _msg] remoteExec ["globalChat", 0];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 0;
publicVariable "GRLIB_secondary_in_progress";

[2] remoteExec ["remote_call_intel", 0];

private _base_output = [_missionPos, true, true, true] call createOutpost;
private _base_objects = _base_output select 0;
private _base_objectives = _base_output select 1;
private _grp_defenders = _base_output select 2;
private _grp_sentry = _base_output select 3;
private _prisoners = _base_output select 4;

secondary_objective_position_marker = _missionPos;
publicVariable "secondary_objective_position_marker";
sleep 1;

waitUntil {
	sleep 5;
	( { alive _x } count _base_objectives == 0 )
};

[3] remoteExec ["remote_call_intel", 0];

combat_readiness = 15 max round (combat_readiness * GRLIB_secondary_objective_impact);
stats_secondary_objectives = stats_secondary_objectives + 1;

{
	if (typeOf _x isKindof "AllVehicles") then {
		_x setVariable ["GRLIB_vehicle_owner", "", true];
		_x lock 0;
	};
} foreach _base_objects;

waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_missionPos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };

private _vehicles = (_base_objectives + _base_objects);
[_vehicles] call cleanMissionVehicles;

{ deleteVehicle _x } forEach ((nearestObjects [_missionPos, ["Ruins_F"], 100]) select { getObjectType _x == 8 });
{ deleteVehicle _x } forEach (units _grp_defenders);
{ deleteVehicle _x } forEach (units _grp_sentry);
{ if (side group _x != GRLIB_side_friendly) then {deleteVehicle _x} } forEach _prisoners;

GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";
GRLIB_secondary_used_positions = [];
