params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	_vehicle lockCargo false;
	_vehicle lockDriver false;
	_vehicle lockTurret [[0], false];
	_vehicle lockTurret [[0,0], false];
	_vehicle setVehicleLock "UNLOCKED";
} else {
	[_vehicle, "unlock", player] remoteExec ["vehicle_lock_remote_call", 2];
	waitUntil { sleep 1; local _vehicle };
};

_vehicle setVariable ["R3F_LOG_disabled", false, true];
hintSilent format [localize "STR_DO_UNLOCK", [typeOf _vehicle] call F_getLRXName];
