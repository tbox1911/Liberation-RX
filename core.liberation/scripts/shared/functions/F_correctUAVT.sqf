params [ "_unit" ];

if ((_unit getSlotItemName 612) != uavs_terminal_typename) exitWith {};
{ 
	if ((typeOf _x in uavs_vehicles) && ([_unit, _x] call is_owner) && !(_x getVariable ['R3F_LOG_disabled', false])) then {
		_unit enableUAVConnectability [_x, true];
	} else {
		_unit disableUAVConnectability [_x, true];
		if (getConnectedUAV _unit == _x) then {
			_unit connectTerminalToUAV objNull;
		};
	};
} forEach allUnitsUAV;
