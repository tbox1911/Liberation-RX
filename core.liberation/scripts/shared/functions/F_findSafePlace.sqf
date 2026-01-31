params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];
// Water mode
//  0: position cannot be over water
//  2: position cannot be over land
// -1: to ignore

if (count _start_pos == 0) exitWith {[]};

private _big_building = ["Land_Communication_F", "Land_TTowerBig_1_F", "Land_Factory_Main_F", "Land_dp_mainFactory_F"];
private _object_type = ["TREE", "BUILDING", "HOUSE", "ROCK", "WALL", "FENCE", "HIDE", "FUELSTATION", "CHURCH", "WATERTOWER", "TRANSMITTER", "SHIPWRECK"];
if (!_on_road) then { _object_type append ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"] };
private _radius = 1;
private _maxalt = 120;
private _spawn_pos = [];
private _maxpos = [];

while { _radius < _max_radius } do {
    _spawn_pos = ([_start_pos, _radius] call F_getRandomPos);
    _spawn_pos set [2, 0.5];
    _maxpos = _spawn_pos vectorAdd [0,0,_maxalt];
    if (
        !(lineIntersects [ATLtoASL _spawn_pos, ATLtoASL _maxpos]) &&
        count (_spawn_pos isFlatEmpty [-1, -1, 0.5, (_size + 5), _water_mode, false]) != 0 &&
        count (nearestObjects [_spawn_pos, ["LandVehicle", "CAManBase"], (_size + 3)]) == 0 &&
        count (nearestObjects [_spawn_pos, ["House","House_F"], (_size + 7)]) == 0 &&
        count (nearestObjects [_spawn_pos, _big_building, (_size + 25)]) == 0 &&
        count (nearestTerrainObjects [_spawn_pos, _object_type, (_size + 4)]) == 0
    ) exitWith {};
    _radius = _radius + 0.2;
    sleep 0.01;
};

if (_radius >= _max_radius) then { _spawn_pos = [] };

if (count _spawn_pos == 0) then {
    diag_log format ["--- LRX Debug: Cant find suitable position at %1 - DGB: S%2:R%3:W%4", _start_pos,_size,_max_radius,_water_mode];
};

_spawn_pos;