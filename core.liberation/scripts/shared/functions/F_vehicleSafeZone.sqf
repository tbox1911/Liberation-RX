params ["_vehicle"];

private _nearest_fob = [_vehicle] call F_getNearestFob;
if (_vehicle distance2D _nearest_fob <= 20) exitWith { true };

private _near_helipad = ({ getObjectType _x >= 8 } count (nearestObjects [_vehicle, ["Helipad_base_F"], 20]) >= 1);
if (_vehicle distance2D _nearest_fob < GRLIB_fob_range && _near_helipad) exitWith { true };

false;
