params ["_unit"];
if (isNull _unit) exitWith {};

[_unit, player] remoteExec ["prisoner_capture_remote_call", 2];
