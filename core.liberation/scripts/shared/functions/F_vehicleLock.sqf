params [ "_vehicle", "_cmd"];
if (isNil "_vehicle") exitWith {};

switch (_cmd) do {
	case "lock" : {
		_vehicle lockCargo true;
		_vehicle lockDriver true;
		_vehicle lockTurret [[0], true];
		_vehicle lockTurret [[0,0], true];
		_vehicle setVehicleLock "LOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
	 };
	case "unlock" : {
		_vehicle lockCargo false;
		_vehicle lockDriver false;
		_vehicle lockTurret [[0], false];
		_vehicle lockTurret [[0,0], false];
		_vehicle setVehicleLock "UNLOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", false, true];
	};
};
