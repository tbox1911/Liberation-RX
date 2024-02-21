params ["_missionPos"];

if (count _missionPos == 0) exitWith {[]};
private _max_try = 10;
private _radius = 100;
private _size = 20;
private _pos = [];

while { count _pos == 0 && _max_try > 0 } do {
    _pos = [_missionPos, 0, _radius, _size, 0, 0.25, 0] call BIS_fnc_findSafePos;
    _radius = _radius + 20;
    _max_try = _max_try -1;
    sleep 0.2;
};

_pos;
