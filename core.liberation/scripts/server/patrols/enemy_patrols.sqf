// LRX Patrols Manager
// by: pSiKO

if (GRLIB_patrols_activity == 0) exitWith {};
manage_one_enemy_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_enemy_patrol.sqf";

sleep 300;
diag_log "--- LRX Starting Patrols Manager";

for "_i" from 1 to GRLIB_patrol_amount do {
	[round (25 + floor random 70)] spawn manage_one_enemy_patrol;
	sleep 30;
};
