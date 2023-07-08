params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, "unlock"] call F_vehicleLock;
} else {
	[_vehicle, "unlock", player] remoteExec ["vehicle_lock_remote_call", 2];
	waitUntil { sleep 1; local _vehicle };
};

hintSilent format [localize "STR_DO_UNLOCK", [typeOf _vehicle] call F_getLRXName];
