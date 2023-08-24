params ["_target"];

GRLIB_taxi_eject = true;
{ [_x] spawn F_ejectUnit } forEach ([_target] call taxi_cargo);
