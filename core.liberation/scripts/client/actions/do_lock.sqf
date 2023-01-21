params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "LOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
_vehicle setVariable ["R3F_LOG_disabled", true, true];
_vehicle setVariable ["GRLIB_counter_TTL", nil, true];

hintSilent format [localize "STR_DO_LOCK", [typeOf _vehicle] call F_getLRXName];
