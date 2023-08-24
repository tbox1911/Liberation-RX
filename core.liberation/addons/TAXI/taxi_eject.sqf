params ["_target"];

GRLIB_taxi_eject = true;
{ [_x, false] spawn F_ejectUnit; sleep 1 } forEach ([_target] call taxi_cargo);
