if (GRLIB_autosave_timer == 0) exitWith {};

while { GRLIB_endgame == 0 } do {
	sleep GRLIB_autosave_timer;
	[] call save_game_mp;
};