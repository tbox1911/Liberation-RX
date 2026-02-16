params ["_sector_pos", "_count", "_side", "_mission_ai", "_type"];

private _radius = GRLIB_capture_size - 20;
//if (_sector in sectors_bigtown) then { _radius = _radius * 1.4 };

private _spawn_pos = ([_sector_pos, _radius] call F_getRandomPos);

private _static_pool = opfor_statics;
if (_side == GRLIB_side_friendly) then {
	_static_pool = blufor_statics;
	if (_type == "resistance") then {
		_static_pool = [a3w_resistance_static];
	};
};

diag_log format ["--- LRX Spawn %1 Static Weapon (%2/%3) at %4", _count, _side, _type, time];

private _static_units = [];
private _static_count = 0;
private _max_try = 100;

private ["_spawn_pos", "_vehicle", "_grp"];
while { _static_count < _count && _max_try > 0 } do {
	_spawn_pos = ([_sector_pos, _radius] call F_getRandomPos);
	if (!surfaceIsWater _spawn_pos) then {
		// Create Static
		_vehicle = createVehicle [selectRandom _static_pool, _spawn_pos, [], 0, "None"];
		_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
		_static_units append [_vehicle];
		_static_count = _static_count + 1;
		diag_log format ["--- LRX Spawn Static Weapon %1", typeOf _vehicle];

		if (_side == GRLIB_side_enemy) then {
			_vehicle setVariable ["GRLIB_vehicle_reward", true, true];
		};
		[_vehicle] call F_aceLockVehicle;
		sleep 1;

		// Crew
		_grp = [_vehicle, _side, _mission_ai, _type] call F_forceCrew;
		sleep 1;

		// Spotters
		if (_side == GRLIB_side_enemy && !_mission_ai) then {
			private _squad = [opfor_spotter, opfor_spotter];
			private _grp_spotter = [_spawn_pos, _type, _squad, false] call F_spawnRegularSquad;
			[_grp_spotter, getPosATL _vehicle, 20] spawn defence_ai;
			_static_units append (units _grp_spotter);
		};

		_static_units append (units _grp);
		private _hc = [] call F_lessLoadedHC;
		if (isDedicated && !isNull _hc) then {
			_grp setGroupOwner (owner _hc);
		};
	};
	_max_try = _max_try - 1;
	sleep 1;
};

_static_units;
