if (!isServer && hasInterface) exitWith {};
params [ "_vehicle", "_cmd", "_player" ];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, _cmd] call F_vehicleLock;
} else {
	[_vehicle, _cmd] remoteExec ["F_vehicleLock", (owner _vehicle)];
};
