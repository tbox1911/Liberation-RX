params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

GRLIB_vehicle_lock = false;
if (local _vehicle) then {
	[_vehicle, "unlock"] call F_vehicleLock;
} else {
	[_vehicle, "unlock"] remoteExec ["vehicle_lock_remote_call", 2];
	sleep 1;
};

hintSilent format [localize "STR_DO_UNLOCK", [typeOf _vehicle] call F_getLRXName];

sleep 0.5;
GRLIB_vehicle_lock = true;
