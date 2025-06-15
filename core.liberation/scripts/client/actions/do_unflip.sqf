params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	_vehicle allowDamage false;
	sleep 1;
	[_vehicle, true] call F_vehicleUnflip;
	sleep 1;
	_vehicle allowDamage true;
} else {
	[_vehicle] remoteExec ["vehicle_unflip_remote_call", 2];
};
