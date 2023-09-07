if (GRLIB_patrols_activity == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_A3W_Init"};
diag_log "--- LRX Starting Patrols Manager";
sleep 400;

for "_i" from 1 to 5 do {
	[] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
	sleep 14;
};
