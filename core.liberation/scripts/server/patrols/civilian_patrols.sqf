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
		private _hc = [] call F_lessLoadedHC;
		if !(isNull _hc) then {
			[] remoteExec ["manage_one_civilian_patrol", owner _hc];
		} else {
			[] spawn manage_one_civilian_patrol;
		};
	};
	sleep 15;
};
