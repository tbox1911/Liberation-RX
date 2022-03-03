params ["_unit", "_role", "_vehicle"];

if (isNil "_role") exitWith {moveOut _unit;};  // Eject unit
private _doeject = false;
private _role = (assignedVehicleRole _unit) select 0;
if (count GRLIB_all_fobs == 0 && typeOf _vehicle in [FOB_truck_typename,huron_typename]) exitWith {true}; // Allowed at start

private _msg = "";
if (!(_role == "cargo" || _vehicle isKindOf "Steerable_Parachute_F")) then {
	if (!([player, 0] call fetch_permission)) then {
		_doeject = true;
		_msg = localize "STR_PERMISSION_NO_LIGHT";
	};

	if ((_vehicle isKindOf "Tank") || (_vehicle isKindOf "Wheeled_APC_F")) then {
		if (!([player, 1] call fetch_permission)) then {
			_doeject = true;
			_msg = localize "STR_PERMISSION_NO_ARMOR";
		};
	};

	if (_vehicle isKindOf "Air") then {
		if (!([player, 2] call fetch_permission)) then {
			_doeject = true;
			_msg = localize "STR_PERMISSION_NO_AIR";
		};
	};

	_score = score player;
	if ((typeOf _vehicle) in elite_vehicles && _score < GRLIB_perm_max) then {
		_doeject = true;
		_msg = localize "STR_PERMISSION_NO_VIP";
	};

	_support_vehicles = [];
	{_support_vehicles pushBack ( _x select 0 )} foreach (support_vehicles);
	if ((typeOf _vehicle) in _support_vehicles && _score < GRLIB_perm_inf) then {
		_doeject = true;
		_msg = localize "STR_PERMISSION_NO_SUP";
	};

	/*
	if (GRLIB_permission_vehicles) then {
		if (!([_unit, _vehicle] call is_owner) && !([_vehicle] call is_public)) then {
			_msg = localize "STR_PERMISSION_NO_OWN";
			if (isPlayer _unit) then {
				playSound3D ["A3\Sounds_F\sfx\alarmcar.wss", _vehicle, false, getPosASL _vehicle, 1, 1, 500];
			};
			_doeject = true;
		};
	};
	*/

	if ( side _unit != GRLIB_side_friendly ) then {
		_doeject = true;
		_msg = localize "STR_PERMISSION_NO_PRI";
	};
};

if (_doeject) then {
	hintSilent _msg;
	moveOut _unit;
} else {
	if (isPlayer _unit) then {
		[_vehicle] spawn vehicle_defense;
	};
};

