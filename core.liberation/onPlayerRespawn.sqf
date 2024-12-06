if (isDedicated || !hasInterface) exitWith {};

params ["_unit", "_oldUnit", "_respawn", "_respawnDelay"];

titleText ["" ,"BLACK FADED", 100];
1 fadeSound 0;

waitUntil {(alive _unit) && !isNil "GRLIB_respawn_marker"};
_unit allowDamage false;
_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);
GRLIB_player_spawned = false;

waitUntil {!isNil "GRLIB_init_server"};
if (!GRLIB_init_server) exitWith {};
waitUntil {!isNil "GRLIB_init_client"};
waitUntil {!isNil "LRX_arsenal_init_done"};

if (PAR_grave == 1) then { deleteVehicle _oldUnit };

if (GRLIB_ACE_medical_enabled) then {
	[_unit] call ACE_medical_treatment_fnc_fullHealLocal;
	[_unit] call ACE_medical_statemachine_fnc_resetStateDefault;
	_unit setvariable ["ace_medical_causeofdeath", nil];
};

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

[] spawn compileFinal preprocessFileLineNumbers "scripts\client\spawn\player_loadout.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\client\spawn\redeploy_manager.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\client\misc\welcome.sqf";
