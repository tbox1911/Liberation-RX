// Welcome trigger
GRLIB_player_spawned = false;
waituntil {sleep 0.5; !isNil "GRLIB_revive"};
if (GRLIB_revive == 0) then {[player] call player_EVH}; 	// if FAR is disabled, minimal handler

[] execVM "scripts\client\misc\welcome.sqf";
