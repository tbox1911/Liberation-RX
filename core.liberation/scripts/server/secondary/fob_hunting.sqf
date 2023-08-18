params [ ["_mission_cost", 0], "_caller" ];

private _spawn_marker = [GRLIB_spawn_min, 99999, false] call F_findOpforSpawnPoint;
if ( _spawn_marker == "" ) exitWith { [gamelogic, "Could not find position for fob hunting mission"] remoteExec ["globalChat", 0] };
GRLIB_secondary_used_positions pushbackUnique _spawn_marker;

diag_log format ["--- LRX: %1 start static mission: Fob Hunting at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 0;
publicVariable "GRLIB_secondary_in_progress";

[2] remoteExec ["remote_call_intel", 0];

private _base_position = markerpos _spawn_marker;
private _base_output = [_base_position, true, true] call createOutpost;
private _base_objects = _base_output select 0;
private _base_objectives = _base_output select 1;
private _grpdefenders = _base_output select 2;
private _grpsentry = _base_output select 3;

secondary_objective_position = _base_position;
secondary_objective_position_marker = [(((secondary_objective_position select 0) + 800) - random 1600),(((secondary_objective_position select 1) + 800) - random 1600),0];
publicVariable "secondary_objective_position_marker";
sleep 1;

diag_log _base_objectives;
waitUntil {
	sleep 5;
	( { alive _x } count _base_objectives == 0 )
};

[3] remoteExec ["remote_call_intel", 0];

combat_readiness = round (combat_readiness * GRLIB_secondary_objective_impact);
stats_secondary_objectives = stats_secondary_objectives + 1;

{
	if (typeOf _x isKindof "AllVehicles") then {
		_x setVariable ["GRLIB_vehicle_owner", "", true];
		_x lock 0;
	};
} foreach _base_objects;

[_base_objectives + _base_objects, _base_position, _grpdefenders, _grpsentry] spawn { 
	sleep 300; 
	{
		if (count (crew _x) == 0 && (_x getVariable ["GRLIB_vehicle_owner", ""] == "")) then {
			deleteVehicle _x;
		};		
	} forEach (_this select 0);

	{ deleteVehicle _x } forEach ([nearestObjects [(_this select 1), ["Ruins_F"], 100], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
	{ deleteVehicle _x } forEach units (_this select 2);
	{ deleteVehicle _x } forEach units (_this select 3);

	GRLIB_secondary_in_progress = -1; 
	publicVariable "GRLIB_secondary_in_progress";
	GRLIB_secondary_used_positions = [];
}; 
