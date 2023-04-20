if (GRLIB_civilian_activity == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_A3W_Init"};
sleep (1*60);
diag_log "-- LRX Starting Civilian Manager";

for "_i" from 1 to (GRLIB_civilians_amount + (floor (random GRLIB_civilians_amount/2))) do {
	[] execVM "scripts\server\patrols\manage_one_civilian_patrol.sqf";
	sleep 1;
};
