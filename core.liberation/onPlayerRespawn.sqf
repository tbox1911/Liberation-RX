// Welcome trigger
GRLIB_player_spawned = false;

waituntil {sleep 0.5; !(isNil "GRLIB_revive")};
if (GRLIB_revive == 0) then {[player] call player_EVH}; 	// if PAR is disabled, minimal handler

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player setVariable ["GREUH_stuff_price", 0];
GRLIB_backup_loadout = [player] call F_getLoadout;

[] execVM "scripts\client\misc\welcome.sqf";
