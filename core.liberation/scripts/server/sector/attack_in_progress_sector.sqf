params [ "_sector" ];

sleep 20;
private _ownership = [ markerpos _sector ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};

diag_log format ["Spawn Attack Sector %1 at %2", _sector, time];
private _max_prisonners = 4;

private _defenders_cooldown = false;
if ( _sector == attack_in_progress select 0 ) then {
	if (time < ((attack_in_progress select 1) + 900)) then {
		_defenders_cooldown = true;
	};
};

if (_sector in A3W_sectors_in_use) then { _defenders_cooldown = true };

private _blufor_static = [];
{_blufor_static pushBack (_x select 0)} foreach (static_vehicles);
_blufor_static = _blufor_static - static_vehicles_AI;

private _grp = grpNull;
private _veh1 = objNull;
private _veh2 = objNull;
private _arsenal_box = objNull;

if ( GRLIB_blufor_defenders && !_defenders_cooldown) then {
	private _squad_type = blufor_squad_inf_light;
	if (_sector in (sectors_military + sectors_bigtown)) then {
		_squad_type = blufor_squad_mix + [crewman_classname, crewman_classname];
	};

	_grp = [markerpos _sector, _squad_type, GRLIB_side_friendly, "defender"] call F_libSpawnUnits;
	_grp setCombatMode "RED";
	_grp setCombatBehaviour "COMBAT";
	{
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	} foreach (units _grp);

	if (_sector in sectors_military) then {
		// add static def
		_veh1 = createVehicle [selectRandom _blufor_static, markerpos _sector, [], 150, "None"];
		_veh1 setDir random 360;
		sleep 0.5;
		private _gunner = (units _grp) select ((count (units _grp)) -1);
		_gunner assignAsGunner _veh1;
		_gunner moveInGunner _veh1;
		[_gunner] orderGetIn true;
		_veh1 setVariable ["GRLIB_vehicle_gunner", [_gunner]];
		sleep 1;

		// add static def
		_veh2 = createVehicle [selectRandom _blufor_static, markerpos _sector, [], 150, "None"];
		_veh2 setDir random 360;
		sleep 0.5;
		private _gunner = (units _grp) select ((count (units _grp)) -2);
		_gunner assignAsGunner _veh2;
		_gunner moveInGunner _veh2;
		[_gunner] orderGetIn true;
		_veh2 setVariable ["GRLIB_vehicle_gunner", [_gunner]];
		sleep 1;
	};

	[_grp, markerpos _sector] spawn add_defense_waypoints;

	private _defenders_timer = round (time + 120);
	while { time < _defenders_timer && ({alive _x} count (units _grp) > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [ markerpos _sector ] call F_sectorOwnership;
		sleep 3;
	};
};

attack_in_progress = [_sector, round (time)];

if ( _ownership == GRLIB_side_enemy ) then {
	if (!(_sector in sectors_tower) && !_defenders_cooldown) then {
		_arsenal_box = createVehicle [Arsenal_typename, markerPos _sector, [], 20, "NONE"];
	};

	private _sector_timer = GRLIB_vulnerability_timer;
	if (_sector in sectors_bigtown) then {
		_sector_timer = _sector_timer + (10 * 60);
	};

	[ _sector, 1, _sector_timer ] remoteExec ["remote_call_sector", 0];
	sleep 10;
	_sector_timer = round (time + _sector_timer);

	private _activeplayers = 0;
	while { (time < _sector_timer || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [markerPos _sector, (GRLIB_capture_size * 2)] call F_sectorOwnership;
		_activeplayers = count ([allPlayers, {alive _x && (_x distance2D (markerPos _sector)) < GRLIB_sector_size}] call BIS_fnc_conditionalSelect);
		sleep 3;
	};

	if ( GRLIB_endgame == 0 ) then {
		if ( _ownership == GRLIB_side_enemy ) then {
			blufor_sectors = blufor_sectors - [ _sector ];
			publicVariable "blufor_sectors";
			[ _sector, 2 ] remoteExec ["remote_call_sector", 0];
			stats_sectors_lost = stats_sectors_lost + 1;
			diag_log format ["Sector %1 Lost at %2", _sector, time];
		} else {
			[ _sector, 3 ] remoteExec ["remote_call_sector", 0];
			_enemy_left = [allUnits, {(alive _x) && (vehicle _x == _x) && (side group _x == GRLIB_side_enemy) && !(_x getVariable ["GRLIB_mission_AI", false]) && (((getmarkerpos _sector) distance2D _x) < GRLIB_capture_size * 0.8)}] call BIS_fnc_conditionalSelect;
			{
				if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisonner_ai;
					_max_prisonners = _max_prisonners - 1;
				} else {
					if ( ((random 100) <= 50) ) then { [_x] spawn bomber_ai };
				};
			} foreach _enemy_left;

			if (time > ((attack_in_progress select 1) + 300)) then {
				private _rwd_xp = round (15 + random 10);
				private _text = format ["Glory to the Defenders! +%1 XP", _rwd_xp];
				{
					if (_x distance2D (markerpos _sector) < GRLIB_sector_size ) then {
						[_x, _rwd_xp] call F_addScore;
						[gamelogic, _text] remoteExec ["globalChat", owner _x];
					};
				} forEach (AllPlayers - (entities "HeadlessClient_F"));
			};
		};
	};
};

if (!isNull _arsenal_box) then { _arsenal_box spawn {sleep 120; deleteVehicle _this} };
if (!isNull _veh1) then { _veh1 spawn {sleep 60; deleteVehicle _this} };
if (!isNull _veh2) then { _veh2 spawn {sleep 60; deleteVehicle _this} };

if ( count (units _grp) > 0 ) then {
	[_grp] spawn {
		params ["_grp"];
		sleep 60;
		{ deleteVehicle _x } foreach (units _grp);
		deleteGroup _grp;
	};
};

diag_log format ["End Attack Sector %1 at %2", _sector, time];
