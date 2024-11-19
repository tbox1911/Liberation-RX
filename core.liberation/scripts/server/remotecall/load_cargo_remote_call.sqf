if (!isServer && hasInterface) exitWith {};
params ["_vehicle", "_lst_a3", "_lst_r3f", "_lst_grl"];

if ( count _lst_a3 > 0 ) then {
    [_vehicle, _lst_a3] call F_setCargo;
};

if ( count _lst_r3f > 0 ) then {
    [_vehicle, _lst_r3f] call load_object_direct;
};

if ( count _lst_grl > 0 ) then {
    {[_vehicle, _x] call attach_object_direct} forEach _lst_grl;
};
