params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle] call vehicle_local;
_vehicle setVariable ["R3F_LOG_disabled", false, true];
_vehicle setVehicleLock "UNLOCKED";
_vehicle lockCargo false;
_vehicle lockDriver false;
_vehicle lockTurret [[0], false];
_vehicle lockTurret [[0,0], false];

hintSilent format [localize "STR_DO_UNLOCK", [typeOf _vehicle] call F_getLRXName];
