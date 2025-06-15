params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];
// Water mode
//  0: position cannot be over water
//  2: position cannot be over land
// -1: to ignore

if (count _start_pos == 0) exitWith {[]};

private _big_building = ["Land_Communication_F", "Land_TTowerBig_1_F", "Land_Factory_Main_F", "Land_dp_mainFactory_F"];
private _object_type = ["TREE", "BUILDING", "HOUSE", "ROCK", "WALL", "FENCE", "HIDE", "FUELSTATION", "CHURCH", "WATERTOWER", "TRANSMITTER", "SHIPWRECK"];
if (!_on_road) then { _object_type append ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"] };
private _radius = 0;
private _spawn_pos = [];
while { _radius < _max_radius } do {
    _spawn_pos = [(_start_pos select 0), (_start_pos select 1)] getPos [_radius, floor random 360];
    if (
        count (_spawn_pos isFlatEmpty [-1, -1, 0.5, 10, _water_mode, false]) != 0 &&
        count (nearestObjects [_spawn_pos, ["LandVehicle", "CAManBase"], 7]) == 0 &&
        count (nearestObjects [_spawn_pos, ["House_F"], 12]) == 0 &&
        count (nearestObjects [_spawn_pos, _big_building, 30]) == 0 &&
        count (nearestTerrainObjects [_spawn_pos, _object_type, 7]) == 0
    ) exitWith {};
    _radius = _radius + 0.5;
    sleep 0.01;
};

if (count _spawn_pos == 0 || _radius >= _max_radius) then {
    diag_log format ["--- LRX Debug: Cant find suitable position at %1 DGB S%2:R%3:W%4", _start_pos,_size,_max_radius,_water_mode];
    _spawn_pos = ([_size, _start_pos, _max_radius, 50, true] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol);
};

_spawn_pos;