params ["_uid"];

// Player name
private _name = "Unknown";
{ if ((_x select 0) == _uid) exitWith {_name = (_x select 5)} } forEach GRLIB_player_scores;
diag_log format ["--- LRX Cleanup player %1 (%2)", _name, _uid];

// Remove PAR Marker
deletemarker format ["PAR_marker_%1", _uid];

// Remove tents too far
if (!isNil "GRLIB_mobile_respawn") then {
	private _my_tent = GRLIB_mobile_respawn select {
		!([_x, "FOB", GRLIB_fob_range] call F_check_near) &&
		isNull (_x getVariable "R3F_LOG_est_transporte_par") &&
		(_x getVariable ["GRLIB_vehicle_owner", ""] == _uid)
	};
	{
		GRLIB_mobile_respawn = GRLIB_mobile_respawn - [_x];
		deleteVehicle _x;
	} forEach _my_tent;
	publicVariable "GRLIB_mobile_respawn";
};

// Remove Taxi
// Untow vehicle near FOB
// Abandon Car too Far
private _my_veh = vehicles select {
	_x getVariable ["GRLIB_vehicle_owner", ""] == _uid ||
	_x getVariable ["GRLIB_taxi_owner", ""] == _uid
};
{
	if (_x getVariable ["GRLIB_taxi_owner", ""] == _uid) then {
		deletevehicle (_x getVariable ["GRLIB_taxi_helipad", objNull]);
		[_x, true, true] call F_vehicleClean;
	} else {
		if ([_x, "FOB", GRLIB_fob_range] call F_check_near) then {
			[_x] call F_vehicleUntow;
		} else {
			[_x, "abandon"] call F_vehicleLock;
		};
	};
} forEach _my_veh;

// Remove Units
private _mask = [format ["Bros_%1", _uid], format ["AI_%1", _uid]];
private _my_units = allUnits select { _x getVariable ["PAR_Grp_ID", ""] in _mask };
if (count _my_units > 0) then {
	{
		removeAllWeapons _x;
		deleteVehicle _x 
	} forEach _my_units;
};

private _text = format ["Bye bye %1, see you soon...", _name];
[gamelogic, _text] remoteExec ["globalChat", -2];
