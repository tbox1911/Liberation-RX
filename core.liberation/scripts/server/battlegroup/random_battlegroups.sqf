private ["_sleeptime", "_countplayers", "_all_fobs" ];

sleep ( 900 / GRLIB_csat_aggressivity );

while { GRLIB_csat_aggressivity > 0.9 && GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	
	waitUntil { sleep 60; count GRLIB_all_fobs > 1 };

	_sleeptime = (600 + floor random 600) / (([] call F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);
	if ( combat_readiness >= 70 ) then { _sleeptime = _sleeptime * 0.85 };
	if ( combat_readiness >= 90 ) then { _sleeptime = _sleeptime * 0.85 };
	sleep _sleeptime;

	if ( !isNil "GRLIB_last_battlegroup_time" ) then {
		waitUntil { sleep 60; time > ( GRLIB_last_battlegroup_time + (1200 / GRLIB_csat_aggressivity)) };
	};

	_countplayers = count (AllPlayers - (entities "HeadlessClient_F"));
	if (!opforcap_max && combat_readiness >= 70 && _countplayers > 1) then {
		if (count GRLIB_all_fobs > 1) then {
			diag_log format ["Spawn FOB BattleGroup at %1", time];
			_all_fobs = (allMapMarkers select { _x select [0,9] == "fobmarker" });
			[selectRandom _all_fobs] spawn spawn_battlegroup;
		} else {
			diag_log format ["Spawn Random BattleGroup at %1", time];
			[] spawn spawn_battlegroup;
		};
		stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
		publicVariable "stats_hostile_battlegroups";
		sleep 60;
	};

	private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots > 0 ) then {
		[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
		sleep 60;		
	};
};
