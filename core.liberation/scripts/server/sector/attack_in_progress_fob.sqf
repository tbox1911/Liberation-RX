params [ "_fob_pos" ];

sleep 30;
private _ownership = [_fob_pos] call F_sectorOwnership;
if (_ownership != GRLIB_side_enemy) exitWith {};
if (GRLIB_endgame == 1 || GRLIB_global_stop == 1) exitWith {};

diag_log format ["Spawn Attack FOB %1 at %2", _fob_pos, time];
private _max_prisonners = 4;
private _grp = grpNull;
private _sector = format ["fobmarker%1", (GRLIB_all_fobs find _fob_pos)];
private _defense_type = [_sector] call F_getDefenseType;

if (_defense_type > 0) then {
	private _data = [_fob_pos, _defense_type, true] call spawn_defenders;
	_grp = _data select 0;
};

fob_attack_in_progress pushBack _fob_pos;
publicVariable "fob_attack_in_progress";

if (GRLIB_Commander_mode) then {
    GRLIB_AvailAttackSectors = [];
    publicVariable "GRLIB_AvailAttackSectors";
};
sleep 10;
_ownership = [_fob_pos] call F_sectorOwnership;
if (_ownership == GRLIB_side_enemy) then {
	sector_timer = round (serverTime + GRLIB_vulnerability_timer + (5 * 60));
	publicVariable "sector_timer";

	[_fob_pos, 1] remoteExec ["remote_call_fob", 0];
	if (GRLIB_AlarmsEnabled) then {
		[_fob_pos] spawn {
			params ["_pos"];
			sleep 60;
			private _sound = "A3\Sounds_F\sfx\alarm_blufor.wss";
			while { ([_pos] call F_sectorOwnership) == GRLIB_side_enemy && _pos in GRLIB_all_fobs } do {
				[_pos, 1] remoteExec ["remote_call_fob", 0];
				playSound3D [_sound, _pos, false, ATLToASL _pos, 5, 1, 1000];
				sleep (60 + (floor(random 4) * 45));
			};
		};
	};

	sleep 10;
	private _near_outpost = (_fob_pos in GRLIB_all_outposts);
	private _activeplayers = 0;

	while { (serverTime < sector_timer || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
		_ownership = [_fob_pos, GRLIB_capture_size] call F_sectorOwnership;
		_activeplayers = count (allPlayers select { alive _x && (_x distance2D (_fob_pos)) < GRLIB_sector_size });
		if (sector_timer mod 60 == 0 && !_near_outpost) then {
			[_fob_pos, 4] remoteExec ["remote_call_fob", 0];
		};
		sleep 3;
	};

	if ( GRLIB_endgame == 0 ) then {
		if ( _ownership == GRLIB_side_enemy ) then {
			diag_log format ["FOB %1 Lost at %2", _fob_pos, time];
			if (!_near_outpost) then {
				[_fob_pos, 250] remoteExec ["remote_call_penalty", 0];
				sleep 3;
			};
			[_fob_pos, 2] remoteExec ["remote_call_fob", 0];
			sleep 1;
			[_fob_pos] call destroy_fob;
			if (GRLIB_Commander_mode) then { [] call manage_sectors_commander };
		} else {
			diag_log format ["FOB %1 Defended at %2", _fob_pos, time];
			[_fob_pos, 3] remoteExec ["remote_call_fob", 0];
			[_fob_pos, _max_prisonners] call spawn_prisonners;

			if ((sector_timer - serverTime) <= 300) then {
				private _rwd_xp = round (15 + random 10);
				private _text = format ["Glory to the Defenders! +%1 XP", _rwd_xp];
				{
					if (_x distance2D _fob_pos < GRLIB_sector_size ) then {
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

fob_attack_in_progress = fob_attack_in_progress - [_fob_pos];
publicVariable "fob_attack_in_progress";

if (GRLIB_Commander_mode) then { [] call manage_sectors_commander };
if (count (units _grp) > 0) then {_grp spawn {sleep 60; {deleteVehicle _x} foreach (units _this); deleteGroup _this}};

diag_log format ["End Attack FOB %1 at %2", _fob_pos, time];
