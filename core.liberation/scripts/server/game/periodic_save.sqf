if (GRLIB_autosave_timer == 0) exitWith {};

sleep GRLIB_autosave_timer;
while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	{
		[_x, getPlayerUID _x] call save_context;
		sleep 1;
	} foreach (AllPlayers - (entities "HeadlessClient_F"));

	[] call save_game_mp;
	sleep GRLIB_autosave_timer;
};