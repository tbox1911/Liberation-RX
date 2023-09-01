params ["_vehicle", "_unit", ["_all",false]];

if (_vehicle iskindof "Steerable_Parachute_F") exitWith {};

waitUntil {sleep 0.1; (round (speed vehicle _vehicle) == 0 && (round(getPosATL _vehicle select 2) < 5)) || damage _vehicle > 0.8 || driver _vehicle == _unit || vehicle _unit == _unit};  // No eject when driving

if (_vehicle getVariable ["evacVeh", false]) exitWith {};

if (_all) then {
	_vehicle setVariable ["evacVeh", true];
	{ [_x, false] spawn F_ejectUnit; sleep 0.2} forEach (crew _vehicle);
	sleep 5; 	// lock vehicle evac
	_vehicle setVariable ['evacVeh', nil];
} else {
	[_unit, false] spawn F_ejectUnit;
};
