if (GRLIB_autosave_timer == 0) exitWith {};

while { GRLIB_endgame == 0 } do {
	sleep GRLIB_autosave_timer;
	{ if ([_x] call F_getScore > 20) then { [_x] call save_context } } foreach (AllPlayers - (entities "HeadlessClient_F"));
	[] call save_game_mp;
};