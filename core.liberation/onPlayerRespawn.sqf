titleText ["" ,"BLACK FADED", 100];
1 fadeSound 0;
player allowDamage false;
disableUserInput true;
waitUntil {sleep 0.1; !isNil "GRLIB_init_server"};
waitUntil {sleep 0.1; !isNil "GRLIB_LRX_params_loaded"};

if (GRLIB_ACE_medical_enabled) then {
	[player] call ACE_medical_treatment_fnc_fullHealLocal;
	[player] call ACE_medical_statemachine_fnc_resetStateDefault;
	player setvariable ["ace_medical_causeofdeath", nil];
};
player setPosATL ((getmarkerpos GRLIB_respawn_marker) findEmptyPosition [0,50]);

GRLIB_player_spawned = false;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player setVariable ["GRLIB_action_inuse", false, true];
player setVariable ["SOG_player_in_tunnel", nil];

if (GRLIB_forced_loadout > 0) then {
	private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
	[_path, player] call F_getTemplateFile;
};
GRLIB_backup_loadout = getUnitLoadout player;
player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
player allowDamage true;

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
