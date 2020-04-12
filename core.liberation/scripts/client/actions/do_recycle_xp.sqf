params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle] remoteExec ["deleteVehicle", 2];
[player, 50] remoteExec ["addScore", 2];
playSound "taskSucceeded";
hint format ["%1\nScore + 50 Pts!", name player];