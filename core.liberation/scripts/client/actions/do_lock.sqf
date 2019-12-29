params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "LOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
_vehicle setVariable ["R3F_LOG_disabled", true, true];

_text = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
hintSilent format ["%1 is Locked !", _text];
