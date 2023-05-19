params ["_unit1", "_unit2", "_vehicle"];

private _doeject = false;
private _role = (assignedVehicleRole _unit1) select 0;
if (isNil "_role") exitWith {moveOut _unit1};  // Eject unit
if (count GRLIB_all_fobs == 0 && typeOf _vehicle in [FOB_truck_typename,huron_typename]) exitWith {true}; // Allowed at start

private _msg = "";
if (!(_role == "cargo" || _vehicle isKindOf "Steerable_Parachute_F" || typeOf _vehicle in list_static_weapons)) then {
	if (GRLIB_permissions_param) then {
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

		_score = [player] call F_getScore;
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
	};

	if (GRLIB_permission_vehicles) then {
		if (!([_unit1, _vehicle] call is_owner) && !([_vehicle] call is_public)) then {
			_msg = localize "STR_PERMISSION_NO_OWN";
			if (isPlayer _unit1) then {
				playSound3D ["A3\Sounds_F\sfx\alarmcar.wss", _vehicle, false, getPosASL _vehicle, 1, 1, 500];
			};
			_doeject = true;
		};
	};

	if ( side _unit1 != GRLIB_side_friendly ) then {
		_doeject = true;
		_msg = localize "STR_PERMISSION_NO_PRI";
	};
};

if (_doeject) then {
	if (typeName _unit2 == "OBJECT") then {
		if (!isNull _unit2) then {
			switch (_role) do {
				case "driver": { _unit2 action ["moveToDriver", _vehicle] };
				case "commander": { _unit2 action ["moveToCommander", _vehicle] };
				case "gunner": { _unit2 action ["moveToGunner", _vehicle] };
				case "turret": { _unit2 action ["moveToTurret", _vehicle, (assignedVehicleRole _unit1) select 1] };
			};
		};
	};
	hintSilent _msg;
	if (speed _vehicle < 20) then { moveOut _unit1 };
} else {
	[_vehicle] spawn vehicle_defense;
	[_unit1, _vehicle] spawn vehicle_fuel;
};
