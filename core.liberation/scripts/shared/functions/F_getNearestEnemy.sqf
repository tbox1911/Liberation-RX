params ["_unit"];

if !(local _unit) exitWith {};

private _enemy_nearby = [_unit, (GRLIB_sector_size * 2), GRLIB_side_friendly] call F_getUnitsCount;
if (_enemy_nearby == 0) exitWith {};

private _vehicle = objectParent _unit;
private _vehicle_class = typeOf _vehicle;

if (_unit getVariable ["last_engage_time", 0] > time) exitWith {};
if (isNull _vehicle) exitWith {};

// Default for HMG, GMG
private _kind = ["CAManBase"];
private _dist = GRLIB_sector_size;

// Default for AA, AC
if (_vehicle_class isKindOf "AT_01_base_F") then {_dist = (GRLIB_sector_size * 1.5); _kind = ["Car", "Wheeled_APC_F", "Tank"]};
if (_vehicle_class isKindOf "AA_01_base_F") then {_dist = (GRLIB_sector_size * 2); _kind = ["Air"]};

// Default Mortar
if (_vehicle_class isKindOf "StaticMortar") then { _dist = (GRLIB_sector_size * 1.5); _kind = ["CAManBase", "Car"]};

private _scan_target = (_vehicle nearEntities [_kind, _dist]) select {
    alive _x && side group _x == GRLIB_side_friendly &&
    !(_x getVariable ['R3F_LOG_disabled', false])
};

if (count (_scan_target) > 0) then {
    // closest first
    private _target_list = _scan_target apply {[_x distance2D _vehicle, _x]};
    _target_list sort true;
    private _next_target = (_target_list select 0 select 1);

    private _enemy_dir = _vehicle getDir _next_target;
    private _rel_diff = abs (_enemy_dir - (getDir _vehicle));
    if (_rel_diff > 30) then {
        _vehicle setDir _enemy_dir;
    };

    _unit doWatch _next_target;
    _unit doTarget _next_target;
    _unit reveal [_next_target, 4];
    if (_vehicle_class isKindOf "StaticMortar") then {
        _vehicle fireAtTarget [_next_target, currentWeapon _vehicle];
        sleep 5;
        _vehicle fireAtTarget [_next_target, currentWeapon _vehicle];
    };
    _unit setVariable ["last_engage_time", round (time + (3 * 60))];
} else {
    _unit doTarget objNull;
    _unit doWatch objNull;
};
