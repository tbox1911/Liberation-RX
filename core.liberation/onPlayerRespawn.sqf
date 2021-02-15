// Welcome trigger
GRLIB_player_spawned = false;
waituntil {sleep 0.5; !isNil "GRLIB_revive"};
if (GRLIB_revive == 0) then {[player] call player_EVH}; 	// if PAR is disabled, minimal handler

if (GRLIB_forced_loadout > 0) then {
	[player] call compile preprocessFileLineNumbers (format ["scripts\loadouts\vanilla\player_set%1.sqf", GRLIB_forced_loadout]);
} else {
	[player, configfile >> "CfgVehicles" >> typeOf player] call BIS_fnc_loadInventory;
	if (typeOf player in units_loadout_overide) then {
		_loadouts_folder = format ["scripts\loadouts\%1\%2.sqf", GRLIB_side_friendly, typeOf player];
		[player] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
	};
};

[] execVM "scripts\client\misc\welcome.sqf";
