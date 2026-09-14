params ["_start_pos", "_radius"];

private _oldZ = (_start_pos select 2) + 0.1;
private _pos = (_start_pos getPos [_radius * sqrt random 1, floor random 360]);
if (surfaceIsWater _start_pos) then {
	_pos set [2, -1.4 max _oldZ];
} else {
    _pos set [2, _oldZ];
};

_pos;
