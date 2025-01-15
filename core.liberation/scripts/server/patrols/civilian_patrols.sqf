// LRX Civilian Manager
// by: pSiKO

if (GRLIB_civilian_activity == 0) exitWith {};
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";

sleep 200;
diag_log "--- LRX Starting Civilian Manager";

for "_i" from 1 to GRLIB_civilians_amount do {
	[] spawn manage_one_civilian_patrol;
	sleep 15;
};
