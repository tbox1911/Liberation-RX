params [ "_sector" ];

private _sector_pos = markerpos _sector;
sleep 20;
private _ownership = [_sector_pos] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};
if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};

diag_log format ["Spawn Attack Sector %1 at %2", _sector, time];
private _max_prisonners = 4;

private _defenders_cooldown = false;
if (_sector in attack_in_progress_cooldown) then {
	_defenders_cooldown = true;
} else {
	_defenders_cooldown = false;
	attack_in_progress_cooldown pushBack _sector;
	[_sector] spawn {
		params ["_sector"];
		sleep (15 * 60);
		attack_in_progress_cooldown = attack_in_progress_cooldown - [_sector];
	};
};

private _sideMission = (_sector in A3W_sectors_in_use);
if (_sideMission) then { _defenders_cooldown = true };

private _grp = grpNull;
private _vehicle = objNull;
private _arsenal_box = objNull;
private _defense_type = [_sector] call F_getDefenseType;

if (_defense_type > 0 && !_defenders_cooldown) then {
	private _players = (AllPlayers - (entities "HeadlessClient_F"));
	if (count _players == 0) exitWith {};
	private _cost = round ((GRLIB_defense_costs select _defense_type) / (count _players));
	{
		if (_x getVariable ["GREUH_ammo_count", 0] > GREUH_start_ammo) then {
			[_x, -_cost, 0] call ammo_add_remote_call;
		};
	} forEach _players;
	private _msg = format ["Defenders spawn at %1, Each players pays %2 Ammo.", ([_sector_pos] call F_getLocationName), _cost];
	[gamelogic, _msg] remoteExec ["globalChat", 0];

	private _squad_type = blufor_squad_inf_light;
	if (_defense_type == 2) then {
		_squad_type = blufor_squad_mix;
	};

	_grp = [_sector_pos, _squad_type, GRLIB_side_friendly, "defender"] call F_libSpawnUnits;
	_grp setCombatMode "RED";
	_grp setCombatBehaviour "COMBAT";
	{
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	} foreach (units _grp);
	[_grp, _sector_pos, 50] spawn defence_ai;

	if (_defense_type == 3) then {
		private _vehicleClass = [];
		{
			if ((_x select 0) isKindOf "Wheeled_APC_F") then { _vehicleClass pushBack (_x select 0) };
		} forEach (light_vehicles + heavy_vehicles);

		if (count _vehicleClass > 0) then {
			private _vehiclePos = _sector_pos findEmptyPosition [5, 120, "B_Heli_Transport_03_unarmed_F"];
			_vehicle = [_vehiclePos, selectRandom _vehicleClass, 3, false, GRLIB_side_friendly] call F_libSpawnVehicle;
			_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
			[(group driver _vehicle), _sector_pos] spawn defence_ai;
		};
	};

	if (!(_sector in sectors_tower)) then {
		_arsenal_box = createVehicle [Arsenal_typename, _sector_pos, [], 20, "NONE"];
		[_arsenal_box] call F_clearCargo;
	};

	private _defenders_timer = round (time + 180);
	while { time < _defenders_timer && ({alive _x} count (units _grp) > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_sector_pos] call F_sectorOwnership;
		sleep 5;
	};
};

if ( _ownership == GRLIB_side_enemy ) then {
	private _sector_timer = GRLIB_vulnerability_timer;
	if (_sector in sectors_bigtown) then {
		_sector_timer = _sector_timer + (10 * 60);
	};

	[ _sector, 1, _sector_timer ] remoteExec ["remote_call_sector", 0];
	sleep 10;
	_sector_timer = round (time + _sector_timer);

	private _activeplayers = 0;
	while { (time < _sector_timer || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_sector_pos, GRLIB_capture_size] call F_sectorOwnership;
		_activeplayers = { alive _x && (_x distance2D _sector_pos) < GRLIB_sector_size } count (units GRLIB_side_friendly);
		sleep 3;
	};

	if ( GRLIB_endgame == 0 && GRLIB_global_stop == 0) then {
		if ( _ownership == GRLIB_side_enemy ) then {
			blufor_sectors = blufor_sectors - [ _sector ];
			publicVariable "blufor_sectors";
			opfor_sectors = (sectors_allSectors - blufor_sectors);
			publicVariable "opfor_sectors";
			[_sector, 0] call sector_defenses_remote_call;
			if (GRLIB_TFR_enabled && _sector in sectors_tower) then {
				private _tower = (nearestObjects [_sector_pos, [Radio_tower], 20]) select { (alive _x) && (_x getVariable ['GRLIB_Radio_Tower', false])} select 0;
				_tower call TFAR_antennas_fnc_deleteRadioTower;
			};
			stats_sectors_lost = stats_sectors_lost + 1;
			[ _sector, 2 ] remoteExec ["remote_call_sector", 0];
			diag_log format ["Sector %1 Lost at %2", _sector, time];
		} else {
			[ _sector, 3 ] remoteExec ["remote_call_sector", 0];
			private _enemy_left = ((markerPos _sector) nearEntities ["CAManBase", GRLIB_capture_size * 0.8]);
			_enemy_left = _enemy_left select { (side _x == GRLIB_side_enemy) && (isNull objectParent _x) };
			{
				if ( !_sideMission && _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisoner_ai;
					_max_prisonners = _max_prisonners - 1;
				} else {
					if ( ((random 100) <= 50) ) then { [_x] spawn bomber_ai };
				};
			} foreach _enemy_left;

			if ((_sector_timer - time) <= 300) then {
				private _rwd_xp = round (15 + random 10);
				private _text = format ["Glory to the Defenders! +%1 XP", _rwd_xp];
				{
					if (_x distance2D _sector_pos < GRLIB_sector_size ) then {
						[_x, 5] call F_addReput;
						[_x, _rwd_xp] call F_addScore;
						[gamelogic, _text] remoteExec ["globalChat", owner _x];
					};
				} forEach (AllPlayers - (entities "HeadlessClient_F"));
			};
		};
	};
};

if (!isNull _arsenal_box) then {_arsenal_box spawn {sleep 120; deleteVehicle _this}};
if (!isNull _vehicle) then {_vehicle spawn {sleep 60; [_this, true, true] call clean_vehicle}};
if (count (units _grp) > 0) then {_grp spawn {sleep 60; {deleteVehicle _x} foreach (units _this); deleteGroup _this}};

diag_log format ["End Attack Sector %1 at %2", _sector, time];
