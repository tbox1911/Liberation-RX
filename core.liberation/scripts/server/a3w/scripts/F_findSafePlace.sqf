params ["_missionPos"];

private _max = 100;
private _pos = [];
private _start_pos = _missionPos;
if (count _missionPos == 0) exitWith { _pos };

while { count _pos == 0 && _max > 0 } do {
    _pos = _start_pos findEmptyPosition [10, 200, "B_Heli_Transport_01_F"];
    if (isOnRoad _pos || surfaceIsWater _pos) then { 
        _pos = [];
        _start_pos = _missionPos getPos [(floor random 150), random 360];
    };
    _max = _max - 1;
    sleep 0.1;
};

_pos;
