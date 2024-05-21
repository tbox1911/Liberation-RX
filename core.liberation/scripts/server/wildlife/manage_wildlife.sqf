// LRX WildLife
// by: pSiKO

if (GRLIB_wildlife_manager == 0) exitWith {};

waitUntil {sleep 1; !isNil "sectors_allSectors" };
diag_log "--- LRX Starting Wildlife Manager";
GRLIB_wildlife_max = 6;

sleep 333;
for "_i" from 1 to GRLIB_wildlife_max do {
	[] spawn compileFinal preprocessFileLineNumbers "scripts\server\wildlife\manage_one_wildlife.sqf";
	sleep 14;
};
