if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};
params ["_liberated_sector"];

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) exitWith {
	diag_log format ["Spawn BattlegGroup on %1 at %2", _hc, time];
	[_liberated_sector] remoteExec ["spawn_battlegroup", owner _hc];
};

private _spawn_marker = "";
private _objective_pos = [];

if (isNil "_liberated_sector") then {
	diag_log format ["Spawn BattlegGroup search target at %1", time];
	{
		_objective_pos = markerPos _x;
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
		if (_spawn_marker != "") exitWith {};
		sleep 1;
	} foreach (blufor_sectors call BIS_fnc_arrayShuffle);
} else {
	_objective_pos = markerPos _liberated_sector;
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
};

if (_spawn_marker == "") exitWith {
	diag_log "BattlegGroup could not find accessible Objective.";
	if (count blufor_sectors > 5) then {
		private _para_pos = [];
		if (isNil "_liberated_sector") then {
			_para_pos = markerPos (selectRandom blufor_sectors);
		} else {
			_para_pos = markerPos _liberated_sector;
		};
		[_para_pos, GRLIB_side_enemy, 3] spawn spawn_air;
		sleep 20;
		[_para_pos, 4] spawn send_drones;
		sleep 20;
		[_para_pos] spawn send_paratroopers;
		sleep 30;
		[_para_pos] spawn send_paratroopers;
		sleep 30;
		[_para_pos] spawn spawn_halo_vehicle;
		combat_readiness = combat_readiness - 15;
		diag_log format ["Done Spawning Paratrooper BattlegGroup at %1", time];
	};
};

diag_log format ["Spawn BattlegGroup target %1 from %2 at %3", _objective_pos, markerPos _spawn_marker, time];

GRLIB_last_battlegroup_time = time;
private _vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness < 50 ) then {	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity };
private _target_size = round ((GRLIB_battlegroup_size * GRLIB_csat_aggressivity) * (1+(combat_readiness / 100)));
private _current_players = count (AllPlayers - (entities "HeadlessClient_F"));
if ( _current_players <= 2 ) then { _target_size = round (_target_size / 2) };
if ( _target_size > 10 && GRLIB_csat_aggressivity >= 2 ) then { _target_size = 10 };
if ( _target_size > 8 && GRLIB_csat_aggressivity < 2 ) then { _target_size = 8 };
if ( _target_size < 2 ) then { _target_size = 2 };

[markerPos _spawn_marker] remoteExec ["remote_call_battlegroup", 0];

private ["_nextgrp", "_vehicle", "_vehicle_class"];
private _bg_groups = [];
for "_i" from 1 to _target_size do {
	_vehicle_class = selectRandom _vehicle_pool;
	_vehicle = [markerpos _spawn_marker, _vehicle_class] call F_libSpawnVehicle;
	[_vehicle, 3600] call F_setUnitTTL;
	_nextgrp = group driver _vehicle;
	if (typeOf _vehicle in opfor_troup_transports_truck) then {
		[_vehicle, _objective_pos] spawn troup_transport;
	} else {
		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		[_nextgrp, 3600] call F_setUnitTTL;
	};
	_bg_groups pushback _nextgrp;
	sleep 10;
};

private _nb_squad = round ((3 * GRLIB_csat_aggressivity) * (1+(combat_readiness / 100)));
if (_nb_squad > 6) then { _nb_squad = 6 };
if ( _current_players <= 2 ) then { _nb_squad = round (_nb_squad / 2) };
if ( _nb_squad < 2 ) then { _nb_squad = 2 };

for "_i" from 1 to _nb_squad do {
	if (floor random 2 == 0) then {
		_nextgrp = [_spawn_marker, "csat", ([] call F_getAdaptiveSquadComp), false] call F_spawnRegularSquad;
		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		[_nextgrp, 3600] call F_setUnitTTL;
	} else {
		[_objective_pos] spawn send_paratroopers;
	};
	_target_size = _target_size + 1;
	_bg_groups pushback _nextgrp;
	sleep 30;
};

if ( GRLIB_csat_aggressivity > 1 && combat_readiness > 70 && _current_players >= 3 ) then {
	if (floor random 2 == 0) then {
		[_objective_pos, GRLIB_side_enemy, 4] spawn spawn_air;
		sleep 30;
		[_objective_pos] spawn spawn_halo_vehicle;		
	} else {
		[_objective_pos, GRLIB_side_enemy, 2] spawn spawn_air;
		sleep 30;
		[_objective_pos] spawn send_paratroopers;
	};
	_target_size = _target_size + 3;
	sleep 30;
};

if (combat_readiness >= 50) then {
	[_objective_pos, 3] spawn send_drones;
};

combat_readiness = combat_readiness - (10 + (_target_size * 1.75));
if ( combat_readiness < 0 ) then { combat_readiness = 0 };
publicVariable "combat_readiness";
stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
publicVariable "stats_hostile_battlegroups";

diag_log format ["Done Spawning BattlegGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];