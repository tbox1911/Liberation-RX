params ["_unit", "_role", "_vehicle"];

private _doeject = false;
private _role = (assignedVehicleRole _unit) select 0;
if (isNil "_role") exitWith {false};  // Eject unit
if (count GRLIB_all_fobs == 0 && typeOf _vehicle in [FOB_truck_typename,huron_typename]) exitWith {true}; // Allowed at start

private _msg = "";
if (!((_role == "cargo") || (_vehicle isKindOf "Steerable_Parachute_F"))) then {
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
	if ((typeOf _vehicle) in vip_vehicles && _score < GRLIB_perm_max) then {
		_doeject = true;
		_msg = "You are NOT allowed to use Special Vehicles.";
	};

	_support_vehicles = [];
	{_support_vehicles pushBack ( _x select 0 )} foreach (support_vehicles);
	if ((typeOf _vehicle) in _support_vehicles && _score < GRLIB_perm_inf) then {
		_doeject = true;
		_msg = "You are NOT allowed to use Support Vehicles.";
	};

	if (!([_unit, _vehicle] call is_owner)) then {
		_msg = "Wrong Vehicle Owner.\nAccess is Denied !!";
		if (isPlayer _unit) then {
			{
				if ((_x distance2D _vehicle) <= 500) then {
					[["A3\Sounds_F\sfx\alarmcar.wss", _vehicle, false,  getPos _vehicle, 1, 1, 500]] remoteExec ["playSound3D", owner _x];
				};
			} forEach allPlayers;
		};
		_doeject = true;
	};

	if ( side _unit != GRLIB_side_friendly ) then {
		_msg = "Prisoners NOT allowed to use vehicles !!";
		_doeject = true;
	};
};

if (_doeject) then {
	hintSilent _msg;
	moveOut _unit;
	sleep 3;
	hintSilent "";
};

!(_doeject);