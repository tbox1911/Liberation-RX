params ["_sector"];

sleep 30;
private _sector_pos = markerpos _sector;
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

sector_attack_in_progress pushBack _sector;
publicVariable "sector_attack_in_progress";

if (_sector in A3W_sectors_in_use) then { _defenders_cooldown = true };
private _grp = grpNull;
private _vehicle = objNull;
private _arsenal = objNull;
private _defense_type = [_sector] call F_getDefenseType;

if (_defense_type > 0 && !_defenders_cooldown) then {
	private _data = [_sector_pos, _defense_type] call spawn_defenders;
	_grp = _data select 0;
	_vehicle = _data select 1;
	_arsenal = _data select 2;
};

if (_ownership == GRLIB_side_enemy) then {
	sector_timer = round (serverTime + GRLIB_vulnerability_timer);
	if (_sector in sectors_bigtown) then {
		sector_timer = sector_timer + (10 * 60);
	};
	publicVariable "sector_timer";

	[_sector, 1] remoteExec ["remote_call_sector", 0];
	sleep 10;

	private _activeplayers = 0;
	while { (serverTime < sector_timer || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_sector_pos, GRLIB_capture_size] call F_sectorOwnership;
		_activeplayers = { alive _x && (_x distance2D _sector_pos) < GRLIB_sector_size } count (units GRLIB_side_friendly);
		sleep 3;
	};

	if (GRLIB_endgame == 0 && GRLIB_global_stop == 0) then {
		if (_ownership == GRLIB_side_enemy) then {
			blufor_sectors = blufor_sectors - [_sector];
			publicVariable "blufor_sectors";
			opfor_sectors = (sectors_allSectors - blufor_sectors);
			[_sector, 0] call sector_defenses_remote_call;
			if (GRLIB_TFR_enabled && _sector in sectors_tower) then {
				private _tower = (nearestObjects [_sector_pos, [Radio_tower], 20]) select { (alive _x) && (_x getVariable ['GRLIB_Radio_Tower', false])} select 0;
				_tower call TFAR_antennas_fnc_deleteRadioTower;
			};
			stats_sectors_lost = stats_sectors_lost + 1;
			[_sector, 2] remoteExec ["remote_call_sector", 0];
			{ [_x, -15] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
			private _msg = format ["You have lost control of the %1 sector, your reputation drops by %2 points.", [_sector_pos] call F_getLocationName, -15];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			diag_log format ["Sector %1 Lost at %2", _sector, time];
		} else {
			[_sector, 3] remoteExec ["remote_call_sector", 0];

			if !(_sector in A3W_sectors_in_use) then {
				[_sector_pos, _max_prisonners] call spawn_prisonners;
			};

			if !(_sector in (sectors_military + sectors_tower)) then {
				[_sector_pos] spawn {
					params ["_sector_pos"];
					sleep 30;
					private _civilians = (_sector_pos nearEntities ["CAManBase", GRLIB_capture_size * 0.8]) select {
						(side _x == GRLIB_side_civilian) && !(captive _x) && !(isAgent teamMember _x)
					};
					if (count _civilians > 5) then {
						for "_i" from 0 to (floor random 4) do {
							private _anim = selectRandom ["Acts_Dance_01", "Acts_Dance_02"];
							private _unit = selectRandom _civilians;
							[_unit, _anim] spawn F_startAnimMP;
							_unit setVariable ["GRLIB_can_speak", false, true];
							_civilians = _civilians - [_unit];
							sleep 1;
						};
					};
				};
			};

			if ((sector_timer - serverTime) <= 300) then {
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
			sector_timer = 0;
			publicVariable "sector_timer";
		};
	};
};

sector_attack_in_progress = sector_attack_in_progress - [_sector];
publicVariable "sector_attack_in_progress";

if (!isNull _arsenal) then {_arsenal spawn {sleep 120; deleteVehicle _this}};
if (!isNull _vehicle) then {_vehicle spawn {sleep 60; [_this, true, true] call clean_vehicle}};
if (count (units _grp) > 0) then {_grp spawn {sleep 60; {deleteVehicle _x} foreach (units _this); deleteGroup _this}};

diag_log format ["End Attack Sector %1 at %2", _sector, time];
