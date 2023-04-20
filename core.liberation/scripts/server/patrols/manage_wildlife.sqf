// Dynamic Animal - by vandeanson
// https://forums.bohemia.net/forums/topic/218268-dynamic-animalgame-spawn-script-by-vandeanson/
// updated by: pSiKO

if (GRLIB_wildlife_manager == 0) exitWith {};

GRLIB_wildlife_max = 4;

for "_i" from 1 to GRLIB_wildlife_max do {
	[] spawn manage_one_wildlife;
	sleep 1;
};
