// LRX Patrols Manager
// by: pSiKO

if (GRLIB_patrols_activity == 0) exitWith {};

sleep 300;
diag_log "--- LRX Starting Patrols Manager";

GRLIB_patrol_current = 0;
publicVariable "GRLIB_patrol_current";

GRLIB_patrol_sectors = [];
publicVariable "GRLIB_patrol_sectors";

GRLIB_patrol_sectors_list = [];
publicVariable "GRLIB_patrol_sectors_list";

while {true} do {
	if (GRLIB_patrol_current < GRLIB_patrol_amount && diag_fps > 15) then {
		private _search_sectors_all = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors - GRLIB_patrol_sectors);
		GRLIB_patrol_sectors_list = _search_sectors_all select {
			([markerPos _x, GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount > 0) &&
			([markerPos _x, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0)
		};
		publicVariable "GRLIB_patrol_sectors_list";

		if (count GRLIB_patrol_sectors_list > 0) then {
			private _level = round (20 + floor random 70);
			private _hc = [] call F_lessLoadedHC;
			if (isNull _hc) then {
				[_level] spawn manage_one_enemy_patrol;
			} else {
				[_level] remoteExec ["manage_one_enemy_patrol", owner _hc];
				diag_log format ["--- LRX Server: Patrol: %1 spawned on %2", _level, _hc];
			};
		};
	};
	sleep 60;
};
