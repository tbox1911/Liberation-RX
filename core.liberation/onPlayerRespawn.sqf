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

// if (GRLIB_side_friendly == EAST && side player != GRLIB_side_friendly) then {
// 	// an ugly workaround to change player spawn class from B_xxx to O_xxx
// 	// thank to pierremgi / killzone_kid

// 	_old_player = player;
// 	_r1 = (typeOf player) splitString "";
// 	_r1 set [0, "O"];
// 	_class = _r1 joinString "";
// 	_group = createGroup [GRLIB_side_friendly, true];
// 	sleep 1;
// 	//diag_log format ["DBG: %1 %2 %3", _group, _class, _spawn_pos ];
// 	_player = _group createUnit [_class, _spawn_pos, [], 0, "none"];
// 	sleep 1;

// 	//[_player] joinSilent _group;
// 	selectPlayer _player;
// 	deleteVehicle _old_player;

// 	[] call DALE_fnc_initBriefing;
//  [] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
// };

GRLIB_player_spawned = false;
waitUntil {sleep 0.1; !isNil "GRLIB_revive"};
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

waitUntil {sleep 0.1; !(isNil "dostartgame")};
waitUntil {sleep 0.1; dostartgame == 1};

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
