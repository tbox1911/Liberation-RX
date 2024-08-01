// LRX WildLife Manager
// by: pSiKO

if (GRLIB_wildlife_manager == 0) exitWith {};
sleep 250;
diag_log "--- LRX Starting Wildlife Manager";
GRLIB_wildlife_max = 6;

for "_i" from 1 to GRLIB_wildlife_max do {
	[] execVM "scripts\server\wildlife\manage_one_wildlife.sqf";
	sleep 14;
};
