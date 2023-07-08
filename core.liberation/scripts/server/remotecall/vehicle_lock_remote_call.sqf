if (!isServer && hasInterface) exitWith {};
params [ "_vehicle", "_cmd", "_player" ];
if (isNil "_vehicle") exitWith {};

if (!local _vehicle) then {
	_vehicle setOwner 2;
	waitUntil { sleep 0.1; local _vehicle };
};

[_vehicle, _cmd] call F_vehicleLock;

sleep 1;
_owner = owner _player;
if (_owner != 0) then {
	_vehicle setOwner _owner;
};
