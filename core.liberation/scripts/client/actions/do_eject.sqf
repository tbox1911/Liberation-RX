params ["_vehicle"];
if (isNil "_vehicle") exitWith {};
[player, _vehicle] remoteExec ["eject_crew_remote_call", 2];
