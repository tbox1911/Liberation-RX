private [ "_sleeptime", "_target_lst", "_target" ];

if ( isNil "infantry_weight" ) then { infantry_weight = 33 };
if ( isNil "armor_weight" ) then { armor_weight = 33 };
if ( isNil "air_weight" ) then { air_weight = 33 };

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {

	_sleeptime = (1800 + floor(random 1800)) / (([] call  F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);

	if ( combat_readiness >= 80 && combat_readiness < 90) then { _sleeptime = _sleeptime * 0.95 };
	if ( combat_readiness >= 90 && combat_readiness < 95) then { _sleeptime = _sleeptime * 0.85 };
	if ( combat_readiness >= 95 ) then { _sleeptime = _sleeptime * 0.75 };

	sleep _sleeptime;

	waitUntil {
		sleep 5;
	 	combat_readiness >= 70 && (armor_weight >= 70 || air_weight >= 70);
	};

	_target_lst = allPlayers select { [_x] call F_getScore >= GRLIB_perm_tank && isNull objectParent _x };
	if ( GRLIB_endgame == 1 || GRLIB_global_stop == 1 ) exitWith {};
	if (count _target_lst > 1 && !opforcap_max && diag_fps >= 30.0) then {
		_target = selectRandom _target_lst;
		if (_target getVariable ["GRLIB_BN_timer", 0] < time) then {
			_target setVariable ["GRLIB_BN_timer", round (time + (30 * 60))];
			_msg = format ["<img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/><br/><t color='#0000FF'>%1</t> is now the <t color='#808080'>'Bete Noire'</t> of the <t color='#F00000'>OPFor</t>!<br/><br/>You better take cover...<br/><img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/>", name _target, getMissionPath "res\skull.paa"];
			[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];
			waitUntil {sleep 2; isNull objectParent _target};
			diag_log format ["Spawn Attack on player %1 at %2", name _target, time];
			[getPosATL _target, GRLIB_side_enemy, 3] spawn spawn_air;
			sleep 20;
			[getPosATL _target] spawn send_paratroopers;
		};
	};
};