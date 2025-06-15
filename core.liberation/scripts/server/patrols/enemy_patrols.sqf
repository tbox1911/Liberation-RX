// LRX Patrols Manager
// by: pSiKO

if (GRLIB_patrols_activity == 0) exitWith {};

sleep 300;
diag_log "--- LRX Starting Patrols Manager";

GRLIB_patrol_current = 0;
publicVariable "GRLIB_patrol_current";

GRLIB_patrol_sectors = [];
publicVariable "GRLIB_patrol_sectors";

while {true} do {
	if (GRLIB_patrol_current < GRLIB_patrol_amount) then {
		private _level = round (25 + floor random 70);
		private _hc = [] call F_lessLoadedHC;
		if (isNull _hc) then {
			[_level] spawn manage_one_enemy_patrol;
		} else {
			[_level] remoteExec ["manage_one_enemy_patrol", owner _hc];
			diag_log format ["--- LRX Server: Patrol: %1 spawned on %2", _level, _hc];
		};
	};
	sleep 60;
};
