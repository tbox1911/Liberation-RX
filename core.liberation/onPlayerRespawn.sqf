params ["_unit", "_oldUnit", "_respawn", "_respawnDelay"];

titleText ["" ,"BLACK FADED", 100];
1 fadeSound 0;

deleteVehicle _oldUnit;
_unit allowDamage false;
disableUserInput true;
waitUntil {sleep 0.1; !isNil "GRLIB_init_server"};
waitUntil {sleep 0.1; !isNil "GRLIB_LRX_params_loaded"};

if (GRLIB_ACE_medical_enabled) then {
	[_unit] call ACE_medical_treatment_fnc_fullHealLocal;
	[_unit] call ACE_medical_statemachine_fnc_resetStateDefault;
	_unit setvariable ["ace_medical_causeofdeath", nil];
};
_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]); 

GRLIB_player_spawned = false;
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;
_unit setVariable ["GRLIB_action_inuse", false, true];
_unit setVariable ["SOG_player_in_tunnel", nil];

if (GRLIB_forced_loadout > 0) then {
	private _path = format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout];
	[_path, _unit] call F_getTemplateFile;
};
GRLIB_backup_loadout = getUnitLoadout _unit;
_unit setVariable ["GREUH_stuff_price", ([_unit] call F_loadoutPrice)];
_unit allowDamage true;

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
