params ["_veh", "_unit", ["_all",false]];

if (_veh getVariable ["evacVeh", false]) exitWith {};
if (_veh iskindof "Steerable_Parachute_F") exitWith {};

waitUntil {sleep 0.1; (round (speed _veh) == 0 && (round(getPosATL _veh select 2) < 5)) || damage _veh > 0.8 || driver _veh == _unit || vehicle _unit == _unit};  // No eject when driving

if (_all) then {
	_veh setVariable ["evacVeh", true];
	{[_veh, _x] spawn PAR_unit_eject} forEach crew _veh;
	//lock
	sleep 5;
	_veh setVariable ['evacVeh', nil];
} else {
	[_veh, _unit] spawn PAR_unit_eject;
};
