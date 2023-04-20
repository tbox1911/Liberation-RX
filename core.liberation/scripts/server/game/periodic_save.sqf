_save_interval = 60;

while { GRLIB_endgame == 0 } do {
	sleep _save_interval;
	trigger_server_save = ([] call F_getValid);
};