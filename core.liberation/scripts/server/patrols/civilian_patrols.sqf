// LRX Civilian Manager
// by: pSiKO

if (GRLIB_civilian_activity == 0) exitWith {};
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";

sleep 200;
diag_log "--- LRX Starting Civilian Manager";

GRLIB_civilians_current = 0;
publicVariable "GRLIB_civilians_current";

while {true} do {
	if (GRLIB_civilians_current < GRLIB_civilians_amount && diag_fps > 25) then {
		private _search_sectors_all = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors);
		private _civilian_sectors_list = _search_sectors_all select { ([markerPos _x, GRLIB_spawn_max, GRLIB_side_friendly, 1] call F_getUnitsCount > 0) };

		if (count _civilian_sectors_list > 0) then {
			private _sector_pos = markerPos (selectRandom _civilian_sectors_list);
			private _hc = [] call F_lessLoadedHC;
			if !(isNull _hc) then {
				[_sector_pos] remoteExec ["manage_one_civilian_patrol", owner _hc];
			} else {
				[_sector_pos] spawn manage_one_civilian_patrol;
			};
		};
	};
	sleep 30;
};
