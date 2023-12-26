params ["_vehicle"];

_vehicle setVehicleLock "UNLOCKED";
_vehicle lockCargo false;
{ [_x, false] spawn F_ejectUnit; sleep 1 } forEach ([_vehicle] call taxi_cargo);
GRLIB_taxi_eject = true;
