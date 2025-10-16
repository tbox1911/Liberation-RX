if (!isServer && hasInterface) exitWith {};
params ["_unit", "_msg", "_target"];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

[_unit, _msg] remoteExec ["speak_manager", owner _target];
