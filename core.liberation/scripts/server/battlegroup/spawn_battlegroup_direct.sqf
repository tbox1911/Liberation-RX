if ( GRLIB_endgame == 1 ) exitWith {};
params ["_objective_pos", "_intensity"];

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) exitWith {
	diag_log format ["Spawn Direct BattlegGroup on %1 at %2", _hc, time];
	[_objective_pos, _intensity] remoteExec ["spawn_battlegroup_direct", owner _hc];
};

private _bg_groups = [];
private _spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
if (_spawn_marker == "") exitWith {};

diag_log format ["Spawn Direct BattlegGroup level %1 to %2 at %3", _intensity, _objective_pos, time];

private _vehicle_pool = opfor_battlegroup_vehicles;
if ( _intensity == 1 ) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

[markerPos _spawn_marker] remoteExec ["remote_call_battlegroup", 0];

private _selected_opfor_battlegroup = [];
private _target_size = GRLIB_battlegroup_size;

for "_i" from 0 to _target_size do {
	_selected_opfor_battlegroup pushback (selectRandom _vehicle_pool);
};

{
	_nextgrp = createGroup [GRLIB_side_enemy, true];
	_vehicle = [markerpos _spawn_marker, _x] call F_libSpawnVehicle;
	[_vehicle, 3600] call F_setUnitTTL;
	(crew _vehicle) joinSilent _nextgrp;
	if (typeOf _vehicle in opfor_troup_transports_truck) then {
		[_vehicle, _objective_pos] spawn troup_transport;
	} else {
		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		[_nextgrp, 3600] call F_setUnitTTL;
	};
	_bg_groups pushback _nextgrp;
	sleep 2;
} foreach _selected_opfor_battlegroup;

if (combat_readiness >= 70) then {
	[_objective_pos, 3] spawn send_drones;
	sleep 20;
	[_objective_pos, 3] spawn send_drones;
};

stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
publicVariable "stats_hostile_battlegroups";
diag_log format ["Done Spawning Direct BattlegGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];

