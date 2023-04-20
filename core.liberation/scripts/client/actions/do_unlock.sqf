params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "UNLOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["R3F_LOG_disabled", false, true];

hintSilent format [localize "STR_DO_UNLOCK", [typeOf _vehicle] call F_getLRXName];
