params [ "_vehicle"];
private _truck_load = _vehicle getVariable ["GRLIB_ammo_truck_load", []];
if ( count _truck_load > 0 ) then {
	[ _vehicle ] remoteExec ["unload_truck_remote_call", 2];
};
