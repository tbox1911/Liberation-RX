// Allow time for load_context
WaitUntil {sleep 0.5; (player getVariable ["GRLIB_player_context_loaded", false])};

// Fix player pos
[player] spawn F_fixModUnit;

if (isNil {player getVariable "GREUH_stuff_price"}) then {
	// Manage Player Loadout
	if (!isNil "GRLIB_respawn_loadout") then {
		player setUnitLoadout GRLIB_respawn_loadout;
	} else {
		// init loadout
		if (GRLIB_forced_loadout > 0) exitWith {
			private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
			[_path, player] call F_getTemplateFile;
		};
		if (typeOf player in units_loadout_overide) exitWith {
			private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
			[_path, player] call F_getTemplateFile;
		};
		[player, configOf player] call BIS_fnc_loadInventory;
	};
	[player] call F_filterLoadout;
	[player] call F_payLoadout;

	GRLIB_backup_loadout = getUnitLoadout player;
	player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice), true];
};
