// Fix player traits
[player] call F_fixModUnit;
[] spawn loadout_price;

waitUntil {sleep 0.2; !(isSwitchingWeapon player)};

// Player Loadout
if (isNil {player getVariable "GREUH_stuff_price"}) then {
	// Backup Loadout
	if (!isNil "GRLIB_respawn_loadout") then {
		private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
		if (_ammo_collected >= GRLIB_respawn_loadout_price) then {
			player setVariable ["GREUH_stuff_price", 0, true];
			player setUnitLoadout GRLIB_respawn_loadout;
			[player] call F_filterLoadout;
			[player] call F_payLoadout;
		} else {
			private _msg = format ["Can't load Respawn loadout: %1", localize "STR_GRLIB_NOAMMO"];
			hintSilent _msg;
			gamelogic globalChat _msg;
		};
	};
};

if (isNil {player getVariable "GREUH_stuff_price"}) then {
	// Forced init loadout
	if (GRLIB_forced_loadout > 0) then {
		private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
		[_path, player] call F_getTemplateFile;
	} else {
		// Overide
		private _class_overide = toLower (typeOf player);
		if (_class_overide in units_loadout_overide) then {
			private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, _class_overide];
			[_path, player] call F_getTemplateFile;
		} else {
			// Default
			[player, configOf player] call BIS_fnc_loadInventory;
		};
	};
	player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice), true];
};

sleep 1;
GRLIB_backup_loadout = getUnitLoadout player;
