if (!isServer && hasInterface) exitWith {};
params ["_vehicle", ["_force", false]];

if (isNil "_vehicle") exitWith {};
if (isNull _vehicle) exitWith {};

if (local _vehicle) then {
	[_vehicle, _force] call F_vehicleUnflip;
} else {
	[_vehicle, _force] remoteExec ["F_vehicleUnflip", owner _vehicle];
};
