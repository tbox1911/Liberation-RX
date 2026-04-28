if (GRLIB_autosave_timer == 0) exitWith {};

sleep 60;
private _ticks = 1;
private ["_current_uid", "_uid"];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	// check for disconnected players every 2 minutes
	if (_ticks % 2 == 0) then {
		_current_uid = (allPlayers select {!(_x isKindOf "HeadlessClient_F")}) apply { getPlayerUID _x };
		{
		    _uid = _x;
			if (_uid != "") then {
				private _player = _uid call BIS_fnc_getUnitByUID;
				if (isNull _player) then {
					diag_log format ["--- LRX player ID (%1) force left the mission.", _uid];
					[_uid] call cleanup_uid;
				};
			};
		} forEach (GRLIB_players_known_uid - _current_uid);
		GRLIB_players_known_uid = _current_uid;
	};

	// save player contexts every 10 minutes
	if (_ticks % 10 == 0) then {
		{
		    _uid = _x;
			if (_uid != "") then {
				private _player = _uid call BIS_fnc_getUnitByUID;
				if (!isNull _player) then {
					[_player, _uid] call save_context;
				};
			};
		} forEach GRLIB_players_known_uid;
	};

	// autosave every GRLIB_autosave_timer minutes
	if (_ticks % (GRLIB_autosave_timer/60) == 0) then {
		waitUntil { sleep 1; !GRLIB_cleanup_active };
		diag_log format ["--------------------------------------"];
		diag_log format ["--- LRX Automatic Save Game at %1", (round time)];
		[] call save_game_mp;
		diag_log format ["--------------------------------------"];
	};

	_ticks = _ticks + 1;
	if (_ticks >= 65535) then { _ticks = 0 };
	sleep 60;
};
