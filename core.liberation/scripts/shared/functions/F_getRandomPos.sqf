params ["_start_pos", "_radius"];

private _pos = (_start_pos getPos [_radius, floor random 360]);
while { surfaceIsWater _pos } do {
     _pos = (_start_pos getPos [_radius, floor random 360]);
    sleep 0.1;
};

_pos set [2, 0];
_pos;
