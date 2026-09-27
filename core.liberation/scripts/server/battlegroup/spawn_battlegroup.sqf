params ["_liberated_sector"];
if (GRLIB_endgame == 1 || GRLIB_global_stop == 1) exitWith {};
if (opforcap_max) exitWith { diag_log "Spawn Direct BattleGroup aborted, opfor max units reached." };

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) exitWith {
	diag_log format ["Spawn BattleGroup on %1 at %2", _hc, time];
	[_liberated_sector] remoteExec ["spawn_battlegroup", owner _hc];
};

waitUntil {
	sleep 5;
	(time > (GRLIB_last_battlegroup + GRLIB_battlegroup_timer));
};

GRLIB_last_battlegroup = round time;

private _spawn_marker = "";
private _objective_pos = [];
private _spawn_pos = [];

if (isNil "_liberated_sector") then {
	diag_log format ["Spawn BattleGroup search target at %1", time];
	private _search_list = (blufor_sectors apply { markerPos _x }) + GRLIB_all_fobs;
	{
		_objective_pos = _x;
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
		if (_spawn_marker != "") then { _spawn_pos = [markerPos _spawn_marker, 30, 0] call F_findSafePlace };
		if (count _spawn_pos > 0) exitWith {};
		sleep 1;
	} foreach (_search_list call BIS_fnc_arrayShuffle);
} else {
	_objective_pos = markerPos _liberated_sector;
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, _objective_pos] call F_findOpforSpawnPoint;
	if (_spawn_marker != "") then { _spawn_pos = [markerPos _spawn_marker, 30, 0] call F_findSafePlace };
};

if (count _spawn_pos == 0) exitWith {
	diag_log "BattleGroup could not find accessible Objective.";
	if (count blufor_sectors > 5) then {
		private _para_pos = [];
		if (isNil "_liberated_sector") then {
			_para_pos = markerPos (selectRandom blufor_sectors);
		} else {
			_para_pos = markerPos _liberated_sector;
		};
		[_para_pos, GRLIB_side_enemy, 3] spawn spawn_air;
		sleep 10;
		[_para_pos, 4] spawn send_drones;
		sleep 10;
		[_para_pos] spawn send_paratroopers;
		sleep 20;
		[_para_pos] spawn send_paratroopers;
		sleep 20;
		[_para_pos] spawn spawn_halo_vehicle;
		combat_readiness = combat_readiness - 15;
		diag_log format ["Done Spawning Paratrooper BattleGroup at %1", time];
	};
};

diag_log format ["Spawn BattleGroup target %1 from %2 at %3", _objective_pos, _spawn_pos, time];

private _vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness <= 80 ) then { _vehicle_pool = opfor_battlegroup_vehicles_low_intensity };

private _target_size = 2;
private _current_players = count (AllPlayers - (entities "HeadlessClient_F"));
if (_current_players >= 2) then { _target_size = 3 };
if (combat_readiness > 70) then { _target_size = _target_size + 1 };
if (GRLIB_difficulty_modifier >= 2) then { _target_size = _target_size + 1 };
if (GRLIB_difficulty_modifier < 1) then { _target_size = 2 };

[_spawn_pos] remoteExec ["remote_call_battlegroup", 0];

private ["_nextgrp", "_vehicle", "_driver"];

for "_i" from 1 to _target_size do {
	_vehicle = [_spawn_pos, (selectRandom _vehicle_pool), 15] call F_libSpawnVehicle;
	_driver = driver _vehicle;
	_nextgrp = group _driver;
	_driver doMove _objective_pos;
	[_nextgrp, _objective_pos] spawn battlegroup_ai;
	[_nextgrp, 3600] call F_setUnitTTL;
	sleep 15;
};

private _nb_squad = 2;
if (_current_players >= 2) then { _nb_squad = 3 };
if (combat_readiness > 70) then { _nb_squad = _nb_squad + 1 };
if (GRLIB_difficulty_modifier >= 2) then { _nb_squad = _nb_squad + 1 };
if (GRLIB_difficulty_modifier < 1) then { _nb_squad = 2 };

for "_i" from 1 to _nb_squad do {
	if (count opfor_troup_transports_truck > 0 && floor random 3 > 0) then {
		_vehicle = [_spawn_pos, (selectRandom opfor_troup_transports_truck), 15] call F_libSpawnVehicle;
		[_vehicle, _objective_pos] spawn troup_transport;
		sleep 10;
	} else {
		if (count opfor_troup_transports_heli > 0) then {
			[_objective_pos] spawn send_paratroopers;
		} else {
			_nextgrp = [_spawn_pos, "csat", ([] call F_getAdaptiveSquadComp), false] call F_spawnRegularSquad;
			[_nextgrp, _objective_pos] spawn battlegroup_ai;
			[_nextgrp, 3600] call F_setUnitTTL;
		};
	};
	_target_size = _target_size + 1;
	sleep 10;
};

if (combat_readiness >= 50 && GRLIB_difficulty_modifier >= 1) then {
	[_objective_pos, 3] spawn send_drones;
	sleep 10;
};

if (GRLIB_difficulty_modifier >= 2 && combat_readiness > 70 && _current_players >= 3) then {
	if (floor random 2 == 0) then {
		[_objective_pos, GRLIB_side_enemy, 4] spawn spawn_air;
		sleep 20;
		[_objective_pos] spawn spawn_halo_vehicle;
	} else {
		[_objective_pos, GRLIB_side_enemy, 2] spawn spawn_air;
		sleep 20;
		[_objective_pos] spawn send_paratroopers;
	};
	_target_size = _target_size + 3;
};

combat_readiness = combat_readiness - (10 + (_target_size * 1.75));
if ( combat_readiness < 0 ) then { combat_readiness = 0 };
publicVariable "combat_readiness";
stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
publicVariable "stats_hostile_battlegroups";

diag_log format ["Done Spawning BattleGroup (%1) objective %2 at %3", _target_size, _objective_pos, time];