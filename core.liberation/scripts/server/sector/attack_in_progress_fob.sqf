params [ "_fobpos" ];

sleep 30;
private _ownership = [_fobpos] call F_sectorOwnership;
if (_ownership != GRLIB_side_enemy) exitWith {};
if (GRLIB_endgame == 1 || GRLIB_global_stop == 1) exitWith {};

diag_log format ["Spawn Attack FOB %1 at %2", _fobpos, time];
private _max_prisonners = 4;
private _defense_type = [str _fobpos] call F_getDefenseType;
private _grp = grpNull;
if (_defense_type > 0) then {
	private _squad_type = blufor_squad_inf_light;
	if (_defense_type == 2) then {
		_squad_type = blufor_squad_inf;
	};
	if (_defense_type == 3) then {
		_squad_type = blufor_squad_mix;
	};	
	_grp = [_fobpos, _squad_type, GRLIB_side_friendly, "defender"] call F_libSpawnUnits;
	_grp setCombatMode "RED";
	_grp setCombatBehaviour "COMBAT";
	{
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	} foreach (units _grp);
	_grp setCombatBehaviour "COMBAT";
	[_grp, _fobpos] spawn defence_ai;

	private _defenders_timer = round (time + 120);
	while { time < _defenders_timer && ({alive _x} count (units _grp) > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_fobpos] call F_sectorOwnership;
		sleep 5;
	};
};

if ( _ownership == GRLIB_side_enemy ) then {
	private _sector_timer = GRLIB_vulnerability_timer + (5 * 60);
	private _near_outpost = (_fobpos in GRLIB_all_outposts);
	private _activeplayers = 0;

	[_pos, 1, _sector_timer] remoteExec ["remote_call_fob", 0];		
	[_fobpos] spawn {
		params ["_pos"];
		private _sound = "A3\Sounds_F\sfx\alarm_blufor.wss";
		while { ([_pos] call F_sectorOwnership) == GRLIB_side_enemy } do {
			sleep (60 + (floor(random 4) * 45));
			[_pos, 1] remoteExec ["remote_call_fob", 0];			
			playSound3D [_sound, _pos, false, ATLToASL _pos, 5, 1, 1000];
		};
	};

	sleep 10;
	_sector_timer = round (time + _sector_timer);

	while { (time < _sector_timer || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_fobpos, (GRLIB_capture_size * 2)] call F_sectorOwnership;
		_activeplayers = count ([allPlayers, {alive _x && (_x distance2D (_fobpos)) < GRLIB_sector_size}] call BIS_fnc_conditionalSelect);
		if (_sector_timer mod 60 == 0 && !_near_outpost) then {
			[_fobpos, 4] remoteExec ["remote_call_fob", 0];
		};
		sleep 3;
	};

	if ( GRLIB_endgame == 0 ) then {
		if ( _ownership == GRLIB_side_enemy ) then {
			if (!_near_outpost) then {
				[_fobpos, 250] remoteExec ["remote_call_penalty", 0];
				sleep 3;
			};
			[_fobpos, 2] remoteExec ["remote_call_fob", 0];
			sleep 1;
			[_fobpos] call destroy_fob;
		} else {
			[_fobpos, 3] remoteExec ["remote_call_fob", 0];
			private _enemy_left = (_fobpos nearEntities ["CAManBase", GRLIB_capture_size * 0.8]);
			_enemy_left = _enemy_left select { (side _x == GRLIB_side_enemy) && (isNull objectParent _x) };
			{
				if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisoner_ai;
					_max_prisonners = _max_prisonners - 1;
				};
			} foreach _enemy_left;

			private _rwd_xp = round (15 + random 10);
			private _text = format ["Glory to the Defenders! +%1 XP", _rwd_xp];
			{
				if (_x distance2D _fobpos < GRLIB_sector_size ) then {
					[_x, _rwd_xp] call F_addScore;
					[gamelogic, _text] remoteExec ["globalChat", owner _x];
				};
			} forEach (AllPlayers - (entities "HeadlessClient_F"));
		};
	};
};

if (count (units _grp) > 0) then {_grp spawn {sleep 60; {deleteVehicle _x} foreach (units _this); deleteGroup _this}};

diag_log format ["End Attack FOB %1 at %2", _fobpos, time];
