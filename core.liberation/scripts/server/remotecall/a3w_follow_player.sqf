if (!isServer && hasInterface) exitWith {};
params ["_unit", "_follow", "_second"];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

private _near_tent = {
    params ["_unit"];
    (count (_unit nearobjects [a3w_heal_tent, 12]) > 0);
};

// start
_unit allowDamage false;
_unit setVariable ["GRLIB_can_speak", false, true];
_unit stop false;
_unit setUnitPos "AUTO";
_unit enableAI "ANIM";
_unit enableAI "MOVE";
_unit setDamage 0.50;

// follow
private _timer = time + _second;
waitUntil {
    _unit doMove (getPos _follow);
    sleep 5;
    (time > _timer || ([_unit] call _near_tent))
};

// stop
_unit disableAI "ANIM";
_unit disableAI "MOVE";
_anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
_unit switchMove _anim;
_unit playMoveNow _anim;
_unit setDamage 0.50;
_unit setVariable ["GRLIB_can_speak", true, true];
_unit stop true;
_unit allowDamage true;

if ([_unit] call _near_tent) then {
    _unit setDamage 0;
    _unit setVariable ["GRLIB_can_speak", false, true];
    sleep 3;
    _unit setVariable ["GRLIB_A3W_Mission_HC2", nil, true];
    [_follow, 5] call F_addReput;
};
