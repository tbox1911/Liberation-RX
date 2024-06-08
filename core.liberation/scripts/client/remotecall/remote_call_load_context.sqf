if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_grp"];

hintSilent "Your squad is coming\nPlease wait...";
waitUNtil { sleep 0.1; local _grp };
private _pos = getPosATL player;
private _alt = _pos select 2;

{
    [_x] joinSilent (group player);
    _x allowDamage false;
    while { _x distance2D _pos > 100 } do {
        if (surfaceIsWater _pos) then {
            private _destpos = _pos getPos [3, random 360];
            _destpos set [2, _alt];
            _x setPosASL (ATLtoASL _destpos);
        } else {
            _x setPosATL (_pos getPos [5, random 360]);
        };
        sleep 0.5;
    };
    [_x] spawn F_fixModUnit;
    [_x] spawn PAR_fn_AI_Damage_EH;
    _x enableIRLasers true;
    _x enableGunLights "Auto";
    _x switchMove "AmovPercMwlkSrasWrflDf";
    _x playMoveNow "AmovPercMwlkSrasWrflDf";
    gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _x, rank _x];
    sleep 0.3;
    _x allowDamage true;
} foreach (units _grp);

sleep 2;
player setVariable ["GRLIB_squad_context_loaded", true, true];
