if (([getPlayerUID player] call F_getMobileRespawnsPlayer) select 1) exitWith {};

private _tent_cost = support_vehicles select {(_x select 0) == mobile_respawn} select 0 select 1;

if (resources_infantry + _tent_cost >= infantry_cap) then {
	hintSilent format [localize "STR_BEACON_UNPACK", resources_infantry];
} else {
	disableUserInput true;
	player playMove "AinvPknlMstpSlayWnonDnon_medic";
	sleep 2;
	removeBackpack player;
	sleep 6;
	buildtype = 9;
	build_unit = [mobile_respawn,[],1,[],[]];
	dobuild = 1;
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
};
