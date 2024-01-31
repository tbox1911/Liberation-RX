params ["_vehicle"];

GRLIB_taxi_eject = true;

private _cargo = [_vehicle] call taxi_cargo;
if (count _cargo > 0) then {
    _vehicle setVehicleLock "UNLOCKED";
    _vehicle lockCargo false;
    { [_x, false] spawn F_ejectUnit; sleep 1 } forEach _cargo;
};

_vehicle setVehicleLock "LOCKED";
_vehicle lockCargo true;