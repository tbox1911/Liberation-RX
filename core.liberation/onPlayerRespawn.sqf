disableUserInput true;
_spawn_pos = (getmarkerpos GRLIB_respawn_marker) findEmptyPosition [0,20, "B_soldier_F"];
player setPos _spawn_pos;
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
if (isNil "dostartgame") then {
    waitUntil {sleep 1; !(isNil "dostartgame")};
};
if (dostartgame != 1) then {
    waitUntil {sleep 1; dostartgame == 1};
};
[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
