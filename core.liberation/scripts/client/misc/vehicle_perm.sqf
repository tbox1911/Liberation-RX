params ["_unit1", "_unit2", "_vehicle"];

private _doeject = false;
if (_vehicle iskindof "ParachuteBase") exitWith { _doeject };

// Allowed at start
private _vehicle_class = typeOf _vehicle;
if (count GRLIB_all_fobs == 0 && _vehicle_class in [FOB_truck_typename,FOB_boat_typename,huron_typename]) exitWith { _doeject };

// No roles -> Eject unit
private _info = (assignedVehicleRole _unit1);
if (count _info == 0) exitWith { [_unit1, false] spawn F_ejectUnit; true };

// Vehicle towed
if !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull])) exitWith { [_unit1, false] spawn F_ejectUnit; true };

private _role = _info select 0;
private _turret = [0];
if (count _info == 2) then { _turret = _info select 1 };

private _msg = "";
if (!(_role == "cargo" || _vehicle_class in list_static_weapons)) then {
	private _owner = [_unit1, _vehicle] call is_owner;
	private _public = [_vehicle] call is_public;
	if (!_owner && !_public) exitWith {
		_msg = localize "STR_PERMISSION_NO_OWN";
		_doeject = true;
	};

	if !(_unit1 getVariable ["GRLIB_is_prisoner", true]) exitWith {
		_msg = localize "STR_PERMISSION_NO_PRI";
		_doeject = true;
	};

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

		private _score = [player] call F_getScore;
		if (_vehicle_class in elite_vehicles && _score < GRLIB_perm_max) then {
			_doeject = true;
			_msg = localize "STR_PERMISSION_NO_VIP";
		};

		if (_vehicle_class in support_vehicles_classname && _score < GRLIB_perm_inf) then {
			_doeject = true;
			_msg = localize "STR_PERMISSION_NO_SUP";
		};
	};
};

if (_doeject) then {
	if (isPlayer _unit1) then {
		playSound3D ["A3\Sounds_F\sfx\alarmcar.wss", _vehicle, false, getPosASL _vehicle, 1, 1, 300];
	};
	[_unit1, false] spawn F_ejectUnit;
	if (typeName _unit2 == "OBJECT") then {
		if (!isNull _unit2) then {
			switch (_role) do {
				case "driver": { _unit2 action ["moveToDriver", _vehicle] };
				case "commander": { _unit2 action ["moveToCommander", _vehicle] };
				case "gunner": { _unit2 action ["moveToGunner", _vehicle] };
				case "turret": {_unit2 action ["moveToTurret", _vehicle, _turret] };
			};
		};
	};
	hintSilent _msg;
	gamelogic globalChat _msg;
} else {
	_vehicle setVariable ["GRLIB_counter_TTL", nil, true];
	_vehicle setVariable ["GRLIB_last_killer", nil, true];
	_vehicle setVariable ["GRLIB_mission_AI", nil, true];
};

_doeject;