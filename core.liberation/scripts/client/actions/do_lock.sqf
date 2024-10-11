params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

GRLIB_vehicle_lock = false;
private _prev_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];

if (local _vehicle) then {
	[_vehicle, "lock", PAR_Grp_ID] call F_vehicleLock;
} else {
	[_vehicle, "lock", PAR_Grp_ID] remoteExec ["vehicle_lock_remote_call", 2];
	sleep 1;
};

{
	if !(_x getVariable ["GRLIB_vehicle_owner", ""] in ["public", "server"]) then {
		_x setVariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];
	};
} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]) + (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);

if (typeOf _vehicle in uavs_vehicles) then {
	player disableUAVConnectability [_vehicle, true];
	player connectTerminalToUAV objNull;
};

hintSilent format [localize "STR_DO_LOCK", [typeOf _vehicle] call F_getLRXName];
if (_prev_owner != PAR_Grp_ID) then {
	gamelogic globalChat localize "STR_DO_LOCK_MSG";
};

sleep 0.5;
GRLIB_vehicle_lock = true;
