params ["_pos", "_dist", "_mobile", "_list_redep"];

private _destdir = random 360;
if (_mobile) then {
    _pos = getPosATL _pos;
} else {
    private _sign = nearestObjects [_pos, [FOB_sign], 20] select 0;
    if (isNil "_sign") exitWith { _pos = []};
    private _fob_type = _sign getVariable ["GRLIB_fob_type", FOB_typename];
    if (_fob_type == FOB_outpost) then { _dist = 8 };
    _destdir = getDir _sign;
};

if (count _pos == 0) exitWith {};
player setDir _destdir;
player setPosATL (_pos getPos [_dist, (_destdir-180)]);

[_list_redep] spawn {
    params ["_list"];
    {
        _x action ["CancelAction", _x];
        sleep 0.1;
        _x setPosATL (player getPos [5, floor random 360]);
        sleep 0.4;
    } forEach _list;
};
