params ["_start_pos", "_radius"];

private _pos = (_start_pos getPos [_radius * sqrt random 1, floor random 360]);
if (surfaceIsWater _start_pos) then {
	_pos set [2, -1.4 max (_start_pos select 2) + 0.1];
} else {
    _pos set [2, 0.1];
};

_pos;
