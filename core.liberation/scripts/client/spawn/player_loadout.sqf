waitUntil {sleep 0.1; GRLIB_player_spawned };

// Fix player pos
[player] spawn F_fixModUnit;

// Manage Player Loadout
if ( !isNil "GRLIB_respawn_loadout" ) then {
	player setUnitLoadout GRLIB_respawn_loadout;
} else {
	// init loadout
	private _default = true;
	if ( GRLIB_forced_loadout > 0 ) then {
		private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
		[_path, player] call F_getTemplateFile;
		_default = false;
	};
	if ( typeOf player in units_loadout_overide ) then {
		private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
		[_path, player] call F_getTemplateFile;
		_default = false;
	};
	if (_default) then {
		[player, configOf player] call BIS_fnc_loadInventory;
	};
};
[player] call F_filterLoadout;
[player] call F_payLoadout;

GRLIB_backup_loadout = getUnitLoadout player;
player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];

// Load Player Context (+Ai)
if !(player getVariable ["GRLIB_squad_context_loaded", false]) then {
    [player] remoteExec ["load_context_remote_call", 2];
};
