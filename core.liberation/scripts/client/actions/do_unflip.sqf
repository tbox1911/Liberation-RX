params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, true] call F_vehicleUnflip;
