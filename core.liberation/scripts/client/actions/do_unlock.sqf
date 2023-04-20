params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "UNLOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["R3F_LOG_disabled", false, true];

_text = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
hintSilent format [localize "STR_DO_UNLOCK", _text];
