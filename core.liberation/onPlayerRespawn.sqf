if (isDedicated || !hasInterface) exitWith {};

params ["_unit", "_oldUnit", "_respawn", "_respawnDelay"];

titleText ["" ,"BLACK FADED", 100];
1 fadeSound 0;

waitUntil {sleep 0.1; (alive _unit)};
waitUntil {sleep 0.1; !isNil "GRLIB_init_server"};
if (!GRLIB_init_server) exitWith {};
waitUntil {sleep 0.1; !isNil "GRLIB_LRX_params_loaded"};

deleteVehicle _oldUnit;
_unit allowDamage false;
_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);

if (GRLIB_ACE_medical_enabled) then {
	[_unit] call ACE_medical_treatment_fnc_fullHealLocal;
	[_unit] call ACE_medical_statemachine_fnc_resetStateDefault;
	_unit setvariable ["ace_medical_causeofdeath", nil];
};

GRLIB_player_spawned = false;
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit setVariable ["GREUH_stuff_price", nil, true];
_unit setVariable ["GRLIB_action_inuse", false, true];
_unit setVariable ["SOG_player_in_tunnel", nil];
_unit allowDamage true;

[] execVM "scripts\client\spawn\player_loadout.sqf";
[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
