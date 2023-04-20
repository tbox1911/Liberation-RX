titleText ["Loading...","BLACK FADED", 1000];

// Welcome trigger
if (!isMultiplayer) exitWith {
	titleText ["Sorry, Liberation RX is a Multiplayer Mission Only...","BLACK FADED", 1000];
	uisleep 10;
	endMission "LOSER";
};

waitUntil {!isNil "abort_loading" };
if (abort_loading) exitWith {
	titleText ["Sorry, An error occured on savegame loading.\nPlease check the error logs.","BLACK FADED", 1000];
	uisleep 10;
	endMission "LOSER";
};

waitUntil {sleep 1; alive player};
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

waitUntil {sleep 0.1; !(isNil "dostartgame")};
waitUntil {sleep 0.1; dostartgame == 1};

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
