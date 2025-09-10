private _tent_cost = support_vehicles select {(_x select 0) == mobile_respawn} select 0 select 1;

if ( _tent_cost > (infantry_cap - resources_infantry)) then {
	hintSilent format [localize "STR_BEACON_UNPACK", resources_infantry];
} else {
	disableUserInput true;
	player switchMove "AinvPknlMstpSlayWnonDnon_medic";
	player playMoveNow "AinvPknlMstpSlayWnonDnon_medic";
	sleep 2;
	removeBackpack player;
	sleep 6;
	buildtype = GRLIB_BuildTypeDirect;
	build_unit = [mobile_respawn,[],1,[],[],[],[]];
	dobuild = 1;
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
	waitUntil { sleep 0.5; dobuild == 0};
	if (build_confirmed == 3) then {
		player addBackpack mobile_respawn_bag;
		(backpackContainer player) setVariable ["GRLIB_mobile_respawn_bag", true, true];
		[(backpackContainer player), 0] remoteExec ["setMaxLoad", 2];
	};
};
