params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];
// Water mode
//  0: position cannot be over water
//  2: position cannot be over land
// -1: to ignore
if (count _start_pos == 0) exitWith {[]};

private _radius = 1;
private _maxalt = 120;
private _spawn_pos = [];
private _maxpos = [];

while { _radius < _max_radius } do {
    _spawn_pos = ([_start_pos, _radius] call F_getRandomPos);

    // Test water
    _wfree = true;
    if (_water_mode == 0) then {
        _wfree = !(surfaceIsWater _spawn_pos);
    };
    if (_water_mode == 2) then {
        _wfree = (surfaceIsWater _spawn_pos);
    };

    // Test roads
    _rfree = !(!_on_road && isOnRoad _spawn_pos);

    _vfree = false;
    _hfree = false;

    if (_rfree && _wfree) then {
        _spawn_pos set [2, 0.5];
        _maxpos = _spawn_pos vectorAdd [0, 0, _maxalt];

        // Test vertical
        _vfree = !(lineIntersects [ATLtoASL _spawn_pos, ATLtoASL _maxpos]);

        // Test horizontal - 360°
        if (_vfree) then {
            _hfree = true;
            private _angle = 0;
            while { _angle < 360 && _hfree } do {
                private _target_pos = _spawn_pos vectorAdd [_size * sin _angle, _size * cos _angle, 0];
                if (lineIntersects [ATLtoASL _spawn_pos, ATLtoASL _target_pos]) exitWith {
                    _hfree = false;
                };
                _angle = _angle + 10;
            };
        };
    };

    if (_vfree && _hfree) exitWith {};
    _radius = _radius + 0.2;
    sleep 0.01;
};

if (_radius >= _max_radius) then { _spawn_pos = [] };
if (count _spawn_pos == 0) then {
    diag_log format ["--- LRX Debug: Cant find suitable position at %1 - DGB: S%2:R%3:W%4", _start_pos, _size, _max_radius, _water_mode];
};
_spawn_pos;