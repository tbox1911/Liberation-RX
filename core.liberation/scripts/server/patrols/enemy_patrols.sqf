// LRX Patrols Manager
// by: pSiKO

if (GRLIB_patrols_activity == 0) exitWith {};
manage_one_enemy_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_enemy_patrol.sqf";

sleep 300;
diag_log "--- LRX Starting Patrols Manager";

for "_i" from 1 to GRLIB_patrol_amount do {
	[round (25 + floor random 70)] spawn manage_one_enemy_patrol;
	sleep 30;
};

GRLIB_patrol_current = 0;
publicVariable "GRLIB_patrol_current";

while { true } do {
	if (GRLIB_patrol_current < GRLIB_patrol_amount) then {
		private _level = round (25 + floor random 70);
		private _hc = [] call F_lessLoadedHC;
		if !(isNull _hc) then {
			[_level] remoteExec ["manage_one_enemy_patrol", owner _hc];
		} else {
			[_level] spawn manage_one_enemy_patrol;
		};
	};
	sleep 30;
};
