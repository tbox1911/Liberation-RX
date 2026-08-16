params ["_vehicles", ["_fast", false]];
if (isNil "_vehicles") exitWith {};
if (typeName _vehicles != "ARRAY") then { _vehicles = [_vehicles] };

{
	[_x, _fast] spawn {
		params ["_vehicle", "_fast"];
		if (isNull _vehicle) exitWith {};
		if (!_fast) then {
			waitUntil { sleep 30; (GRLIB_global_stop == 1 || !alive _vehicle || [_vehicle, GRLIB_sector_size, GRLIB_side_friendly, 1] call F_getUnitsCount == 0) };
		};
		if (!alive _vehicle) exitWith {};
		if (_vehicle isKindOf "CAManBase") then {
			deleteVehicle _vehicle;
		} else {
			if (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "server") then { _vehicle setVariable ["GRLIB_vehicle_owner", "", true] };
			[_vehicle] spawn F_vehicleClean;
		};
	};
	sleep 0.1;
} forEach _vehicles;
