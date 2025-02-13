params ["_pos", ["_dist", 120]];

private _armed_veh = vehicles select {
    (_x distance2D _pos < _dist) &&
    (typeOf _x in (militia_vehicles + opfor_vehicles)) &&
    (alive _x) && (count crew _x == 0)
};

if (count _armed_veh > 0) then {
    [_armed_veh select 0] call F_searchGunner;
};