if (GRLIB_autosave_timer == 0) exitWith {};

sleep 60;
private _ticks = 1;

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	if (_ticks % 10 == 0) then {
		{ [_x, getPlayerUID _x] call save_context } foreach (AllPlayers - (entities "HeadlessClient_F"));
	};

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
