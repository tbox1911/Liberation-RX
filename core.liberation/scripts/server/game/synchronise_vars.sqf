waitUntil {sleep 1; !isNil "save_is_loaded"};

private _blufor_sectors = [];
active_sectors = [];
publicVariable "active_sectors";

while { true } do {
	unitcap = {alive _x && !(captive _x) && (_x distance2D lhd) >= 200} count (units GRLIB_side_friendly);
	opforcap = {alive _x && !(captive _x)} count (units GRLIB_side_enemy);
	civcap = {alive _x && !(captive _x) && (isNil {_x getVariable "GRLIB_vehicle_owner"})} count (units GRLIB_side_civilian);
	opfor_sectors = (sectors_allSectors - blufor_sectors);

	if !(blufor_sectors isEqualTo _blufor_sectors) then {
		_blufor_sectors = blufor_sectors;
		publicVariable "blufor_sectors";
	};

	publicVariable "civcap";
	publicVariable "unitcap";
	publicVariable "opforcap";
	publicVariable "combat_readiness";
	publicVariable "resources_intel";

	sleep 5;
	stats_playtime = stats_playtime + 5;

	// private _player_left = count (AllPlayers - (entities "HeadlessClient_F"));
	// if (_player_left == 0) exitWith {
	// 	diag_log "--- Force LRX Mission End!";
	// 	[] call save_game_mp;
	// 	if (!GRLIB_server_persistent) then {
	// 		{ deleteMarker _x } forEach allMapMarkers;
	// 		{ deleteVehicle _x } forEach allUnits;
	// 		{ deleteVehicle _x } forEach vehicles;
	// 		endMission "END";
	// 		forceEnd;
	// 	};
	// };
};