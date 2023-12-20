params ["_start", "_end", ["_interval",5]];

private _dir = _start vectorFromTo _end;
private _dist = _start distance2D _end;
private _ret = false;

for "_i" from 0 to _dist / _interval do {
    _pos = _start vectorAdd (_dir vectorMultiply (_interval * _i));
    if (surfaceIsWater _pos) exitWith { _ret = true };
};
_ret;
