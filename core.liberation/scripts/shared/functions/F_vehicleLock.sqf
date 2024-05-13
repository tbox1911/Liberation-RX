params [ "_vehicle", "_cmd", ["_uid",""]];
if (isNull _vehicle) exitWith {};

switch (_cmd) do {
	case "lock" : {
		_vehicle lockCargo true;
		_vehicle lockDriver true;
		for "_i" from 0 to (_vehicle emptyPositions "Cargo") do { _vehicle lockCargo  [_i, true] };
		{ _vehicle lockTurret [_x, true] } forEach (allTurrets _vehicle);
		_vehicle setVehicleLock "LOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle setVariable ["GRLIB_vehicle_owner", _uid, true];
		_vehicle setVariable ["GRLIB_counter_TTL", nil, true];
		_vehicle setVariable ["GRLIB_last_killer", nil, true];
		_vehicle engineOn false;
		_vehicle enableSimulationGlobal false;
	 };
	case "unlock" : {
		_vehicle lockCargo false;
		_vehicle lockDriver false;
		for "_i" from 0 to (_vehicle emptyPositions "Cargo") do { _vehicle lockCargo  [_i, false] };
		{ _vehicle lockTurret [_x, false] } forEach (allTurrets _vehicle);
		_vehicle setVehicleLock "UNLOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", false, true];
		_vehicle enableSimulationGlobal true;
		{_x reveal _vehicle} forEach (units GRLIB_side_friendly);
	};
	case "abandon" : {
		_vehicle lockCargo false;
		_vehicle lockDriver false;
		for "_i" from 0 to (_vehicle emptyPositions "Cargo") do { _vehicle lockCargo  [_i, false] };
		{ _vehicle lockTurret [_x, false] } forEach (allTurrets _vehicle);
		_vehicle setVehicleLock "UNLOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", false, true];
		_vehicle setVariable ["GRLIB_vehicle_owner", "", true];
		[_vehicle] call RPT_fnc_ResetVehicle;
		_vehicle enableSimulationGlobal true;
		{_x reveal _vehicle} forEach (units GRLIB_side_friendly);
	};
};
