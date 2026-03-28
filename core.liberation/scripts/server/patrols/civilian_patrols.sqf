// LRX Civilian Manager
// by: pSiKO

if (GRLIB_civilian_activity == 0) exitWith {};
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";

sleep 200;
diag_log "--- LRX Starting Civilian Manager";

GRLIB_civilians_current = 0;
publicVariable "GRLIB_civilians_current";

GRLIB_civilian_sectors_list = [];
publicVariable "GRLIB_civilian_sectors_list";

while {true} do {
	if (GRLIB_civilians_current < GRLIB_civilians_amount && diag_fps > 25) then {
		private _search_sectors_all = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors);
		GRLIB_civilian_sectors_list = _search_sectors_all select { ([markerPos _x, GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount > 0) };
		publicVariable "GRLIB_civilian_sectors_list";

		if (count GRLIB_civilian_sectors_list > 0) then {
			private _hc = [] call F_lessLoadedHC;
			if !(isNull _hc) then {
				[] remoteExec ["manage_one_civilian_patrol", owner _hc];
			} else {
				[] spawn manage_one_civilian_patrol;
			};
		};
	};
	sleep 30;
};
