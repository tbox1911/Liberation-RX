// thanks to soldierXXXX
params ["_start", "_end", ["_precision", 0.10]];    //0.05

private ["_pos"];
private _ret = false;
private _dist = _start distance2D _end;

if (_dist < 100) exitWith { _ret };
if (_dist < 300) then { _precision = 0.20 };

for "_i" from 0 to 1 step _precision do {
    _pos = vectorLinearConversion [0, 1, _i, _start, _end, true];
    if (surfaceIsWater _pos) exitWith { _ret = true };
};
_ret;
