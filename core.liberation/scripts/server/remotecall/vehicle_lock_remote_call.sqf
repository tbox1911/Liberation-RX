params [ "_vehicle", "_cmd", ["_uid",""]];

if (!isServer && hasInterface) exitWith {};
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, _cmd, _uid] call F_vehicleLock;
} else {
	private _owner = owner _vehicle;
	if (_owner != 0) then {
		[_vehicle, _cmd, _uid] remoteExec ["F_vehicleLock", _owner];
	};
};
