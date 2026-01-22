params ["_vehicle"];

[player] call do_eject;
_vehicle setVehicleLock "LOCKED";
_vehicle lockCargo true;
sleep 1;
player setVariable ["GRLIB_taxi_called", nil, true];
