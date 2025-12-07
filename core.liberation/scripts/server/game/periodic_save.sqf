if (GRLIB_autosave_timer == 0) exitWith {};

sleep GRLIB_autosave_timer;

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	waitUntil { sleep 1; !GRLIB_cleanup_active };
	{ [_x, getPlayerUID _x] call save_context } foreach (AllPlayers - (entities "HeadlessClient_F"));
	diag_log format ["--------------------------------------"];
	diag_log format ["--- LRX Automatic Save Game at %1", (round time)];
	[] call save_game_mp;
	diag_log format ["--------------------------------------"];
	sleep GRLIB_autosave_timer;
};
