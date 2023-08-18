if ( GRLIB_endgame == 1 ) exitWith {};
params ["_objectivepos", "_intensity"];

diag_log format ["Spawn Direct BattlegGroup level %1 at %2", _intensity, time];

private _bg_groups = [];
private _spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, true] call F_findOpforSpawnPoint;
private _vehicle_pool = opfor_battlegroup_vehicles;
if ( _intensity == 1 ) then {
	_vehicle_pool = opfor_battlegroup_vehicles_low_intensity;
};

if (_spawn_marker != "") then {

	private _selected_opfor_battlegroup = [];
	private _target_size = GRLIB_battlegroup_size;

	for "_i" from 1 to _target_size do {
		_selected_opfor_battlegroup pushback (selectRandom _vehicle_pool);
	};

	[ _spawn_marker ] remoteExec ["remote_call_battlegroup", 0];

	{
		_nextgrp = createGroup [GRLIB_side_enemy, true];
		_vehicle = [markerpos _spawn_marker, _x] call F_libSpawnVehicle;
		_vehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];  // 60 minutes TTL
		(crew _vehicle) joinSilent _nextgrp;
		[_nextgrp, _objectivepos] spawn battlegroup_ai;
		{ _x setVariable ["GRLIB_counter_TTL", round(time + 3600)] } forEach (units _nextgrp);
		_bg_groups pushback _nextgrp;
		if ( ( _x in opfor_troup_transports_truck + opfor_troup_transports_heli) && ([] call F_opforCap < GRLIB_battlegroup_cap)) then {
			[_vehicle, _objectivepos] spawn troup_transport;
		};
		sleep 2;
	} foreach _selected_opfor_battlegroup;

	sleep 5;

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
	diag_log format ["Done Spawning Direct BattlegGroup (%1) objective %2 at %3", _target_size, _objectivepos, time];
};
