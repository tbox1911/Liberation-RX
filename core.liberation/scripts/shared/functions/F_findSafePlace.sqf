params ["_start_pos", ["_size", 5], ["_water", false], ["_max_radius", 150]];

if (count _start_pos == 0) exitWith {[]};

private _water_mode = -1;
if (_water) then { _water_mode = 2 };
private _object_type = ["TREE", "BUILDING", "HOUSE", "ROCK", "WALL", "FENCE", "HIDE", "FUELSTATION", "CHURCH", "WATERTOWER", "TRANSMITTER", "SHIPWRECK"];
private _radius = 0;
private _spawn_pos = [];
while { _radius < _max_radius } do {
    _spawn_pos = [(_start_pos select 0), (_start_pos select 1)] getPos [_radius, floor random 360];
    if (
        count (_spawn_pos isFlatEmpty [-1, -1, 0.5, (_size*2), _water_mode, false]) != 0 &&
        count (_spawn_pos nearEntities [["LandVehicle","CAManBase"], (_size*2)]) == 0 &&
        count (nearestTerrainObjects [_spawn_pos, _object_type, (_size*2)]) == 0
    ) exitWith {};
    _radius = _radius + 1;
    sleep 0.01;
};

if (count _spawn_pos == 0 || _radius >= _max_radius) then {
    diag_log format ["--- LRX Debug: Cant find suitable position at %1 DGB S%2:R%3:W%4", _start_pos,_size,_max_radius,_water];
    _spawn_pos = ([_size, _start_pos, _max_radius, 50, _water] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol);
};

_spawn_pos;