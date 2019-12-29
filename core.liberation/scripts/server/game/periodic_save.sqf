_save_interval = 30;

while { GRLIB_endgame == 0 } do {
	sleep _save_interval;
	trigger_server_save = true;
};