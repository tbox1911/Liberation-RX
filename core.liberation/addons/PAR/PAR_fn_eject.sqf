params ["_veh", "_unit", ["_all",false]];

_unit_eject = {
	params ["_veh", "_unit"];
	if (isNull _unit || !alive _unit) exitWith {};
	unAssignVehicle _unit;
	_unit allowDamage false;
	moveOut _unit;
	_unit setPos (getPosATL _veh vectorAdd [([[-15,0,15], 2] call F_getRND), ([[-15,0,15], 2] call F_getRND), 0]);
	if (round(getPosATL _unit select 2) > 20) then {
		_para = createVehicle ['Steerable_Parachute_F', (getPosATL _unit),[],0,'none'];
		_unit moveInDriver _para;
		sleep 1;
		if (isnull driver (_para)) then {deleteVehicle _para};
	};
	sleep 3;
	_unit allowDamage true;
};

if (_veh getVariable ["evacVeh", false]) exitWith {};
if (_veh iskindof "Steerable_Parachute_F") exitWith {};

waitUntil {sleep 1; (round (speed _veh) == 0 && (round(getPosATL _veh select 2) < 5)) || damage _veh > 0.8 || (round(getPosATL _veh select 2) > 20)};  // No eject when driving

if (_all) then {
	_veh setVariable ["evacVeh", true];
	{[_veh, _x] spawn _unit_eject} forEach crew _veh;
	//lock
	sleep 5;
	_veh setVariable ['evacVeh', nil];
} else {
	[_veh, _unit] spawn _unit_eject;
};
