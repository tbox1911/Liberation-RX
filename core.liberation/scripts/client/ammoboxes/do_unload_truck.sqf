params [ "_truck_to_unload"];

if ( _truck_to_unload getVariable ["GRLIB_ammo_truck_load", 0] > 0 ) then {
	_truck_to_unload setVariable ["GRLIB_ammo_truck_load", 0, true];
	[ _truck_to_unload ] remoteExec ["unload_truck_remote_call", 0];
	sleep 3;
	hint localize "STR_BOX_UNLOADED";
};