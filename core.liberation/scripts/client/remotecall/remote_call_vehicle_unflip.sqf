params [ "_vehicle" ];

if (isNil "_vehicle") exitWith {};
if (!local _vehicle) exitWith {};

_vehicle allowDamage false;
sleep 1;
[_vehicle] call F_vehicleUnflip;
sleep 1;
_vehicle allowDamage true;
