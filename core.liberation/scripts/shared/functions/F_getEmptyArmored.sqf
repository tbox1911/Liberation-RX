params ["_pos", ["_dist", 120]];

private _armed_veh = vehicles select {
    (_x distance2D _pos < _dist) &&
    (typeOf _x in (militia_vehicles + opfor_vehicles)) &&
    ([_x] call is_abandoned)
};

if (count _armed_veh > 0) then {
    [selectRandom _armed_veh] call F_searchGunner;
};