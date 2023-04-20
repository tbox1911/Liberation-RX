if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_veh", "_cmd" ];

if (!isNil "garage_in_use") exitWith {["Garage is busy !!\nPlease wait..."] remoteExec ["hintSilent", owner _unit]};
garage_in_use = true;

if (_cmd == 1) then {
	_owner = _veh getVariable ["GRLIB_vehicle_owner", ""];
	_color = _veh getVariable ["GRLIB_vehicle_color", ""];
	_ammo = [_veh] call F_getVehicleAmmoDef;
	_lst_a3 = weaponsItemsCargo _veh;
	_lst_r3f = [];
	{ _lst_r3f pushback (typeOf _x)} forEach (_veh getVariable ["R3F_LOG_objets_charges", []]);
	GRLIB_garage append [[typeOf _veh, _color, _ammo, _owner, _lst_a3, _lst_r3f]];
	[_veh] call clean_vehicle;
	deleteVehicle _veh;
};

if (_cmd == 2) then {
	_veh_info = GRLIB_garage select _veh;
	[_veh_info] remoteExec ["remote_call_garage", owner _unit];
	GRLIB_garage deleteAt _veh;
};

publicVariable "GRLIB_garage";
trigger_server_save = true;
sleep 3;
garage_in_use = nil;