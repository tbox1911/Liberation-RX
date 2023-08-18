if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};
params ["_liberated_sector"];
diag_log format ["Spawn BattlegGroup at %1", time];

private _bg_groups = [];
private _spawn_marker = "";
private _objective_pos = [];
if ( isNil "_liberated_sector" ) then {
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max] call F_findOpforSpawnPoint;
	_objective_pos = ([markerpos _spawn_marker] call F_getNearestBluforObjective) select 0;
} else {
	_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, true, _liberated_sector] call F_findOpforSpawnPoint;
	_objective_pos = markerPos _liberated_sector;
	if ((markerPos _spawn_marker) distance2D _objective_pos > GRLIB_spawn_max) then {
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max] call F_findOpforSpawnPoint;
		_objective_pos = ([markerPos _spawn_marker] call F_getNearestBluforObjective) select 0;
	};
};

if (_objective_pos isEqualTo zeropos) exitWith {};

private _vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness < 50 ) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

if (_spawn_marker != "") then {
	GRLIB_last_battlegroup_time = time;

	private _selected_opfor_battlegroup = [];
	private _target_size = GRLIB_battlegroup_size * (combat_readiness /100);
	if ( count (AllPlayers - (entities "HeadlessClient_F")) <= 2 ) then { _target_size = round (_target_size * 0.65) };
	if ( _target_size > 8 ) then { _target_size = 8; };
	if ( _target_size < 3 ) then { _target_size = 3; };

	for "_i" from 1 to _target_size do {
		_selected_opfor_battlegroup pushback (selectRandom _vehicle_pool);
	};

	[ _spawn_marker ] remoteExec ["remote_call_battlegroup", 0];

	{
		_nextgrp = createGroup [GRLIB_side_enemy, true];
		_vehicle = [markerpos _spawn_marker, _x] call F_libSpawnVehicle;
		_vehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];  // 60 minutes TTL
		(crew _vehicle) joinSilent _nextgrp;
		[_nextgrp, _objective_pos] spawn battlegroup_ai;
		{ _x setVariable ["GRLIB_counter_TTL", round(time + 3600)] } forEach (units _nextgrp);
		_bg_groups pushback _nextgrp;
		if ( ( _x in opfor_troup_transports_truck + opfor_troup_transports_heli) && ([] call F_opforCap < GRLIB_battlegroup_cap)) then {
			[_vehicle, _objective_pos] spawn troup_transport;
		};
		sleep 2;
	} foreach _selected_opfor_battlegroup;

	sleep 5;
	if ( GRLIB_csat_aggressivity > 0.7 ) then {
		if (floor random 2 == 0) then {
			[_objective_pos, GRLIB_side_enemy, 4] spawn spawn_air;
		} else {
			[_objective_pos] spawn send_paratroopers;
		};
	};

	sleep 5;

	combat_readiness = combat_readiness - (_target_size * 1.75);
	if ( combat_readiness < 0 ) then { combat_readiness = 0 };

	{
		if ( local _x ) then {
			_headless_client = [] call F_lessLoadedHC;
			if ( !isNull _headless_client ) then {
				_x setGroupOwner ( owner _headless_client );
			};
		};
		sleep 3;
	} foreach _bg_groups;

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
		sleep 15;
		[_para_pos] spawn send_paratroopers;	
		diag_log format ["Done Spawning Paratrooper BattlegGroup at %1", time];
	};
};
