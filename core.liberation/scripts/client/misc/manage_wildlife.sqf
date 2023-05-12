// Dynamic Animal - by vandeanson
// https://forums.bohemia.net/forums/topic/218268-dynamic-animalgame-spawn-script-by-vandeanson/
// updated by: pSiKO

if (GRLIB_wildlife_manager == 0) exitWith {};

diag_log "--- LRX Starting Wildlife Manager";
GRLIB_wildlife_max = 5;

for "_i" from 1 to GRLIB_wildlife_max do {
	[] execVM "scripts\client\misc\manage_one_wildlife.sqf";
	sleep 5;
};
