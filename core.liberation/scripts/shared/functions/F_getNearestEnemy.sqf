params ["_unit"];

private _enemy_side = GRLIB_side_enemy;
if (side group _unit == GRLIB_side_enemy) then {
    _enemy_side = GRLIB_side_friendly;
};

private _vehicle = objectParent _unit;
private _vehicle_class = typeOf _vehicle;
private _next_target = objNull;
private _scan_target = [];

if (isNull _vehicle || (_vehicle_class isKindOf "StaticMortar")) then {
    // Default Mortar
    _scan_target = [(units _enemy_side), { alive _x && _x distance2D _unit <= 2000 && isNull (objectParent _x)}] call BIS_fnc_conditionalSelect;
    _vehicle = _unit;
} else {
    // Default for HMG, GMG
    private _kind = ["Man"];
    private _dist = 1000;
    
    // Default for AA, AC
    if (_vehicle_class isKindOf "AT_01_base_F") then {_dist = 1500; _kind = ["Car", "APC", "Tank"]};
    if (_vehicle_class isKindOf "AA_01_base_F") then {_dist = 2000; _kind = ["Air"]};

    _scan_target = [ ((getPosATL _vehicle) nearEntities [ _kind, _dist]), {
        alive _x &&
        side group _x == _enemy_side &&
        !(_x getVariable ['R3F_LOG_disabled', false])
    } ] call BIS_fnc_conditionalSelect;
};

if (count (_scan_target) > 0) then {
    // closest first
    private _target_list = _scan_target apply {[_x distance2D _vehicle, _x]};
    _target_list sort true;
    _next_target = _target_list select 0 select 1;

    private _enemy_dir = _vehicle getDir _next_target;
    private _rel_diff = abs (_enemy_dir - (getDir _vehicle));
    if (_rel_diff > 30) then {
        _vehicle setDir _enemy_dir;
    };

    _unit doTarget _next_target;
    if (_vehicle_class isKindOf "StaticMortar") then {
        _vehicle fireAtTarget [_next_target];
        sleep 15;
    };
} else {
    _unit doTarget objNull;
};

_next_target;
