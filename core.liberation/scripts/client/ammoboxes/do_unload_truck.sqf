params [ "_truck_to_unload"];

private _truck_load = _truck_to_unload getVariable ["GRLIB_ammo_truck_load", []];
if ( count _truck_load > 0 ) then {
	[ _truck_to_unload ] remoteExec ["unload_truck_remote_call", 0];
};