titleText ["" ,"BLACK FADED", 100];
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

if (GRLIB_forced_loadout > 0) then {
    [player] call compile preprocessFileLineNumbers (format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout]);
} else {
    [player, configOf player] call BIS_fnc_loadInventory;
};
if (typeOf player in units_loadout_overide) then {
    _loadouts_folder = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
    [player] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
};
player setVariable ["GREUH_stuff_price", 0];
GRLIB_backup_loadout = [player] call F_getLoadout;

waitUntil {sleep 0.2; !(isNil "dostartgame")};
waitUntil {sleep 0.2; dostartgame == 1};
player allowDamage true;

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
