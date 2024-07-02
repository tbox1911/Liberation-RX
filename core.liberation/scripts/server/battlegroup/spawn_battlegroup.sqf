if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};
params ["_liberated_sector"];
waitUntil {sleep 0.5; !GRLIB_GC_Running };

private _spawn_marker = "";
private _objective_pos = zeropos;

if ( isNil "_liberated_sector" ) then {
	diag_log format ["Spawn BattlegGroup no target at %1", time];
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max] call F_findOpforSpawnPoint;
	if (_spawn_marker != "") then {
		_objective_pos = ([markerpos _spawn_marker] call F_getNearestBluforObjective) select 0;
	};
} else {
	diag_log format ["Spawn BattlegGroup target %1 at %2", _liberated_sector, time];
	_objective_pos = markerPos _liberated_sector;
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
};

if (_objective_pos isEqualTo zeropos) exitWith { diag_log format ["BattlegGroup could not find accessible Objective from %1.", _spawn_marker] };

private _vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness < 50 ) then {	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity };

if (_spawn_marker != "") then {
	diag_log format ["Spawn BattlegGroup objective %1 at %2", _objective_pos, time];
	[markerPos _spawn_marker] remoteExec ["remote_call_battlegroup", 0];
	GRLIB_last_battlegroup_time = time;
	private _target_size = round ((GRLIB_battlegroup_size * GRLIB_csat_aggressivity) * (1+(combat_readiness / 100)));
	if ( count (AllPlayers - (entities "HeadlessClient_F")) <= 2 ) then { _target_size = round (_target_size * 0.65) };
	if ( _target_size > 10 && GRLIB_csat_aggressivity >= 2 ) then { _target_size = 10 };
	if ( _target_size > 8 && GRLIB_csat_aggressivity < 2 ) then { _target_size = 8 };
	if ( _target_size < 2 ) then { _target_size = 2 };

	private ["_nextgrp", "_vehicle", "_vehicle_class"];
	for "_i" from 1 to _target_size do {
		_vehicle_class = selectRandom _vehicle_pool;
		_vehicle = [markerpos _spawn_marker, _vehicle_class] call F_libSpawnVehicle;
		_vehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];  // 60 minutes TTL
		_vehicle setVariable ["GRLIB_battlegroup", true];
		_nextgrp = group driver _vehicle;
		{
			_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
			_x setVariable ["GRLIB_battlegroup", true];
		} forEach (units _nextgrp);
		if (typeOf _vehicle in opfor_troup_transports_truck) then {
			[_vehicle, _objective_pos] spawn troup_transport;
		} else {
			[_nextgrp, _objective_pos] spawn battlegroup_ai;
		};
		sleep 10;
	};

	private _nb_squad = 1;
	if (combat_readiness > 80) then { _nb_squad = 2 };
	for "_i" from 1 to _nb_squad do {
		if (floor random 2 == 0) then {
			_nextgrp = [_spawn_marker, "csat", ([] call F_getAdaptiveSquadComp)] call F_spawnRegularSquad;
			[_nextgrp, _objective_pos] spawn battlegroup_ai;
			{
				_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
				_x setVariable ["GRLIB_battlegroup", true];
			} forEach (units _nextgrp);			
		} else {
			[_objective_pos] spawn send_paratroopers;
		};
		_target_size = _target_size + 1;
		sleep 10;
	};

	sleep 15;
	if ( GRLIB_csat_aggressivity > 1 && combat_readiness > 70 ) then {
		if (floor random 2 == 0) then {
			[_objective_pos, GRLIB_side_enemy, 4] spawn spawn_air;
		} else {
			[_objective_pos, GRLIB_side_enemy, 2] spawn spawn_air;
			sleep 15;
			[_objective_pos] spawn send_paratroopers;
		};
		_target_size = _target_size + 4;
	};

	combat_readiness = combat_readiness - (10 + (_target_size * 1.75));
	stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
	diag_log format ["Done Spawning BattlegGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];
} else {
	if (count blufor_sectors > 5) then {
		private _para_pos = [];
		if (isNil "_liberated_sector" ) then {
			_para_pos = markerPos (selectRandom blufor_sectors);
		} else {
			_para_pos = markerPos _liberated_sector;
		};
		[_para_pos, GRLIB_side_enemy, 3] spawn spawn_air;
		sleep 20;
		[_para_pos] spawn send_paratroopers;
		sleep 20;
		[_para_pos] spawn send_paratroopers;
		sleep 30;
		[_para_pos] spawn spawn_halo_vehicle;
		combat_readiness = combat_readiness - 15;
		diag_log format ["Done Spawning Paratrooper BattlegGroup at %1", time];
	};
};

if ( combat_readiness < 0 ) then { combat_readiness = 0 };
publicVariable "combat_readiness";
