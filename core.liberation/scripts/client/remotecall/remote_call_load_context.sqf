if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_grp"];

hintSilent localize "STR_HINT_SQUAD_COMING";
waitUNtil { sleep 0.1; (local _grp) };

{ _x allowDamage false } foreach (units _grp);
private _pos = getPosATL player;
private _alt = _pos select 2;

{
    PAR_AI_bros = PAR_AI_bros + [_x];
    _x setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
    [_x] call PAR_fn_AI_Damage_EH;
    [_x] call F_fixModUnit;
    [_x] joinSilent (group player);
    while { _x distance2D _pos > 100 } do {
        if (surfaceIsWater _pos) then {
            _destpos = ([_pos, 3] call F_getRandomPos);
            _destpos set [2, _alt];
            _x setPosASL (ATLtoASL _destpos);
        } else {
            _x setPosATL (_pos getPos [4, random 360]);
        };
        sleep 0.1;
    };
    _x enableIRLasers true;
    _x enableGunLights "Auto";
    _x switchMove "AmovPercMwlkSrasWrflDf";
    _x playMoveNow "AmovPercMwlkSrasWrflDf";
    [_x] spawn {
        params ["_unit"];
        gamelogic globalChat format [localize "STR_LOG_SQUAD_ADD_UNIT",name _unit,rank _unit];
        sleep 5;
        _unit setDamage 0;
        [_unit, true] remoteExec ["allowDamage", 0];
    };
    sleep 0.3;
} foreach (units _grp);

sleep 2;
player setVariable ["GRLIB_squad_context_loaded", true, true];
hintSilent "";
