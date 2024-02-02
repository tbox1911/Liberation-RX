if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params [ "_vehicle" ];

_vehicle allowDamage false;
sleep 1;
[_vehicle] call F_vehicleUnflip;
sleep 1;
_vehicle allowDamage true;
