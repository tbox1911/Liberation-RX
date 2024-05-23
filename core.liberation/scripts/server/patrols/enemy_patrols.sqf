if (GRLIB_patrols_activity == 0) exitWith {};
sleep 400;
diag_log "--- LRX Starting Patrols Manager";

for "_i" from 1 to GRLIB_patrol_amount do {
	[round(25 + floor random 70)] spawn compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_enemy_patrol.sqf";
	sleep 30;
};
