params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

GRLIB_vehicle_lock = false;

if (local _vehicle) then {
	[_vehicle, "abandon"] call F_vehicleLock;
} else {
	[_vehicle, "abandon"] remoteExec ["vehicle_lock_remote_call", 2];
};

hintSilent format [localize "STR_DO_ABANDON", [typeOf _vehicle] call F_getLRXName];

sleep 1;
GRLIB_vehicle_lock = true;
