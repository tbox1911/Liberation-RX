if (!isServer && hasInterface) exitWith {};
params [ "_vehicle", "_cmd"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, _cmd] call F_vehicleLock;
} else {
	private _owner = owner _vehicle;
	if (_owner != 0) then {
		[_vehicle, _cmd] remoteExec ["F_vehicleLock", _owner];
	};
};
