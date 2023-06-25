params ["_target"];

GRLIB_taxi_eject = true;
{ [_target, _x] spawn F_ejectUnit } forEach ([_target] call taxi_cargo);
