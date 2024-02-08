if (GRLIB_patrols_activity == 0) exitWith {};
diag_log "--- LRX Starting Patrols Manager";
sleep 400;

for "_i" from 1 to GRLIB_patrol_amount do {
	[round(25 + floor random 70)] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
	sleep 12;
};
