waitUntil { sleep 10; !isNil "GRLIB_all_fobs" };
waitUntil { sleep 10; !isNil "blufor_sectors" };

GRLIB_last_active_sectors = -1;

// active_sectors watcher
[] spawn {
    while {true} do {
        if (count active_sectors == 0) then {
            if (GRLIB_last_active_sectors < 0) then {
                GRLIB_last_active_sectors = time;
            };
        } else {
            GRLIB_last_active_sectors = -1;
        };
		sleep 5;
    };
};

sleep GRLIB_battlegroup_timer;

private ["_countplayers", "_attack"];
private _min_players = 2;
while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {

	waitUntil {
		sleep 10;
		(
			count GRLIB_all_fobs >= 1 &&
			count blufor_sectors >= 5 &&
			combat_readiness >= 50 &&
			time >= (GRLIB_last_battlegroup_time + GRLIB_battlegroup_timer) &&
			time >= (GRLIB_last_active_sectors + GRLIB_battlegroup_timer)
		)
	};

	_attack = false;
	_countplayers = (AllPlayers - (entities "HeadlessClient_F")) select { ([_x] call F_getScore >= GRLIB_perm_tank) };
	if (count _countplayers >= 2 && combat_readiness >= 55) then {
		_attack = true;
	};

	_countplayers = (AllPlayers - (entities "HeadlessClient_F")) select { ([_x] call F_getScore >= GRLIB_perm_log) };
	if (count _countplayers >= 3 && combat_readiness >= 70) then {
		_attack = true;
	};

	if (_attack) then {
		diag_log format ["Spawn Random BattleGroup at %1", time];
		[] spawn spawn_battlegroup;
		stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
		publicVariable "stats_hostile_battlegroups";
		sleep 60;
	};

	private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots > 0 ) then {
		[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
		sleep 60;
	};

	sleep 60;
};
