if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};
params ["_liberated_sector"];
waitUntil {sleep 0.5; !GRLIB_GC_Running };
diag_log format ["Spawn BattlegGroup at %1", time];

private _spawn_marker = "";
private _objective_pos = [];

if ( isNil "_liberated_sector" ) then {
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max] call F_findOpforSpawnPoint;
	_objective_pos = ([markerpos _spawn_marker] call F_getNearestBluforObjective) select 0;
} else {
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, true, markerPos _liberated_sector] call F_findOpforSpawnPoint;
	_objective_pos = markerPos _liberated_sector;
	if ((markerPos _spawn_marker) distance2D _objective_pos > GRLIB_spawn_max) then {
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max] call F_findOpforSpawnPoint;
		_objective_pos = ([markerPos _spawn_marker] call F_getNearestBluforObjective) select 0;
	};
};

if (_objective_pos isEqualTo zeropos) exitWith {};
[markerPos _spawn_marker] remoteExec ["remote_call_battlegroup", 0];

private _vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness < 50 ) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

if (_spawn_marker != "") then {
	GRLIB_last_battlegroup_time = time;

	private _target_size = GRLIB_battlegroup_size * (combat_readiness /100);
	if ( count (AllPlayers - (entities "HeadlessClient_F")) <= 2 ) then { _target_size = round (_target_size * 0.65) };
	if ( _target_size > 8 ) then { _target_size = 8; };
	if ( _target_size < 3 ) then { _target_size = 3; };

	private ["_nextgrp", "_vehicle", "_vehicle_class", "_squad"];
	for "_i" from 1 to _target_size do {
		_vehicle_class = (selectRandom _vehicle_pool);
		_vehicle = [markerpos _spawn_marker, _vehicle_class] call F_libSpawnVehicle;
		_vehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];  // 60 minutes TTL

		_nextgrp = group driver _vehicle;
		{ _x setVariable ["GRLIB_counter_TTL", round(time + 3600)] } forEach (units _nextgrp);

		if ( (_vehicle_class in opfor_troup_transports_truck + opfor_troup_transports_heli) && (opforcap < GRLIB_battlegroup_cap)) then {
			[_vehicle, _objective_pos] spawn troup_transport;
		};

		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		sleep 10;
	};

	private _nb_squad = 1;
	if (combat_readiness > 80) then { _nb_squad = 2 };

	for "_i" from 1 to _nb_squad do {
		_squad = [] call F_getAdaptiveSquadComp;
		_nextgrp = [_spawn_marker, "csat", _squad] call F_spawnRegularSquad;
		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		_target_size = _target_size + 1;
		sleep 10;
	};

	sleep 15;
	if ( GRLIB_csat_aggressivity > 0.7 ) then {
		if (floor random 2 == 0) then {
			[_objective_pos, GRLIB_side_enemy, 4] spawn spawn_air;
		} else {
			[_objective_pos] spawn send_paratroopers;
		};
	};

	sleep 15;

	combat_readiness = combat_readiness - (_target_size * 1.75);
	if ( combat_readiness < 0 ) then { combat_readiness = 0 };
	publicVariable "combat_readiness";

	stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
	diag_log format ["Spawn BattlegGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];
} else {
	if (count blufor_sectors > 5) then {
		private _para_pos = [];
		if (isNil "_liberated_sector" ) then {
			_para_pos = markerPos (selectRandom blufor_sectors);
		} else {
			_para_pos = markerPos _liberated_sector;
		};
		[_para_pos] spawn send_paratroopers;
		sleep 20;
		[_para_pos] spawn send_paratroopers;
		diag_log format ["Done Spawning Paratrooper BattlegGroup at %1", time];
	};
};
