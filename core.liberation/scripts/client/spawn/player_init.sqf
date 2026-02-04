
params ["_unit", ["_oldUnit", objNull]];

// LRX Player Initalization

titleText ["" ,"BLACK FADED", 100];

_unit allowDamage false;
1 fadeSound 0;
_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);
if (PAR_grave == 1 && !isNull _oldUnit) then { deleteVehicle _oldUnit };
if (GRLIB_ACE_medical_enabled) then {
    [_unit] call ACE_medical_treatment_fnc_fullHealLocal;
    [_unit] call ACE_medical_statemachine_fnc_resetStateDefault;
    _unit setvariable ["ace_medical_causeofdeath", nil];
};

_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
_unit setVariable ["PAR_isUnconscious", false, true];
_unit setVariable ["PAR_ACE_isUnconscious", false, true];
_unit setVariable ["PAR_isDragged", 0, true];
_unit setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
_unit setVariable ["GRLIB_action_inuse", false, true];
_unit setVariable ["SOG_player_in_tunnel", nil];
_unit setVariable ["ace_sys_wounds_uncon", false];

if (!GRLIB_fatigue) then { _unit enableFatigue false; _unit enableStamina false };
if (GRLIB_force_english) then { _unit setSpeaker (format ["Male0%1ENG", round (1 + floor random 9)]) };
if (GRLIB_TFR_enabled) then {
    private _settings = player getVariable ["GRLIB_TFAR_SW_config", []];
    if (count _settings > 0) then { [call TFAR_fnc_activeSwRadio, _settings] call TFAR_fnc_setSwSettings };
    private _settings = player getVariable ["GRLIB_TFAR_LR_config", []];
    if (count _settings > 0) then { [call TFAR_fnc_activeLrRadio, _settings] call TFAR_fnc_setLrSettings };
};

_unit setCustomAimCoef 0.35;
_unit setUnitRecoilCoefficient 0.6;
_unit setCaptive false;
PAR_isDragging = false;

[_unit] spawn AR_Player_Actions;
[_unit] spawn player_actions;

PAR_backup_loadout = [];
deletemarker format ["PAR_marker_%1", PAR_Grp_ID];

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";

waituntil {sleep 1; GRLIB_player_spawned};

1 fadeSound 1;
1 fadeRadio 1;
NRE_EarplugsActive = 0;
hintSilent "";
showMap true;

_unit allowDamage true;
