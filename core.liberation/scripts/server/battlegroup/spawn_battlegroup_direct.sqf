if (GRLIB_endgame == 1) exitWith {};
params ["_objective_pos", "_intensity"];

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) exitWith {
	diag_log format ["Spawn Direct BattlegGroup on %1 at %2", _hc, time];
	[_objective_pos, _intensity] remoteExec ["spawn_battlegroup_direct", owner _hc];
};

_objective_pos set [2, 0];

private _spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
if (_spawn_marker == "") exitWith {};

diag_log format ["Spawn Direct BattlegGroup level %1 to %2 at %3", _intensity, _objective_pos, time];

private _vehicle_pool = opfor_battlegroup_vehicles;
if (_intensity == 1) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

private _spawn_pos = markerPos _spawn_marker;
[_spawn_pos] remoteExec ["remote_call_battlegroup", 0];

private ["_vehicle", "_driver", "_nextgrp"];
private _selected_opfor_battlegroup = [];
private _target_size = GRLIB_battlegroup_size;

for "_i" from 0 to _target_size do {
	_selected_opfor_battlegroup pushback (selectRandom _vehicle_pool);
};

{
	_vehicle = [_spawn_pos, _x] call F_libSpawnVehicle;
	_driver = driver _vehicle;
	_nextgrp = group _driver;
	_driver doMove _objective_pos;
	[_nextgrp, _objective_pos] spawn battlegroup_ai;
	[_nextgrp, 3600] call F_setUnitTTL;
	sleep 15;
} foreach _selected_opfor_battlegroup;

if (count opfor_troup_transports_truck > 0 && floor random 3 > 0) then {
	_vehicle = [_spawn_pos, (selectRandom opfor_troup_transports_truck)] call F_libSpawnVehicle;
	[_vehicle, _objective_pos] spawn troup_transport;
	sleep 10;
} else {
	_nextgrp = [_spawn_pos, "csat", ([] call F_getAdaptiveSquadComp), false] call F_spawnRegularSquad;
	[_nextgrp, _objective_pos] spawn battlegroup_ai;
	[_nextgrp, 3600] call F_setUnitTTL;
	sleep 10
};

[_objective_pos] spawn send_paratroopers;
sleep 10;
if (combat_readiness >= 70) then {
	[_objective_pos] spawn send_paratroopers;
	sleep 10;
};

if (combat_readiness >= 80) then {
	[_objective_pos, 3] spawn send_drones;
	sleep 10;
	[_objective_pos, 3] spawn send_drones;
};

stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
publicVariable "stats_hostile_battlegroups";
diag_log format ["Done Spawning Direct BattlegGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];

