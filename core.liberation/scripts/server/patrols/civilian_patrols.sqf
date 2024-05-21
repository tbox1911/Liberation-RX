if (GRLIB_civilian_activity == 0) exitWith {};
diag_log "--- LRX Starting Civilian Manager";
sleep 300;

for "_i" from 1 to GRLIB_civilians_amount do {
	[] spawn compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";
	sleep 12;
};
