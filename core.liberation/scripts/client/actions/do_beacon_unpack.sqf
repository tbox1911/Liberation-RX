private _tent_cost = support_vehicles select {(_x select 0) == mobile_respawn} select 0 select 1;

if (resources_infantry + _tent_cost >= infantry_cap) then {
	hintSilent format ["No Enought ManPower: %1", resources_infantry];
} else {
	disableUserInput true;
	player playMove "AinvPknlMstpSlayWnonDnon_medic";
	sleep 2;
	removeBackpack player;
	sleep 6;
	_tent = createVehicle [mobile_respawn, player modelToWorld [0,4,1], [], 0, "CAN_COLLIDE"];
	[_tent, "add"] remoteExec ["addel_beacon_remote_call", 2];
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
};