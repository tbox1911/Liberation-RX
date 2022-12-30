private [ "_sleeptime", "_target_lst", "_target_player" ];
_spawn_marker = "";
if ( isNil "infantry_weight" ) then { infantry_weight = 33 };
if ( isNil "armor_weight" ) then { armor_weight = 33 };
if ( isNil "air_weight" ) then { air_weight = 33 };

sleep 1800;

while { GRLIB_endgame == 0 } do {

	_sleeptime = (1800 + floor(random 1800)) / (([] call  F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);

	if ( combat_readiness >= 30 ) then { _sleeptime = _sleeptime * 0.80 };
	if ( combat_readiness >= 50 ) then { _sleeptime = _sleeptime * 0.70 };
	if ( combat_readiness >= 80 ) then { _sleeptime = _sleeptime * 0.60 };

	sleep _sleeptime;

	waitUntil {
		sleep 5;
	 	combat_readiness >= bg_readiness_min && (armor_weight >= 50 || air_weight >= 50);
	 };

	_target_lst = [allPlayers, {score _x >= GRLIB_perm_tank}] call BIS_fnc_conditionalSelect;

	if ( ( count _target_lst > 1 ) && (combat_readiness >= bg_readiness_min) ) then {
		_target_player = selectRandom _target_lst;
		if (armor_weight >= 50) then {
			armor_weight = armor_weight - 20;
		} else {
			air_weight = air_weight - 30;
		};

		_spawn_marker = [ GRLIB_spawn_min, GRLIB_spawn_max, false ] call F_findOpforSpawnPoint;
		private _objectivepos = ([markerPos _spawn_marker] call F_getNearestBluforObjective) select 0;

		[_objectivepos, GRLIB_side_enemy] spawn spawn_air;

		[getpos _target_player] spawn send_paratroopers;

	};
};