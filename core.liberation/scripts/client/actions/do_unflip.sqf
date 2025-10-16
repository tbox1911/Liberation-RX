params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, true] call F_vehicleUnflip;
} else {
	[_vehicle, true] remoteExec ["vehicle_unflip_remote_call", 2];
};
