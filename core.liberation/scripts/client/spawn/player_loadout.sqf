// Wait Arsenal
waitUntil {sleep 0.1; !isNil "LRX_arsenal_init_done"};
waitUntil {sleep 0.1; LRX_arsenal_init_done};

// Cleanup
removeAllWeapons player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player setVariable ["GREUH_stuff_price", nil, true];

// Fix player traits
[player] call F_fixModUnit;

// Load Player Context
if !(player getVariable ["GRLIB_player_context_loaded", false]) then {
	[player] remoteExec ["load_context_remote_call", 2];
	// Allow time for load_context
	waitUntil {sleep 2; (player getVariable ["GRLIB_player_context_loaded", false])};
};

// Default Loadout
if (isNil {player getVariable "GREUH_stuff_price"}) then {
	// Backup Loadout
	if (!isNil "GRLIB_respawn_loadout") then {
		waitUntil {sleep 0.1; !(isSwitchingWeapon player)};
		player setUnitLoadout GRLIB_respawn_loadout;
	} else {
		// Forced init loadout
		if (GRLIB_forced_loadout > 0) then {
			private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
			[_path, player] call F_getTemplateFile;
		} else {
			// Overide
			if (typeOf player in units_loadout_overide) then {
				private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
				[_path, player] call F_getTemplateFile;
			} else {
				// Default
				[player, configOf player] call BIS_fnc_loadInventory;
			};
		};
		player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice), true];
	};

	[player] call F_filterLoadout;
	[player] call F_payLoadout;

	//player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice), true];
};

sleep 1;
GRLIB_backup_loadout = getUnitLoadout player;
