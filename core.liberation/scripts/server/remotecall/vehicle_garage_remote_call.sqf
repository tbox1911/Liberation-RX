if (!isServer) exitWith {};
params [ "_unit", "_veh", "_cmd" ];

if (!isNil "garage_in_use") exitWith {["Garage is busy !!\nPlease wait..."] remoteExec ["hintSilent", owner _unit]};
garage_in_use = true;

if (_cmd == 1) then {
	_owner = _veh getVariable ["GRLIB_vehicle_owner", ""];
	_color = _veh getVariable ["GRLIB_vehicle_color", ""];

	GRLIB_garage append [[typeOf _veh, _color, _owner]];
	deleteVehicle _veh;
	sleep 1;
};

if (_cmd == 2) then {
	_veh_info = GRLIB_garage select _veh;
	_veh_class = _veh_info select 0;
	_color = _veh_info select 1;
	_owner = _veh_info select 2;
	GRLIB_garage deleteAt _veh;

	_new_veh = _veh_class createVehicle (getPos _unit);
	_new_veh allowDamage false;
	_new_veh setVehicleLock "LOCKED";
	_new_veh setVariable ["GRLIB_vehicle_owner", _owner, true];
	_new_veh setVariable ["R3F_LOG_disabled", true, true];
	[_new_veh, _color, "N/A", []] call RPT_fnc_TextureVehicle;
	sleep 1;
	_new_veh allowDamage true;
};

publicVariable "GRLIB_garage";
garage_in_use = nil;