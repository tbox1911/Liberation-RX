params [ "_vehicle", "_caller", "_actionId", "_arguments"];

private _truck_load = _vehicle getVariable ["GRLIB_ammo_truck_load", []];
if (count _truck_load > 0) then {
	[_vehicle, _arguments] remoteExec ["unload_truck_remote_call", 2];
};
