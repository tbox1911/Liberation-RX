if (GRLIB_patrols_activity == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_A3W_Init"};
diag_log "--- LRX Starting Patrols Manager";
sleep 400;

[33] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[42] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[69] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[73] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[90] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
