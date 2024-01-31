if (!isServer && hasInterface) exitWith {};
params ["_unit", "_msg", "_target"];

[_unit, _msg] remoteExec ["speak_manager", owner _target];
