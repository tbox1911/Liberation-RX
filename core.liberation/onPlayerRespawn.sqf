titleText ["" ,"BLACK FADED", 100];
waitUntil {sleep 0.2; !(isNil "GRLIB_init_server")};
waitUntil {sleep 0.2; GRLIB_init_server};
player allowDamage false;
disableUserInput true;
player setPosATL ((getmarkerpos GRLIB_respawn_marker) findEmptyPosition [0,50]);
GRLIB_player_spawned = false;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player setVariable ["GREUH_stuff_price", 0];
GRLIB_backup_loadout = [player] call F_getLoadout;

waitUntil {sleep 0.2; !(isNil "dostartgame")};
waitUntil {sleep 0.2; dostartgame == 1};
player allowDamage true;

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
