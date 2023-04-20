if (!isServer) exitWith {};
params [ "_unit", "_veh", "_cmd" ];

if (!isNil "garage_in_use") exitWith {["Garage is busy !!\nPlease wait..."] remoteExec ["hintSilent", owner _unit]};
garage_in_use = true;

if (_cmd == 1) then {
	_owner = _veh getVariable ["GRLIB_vehicle_owner", ""];
	_color = _veh getVariable ["GRLIB_vehicle_color", ""];

	GRLIB_garage append [[typeOf _veh, _color, _owner]];
	deleteVehicle _veh;
};

if (_cmd == 2) then {
	_veh_info = GRLIB_garage select _veh;
	[_veh_info] remoteExec ["remote_call_garage", owner _unit];
	GRLIB_garage deleteAt _veh;
};

publicVariable "GRLIB_garage";
sleep 1;
garage_in_use = nil;