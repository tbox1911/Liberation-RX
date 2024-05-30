if (GRLIB_civilian_activity == 0) exitWith {};
sleep 200;
diag_log "--- LRX Starting Civilian Manager";

for "_i" from 1 to GRLIB_civilians_amount do {
	[] execVM "scripts\server\patrols\manage_one_civilian_patrol.sqf";
	sleep 15;
};
