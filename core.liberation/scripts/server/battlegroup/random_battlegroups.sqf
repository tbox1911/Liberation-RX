private [ "_sleeptime", "_countplayers" ];

sleep ( 900 / GRLIB_csat_aggressivity );

while { GRLIB_csat_aggressivity > 0.9 && GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	_sleeptime =(1500 + floor(random 2100)) / (([] call F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);
	if ( combat_readiness >= 70 ) then { _sleeptime = _sleeptime * 0.85 };
	if ( combat_readiness >= 90 ) then { _sleeptime = _sleeptime * 0.85 };

	sleep _sleeptime;

	if ( !isNil "GRLIB_last_battlegroup_time" ) then {
		waitUntil { sleep 5; time > ( GRLIB_last_battlegroup_time + (2100 / GRLIB_csat_aggressivity)) };
	};

	_countplayers = count (AllPlayers - (entities "HeadlessClient_F"));
	if ((opforcap < GRLIB_battlegroup_cap) && (combat_readiness >= 75) && (diag_fps > 30.0) && _countplayers > 1) then {
		private _hc = [] call F_lessLoadedHC;
		if (isNull _hc) then {
			diag_log format ["Spawn Random BattleGroup at %1", time];
			[] spawn spawn_battlegroup;
		} else {
			diag_log format ["Spawn Random BattleGroup at %1 on %2", time, _hc];
			[] remoteExec ["spawn_battlegroup", owner _hc];
		};
		stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
	};

	private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots > 0 ) then {
		[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
	};

};