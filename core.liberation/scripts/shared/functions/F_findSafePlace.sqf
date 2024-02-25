params ["_start_pos", ["_size", 10], ["_water", 0]];

if (count _start_pos == 0) exitWith {[]};
private _max_try = 10;
private _radius = 100;
private _pos = zeropos;

while { _pos isEqualTo zeropos && _max_try > 0 } do {
    _pos = [_start_pos, 1, _radius, _size, _water, 0.25, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
    _radius = _radius + 15;
    _max_try = _max_try - 1;
    sleep 0.2;
};

if (_pos isEqualTo zeropos) then {
    _pos = _start_pos findEmptyPosition [0, _radius, "B_Heli_Transport_01_F"];
};

_pos;
