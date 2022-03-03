if ( GRLIB_endgame == 1 ) exitWith {};
params ["_liberated_sector"];
diag_log format ["Spawn BattlegGroup at %1", time];

private [ "_bg_groups", "_target_size", "_vehicle_pool", "_selected_opfor_battlegroup" ];
_bg_groups = [];

last_battlegroup_size = 0;
_spawn_marker = "";
if ( isNil "_liberated_sector" ) then {
	_spawn_marker = [ GRLIB_spawn_min, GRLIB_spawn_max, false ] call F_findOpforSpawnPoint;
} else {
	_spawn_marker = [ GRLIB_spawn_min, GRLIB_spawn_max, false, _liberated_sector ] call F_findOpforSpawnPoint;
};


_vehicle_pool = opfor_battlegroup_vehicles;
if ( combat_readiness < 50 ) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

if ( _spawn_marker != "" ) then {

	GRLIB_last_battlegroup_time = time;

	_selected_opfor_battlegroup = [];
	_target_size = GRLIB_battlegroup_size * ([] call F_adaptiveOpforFactor) * (sqrt GRLIB_csat_aggressivity);
	if ( _target_size >= 16 ) then { _target_size = 16; };
	if ( combat_readiness < 60 ) then { _target_size = round (_target_size * 0.65) };
	if ( count allPlayers <= 3 ) then { _target_size = round (_target_size * 0.65) };
	while { count _selected_opfor_battlegroup < _target_size } do {
		_selected_opfor_battlegroup pushback (selectRandom _vehicle_pool);
	};

	[ _spawn_marker ] remoteExec ["remote_call_battlegroup", 0];

	{
		_nextgrp = createGroup [GRLIB_side_enemy, true];
		_vehicle = [markerpos _spawn_marker, _x] call F_libSpawnVehicle;
		_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800)];  // 30 minutes TTL
		(crew _vehicle) joinSilent _nextgrp;
		[_nextgrp, false] spawn battlegroup_ai;
		{ _x setVariable ["GRLIB_counter_TTL", round(time + 1800)] } forEach (units _nextgrp);
		_bg_groups pushback _nextgrp;
		if ( ( _x in opfor_troup_transports ) &&  ( [] call F_opforCap < GRLIB_battlegroup_cap ) ) then {
			[_vehicle] spawn troup_transport;
		};
		last_battlegroup_size = last_battlegroup_size + 1;
		sleep 2;
	} foreach _selected_opfor_battlegroup;

	sleep 5;
	if ( GRLIB_csat_aggressivity > 0.7 ) then {
		private _objectivepos = ([markerpos _spawn_marker] call F_getNearestBluforObjective) select 0;
		if (floor random 2 == 0) then {
			[_objectivepos, GRLIB_side_enemy] spawn spawn_air;
		} else {
			[_objectivepos] spawn send_paratroopers;
		};
	};

	sleep 5;

	combat_readiness = combat_readiness - (round ((last_battlegroup_size / 2) + floor(random (last_battlegroup_size / 2))));
	if ( combat_readiness < 0 ) then { combat_readiness = 0 };

	stats_hostile_battlegroups = stats_hostile_battlegroups + 1;

	{
		if ( local _x ) then {
			_headless_client = [] call F_lessLoadedHC;
			if ( !isNull _headless_client ) then {
				_x setGroupOwner ( owner _headless_client );
			};
		};
		sleep 3;

	} foreach _bg_groups;
};


