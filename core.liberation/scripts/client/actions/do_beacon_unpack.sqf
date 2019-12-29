private _tent_cost = support_vehicles select {(_x select 0) == "Land_TentDome_F"} select 0 select 1;

if (resources_infantry + _tent_cost >= infantry_cap) then {
	hintSilent format ["No Enought ManPower: %1", resources_infantry];
} else {
	disableUserInput true;
	player playMove "AinvPknlMstpSlayWnonDnon_medic";
	sleep 2;
	removeBackpack player;
	sleep 6;
	createVehicle ["Land_TentDome_F", player modelToWorld [0,4,0], [], 0, "CAN_COLLIDE"];
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
};