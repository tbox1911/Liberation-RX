waitUntil {!(isNull (findDisplay 46))};
waitUntil {sleep 1; !isNil "GRLIB_game_ID"};
GRLIB_virtual_garage = profileNamespace getVariable [format ["GRLIB_virtual_garage_%1", GRLIB_game_ID], []];
systemChat "-------- Virtual Garage Initialized --------";