if (!isServer && hasInterface) exitWith {};
params [ "_vehicle", "_cmd", "_player" ];
if (isNil "_vehicle") exitWith {};

if (!local _vehicle) then {
	_vehicle setOwner 2;
	waitUntil { sleep 0.1; local _vehicle };
};

switch (_cmd) do {
	case "lock" : {
		_vehicle lockCargo true;
		_vehicle lockDriver true;
		_vehicle lockTurret [[0], true];
		_vehicle lockTurret [[0,0], true];
		_vehicle setVehicleLock "LOCKED";
	 };
	case "unlock" : {
		_vehicle lockCargo false;
		_vehicle lockDriver false;
		_vehicle lockTurret [[0], false];
		_vehicle lockTurret [[0,0], false];
		_vehicle setVehicleLock "UNLOCKED";
	};
};

sleep 1;
_owner = owner _player;
if (_owner != 0) then {
	_vehicle setOwner _owner;
};
