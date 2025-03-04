params ["_pos", "_dist", "_mobile"];

if (_mobile) then { _pos = getPosATL _pos };
if (surfaceIsWater _pos) exitWith { [_pos] spawn do_onboard };

private _near_sign = nearestObjects [_pos, [FOB_sign], 20] select 0;
if (isNil "_near_sign" && !_mobile) exitWith {};

private _destdir = random 360;
if (_mobile) then {
    _dist = 5;
} else {
    private _near_outpost = ([_near_sign, "OUTPOST", 30] call F_check_near);
    if (_near_outpost) then { _dist = 8 };
    _destdir = getDir _near_sign;
};

private _unit_list = units group player;
private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then { { _unit_list pushBack _x } forEach units _my_squad };
private _list_redep = _unit_list select {
    !(isPlayer _x) && (isNull objectParent _x) &&
    (_x distance2D player <= 30) &&
    lifestate _x != 'INCAPACITATED'
};

player setDir _destdir;
player setPosATL (_pos getPos [_dist, (_destdir-180)]);

[_list_redep] spawn {
    params ["_list"];
    {
        _x setPosATL (player getPos [5, random 360]);
        _x action ["CancelAction", _x];
        sleep 0.5;
    } forEach _list;
};

