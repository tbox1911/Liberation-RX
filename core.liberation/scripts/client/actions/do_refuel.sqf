params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle] call is_local;

_vehicle setFuel (fuel _vehicle) + 0.10;
playSound "refuel";
hintSilent "Fuel refilling Done.";

deleteVehicle ((nearestObjects [(getPosATL _vehicle), ["Land_CanisterFuel_Red_F"], 15]) select 0);
