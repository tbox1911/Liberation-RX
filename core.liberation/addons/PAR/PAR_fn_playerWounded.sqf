params ["_unit", "_killer"];

if !(isPlayer _unit) exitWith {};

disableUserInput true;
openMap false;
closeDialog 0;
(uiNamespace getVariable ["RscDisplayArsenal", displayNull]) closeDisplay 1;
{
    _x setVariable ["R3F_LOG_est_transporte_par", objNull, true];
    detach _x;
} forEach (attachedObjects _unit);
R3F_LOG_joueur_deplace_objet = objNull;

// Show Dog
private _my_dog = _unit getVariable ["my_dog", nil];
if (!isNil "_my_dog") then { [_my_dog, false] remoteExec ["hideObjectGlobal", 2] };

// Death message
if (PAR_EnableDeathMessages && !isNil "_killer" && _killer != _unit) then {
    ["PAR_deathMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
};

private _msg = localize selectRandom ["STR_PAR_Need_Medic1", "STR_PAR_Need_Medic2", "STR_PAR_Need_Medic3"];
[_unit, _msg] call PAR_fn_globalchat;

// Mute Radio
5 fadeRadio 0;

// Dog barf
if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

// PAR AI Revive Call
[_unit] spawn PAR_fn_unconscious;
[] call PAR_fn_revive_ui;

// Player got revived
if !([_unit] call PAR_is_wounded) then {
    // Unmute Radio
    5 fadeRadio 1;

    // Unmute ACRE
    _unit setVariable ["ace_sys_wounds_uncon", false];

    // Dog stop
    if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", nil] };
};
