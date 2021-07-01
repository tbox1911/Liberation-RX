private [ "_sleeptime", "_target_lst", "_target_player" ];

if ( isNil "infantry_weight" ) then { infantry_weight = 33 };
if ( isNil "armor_weight" ) then { armor_weight = 33 };
if ( isNil "air_weight" ) then { air_weight = 33 };

sleep 1800;

while { GRLIB_endgame == 0 } do {

	_sleeptime = (1800 + floor(random 1800)) / (([] call  F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);

	if ( combat_readiness >= 80 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 90 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 95 ) then { _sleeptime = _sleeptime * 0.75 };

	sleep _sleeptime;

	waitUntil {
		sleep 5;
	 	combat_readiness >= 70 && (armor_weight >= 70 || air_weight >= 70);
	 };

	_target_lst = [allPlayers, {score _x >= GRLIB_perm_tank}] call BIS_fnc_conditionalSelect;

	if ( count _target_lst > 1 ) then {
		_target_player = selectRandom _target_lst;
		if (armor_weight >= 70) then {
			armor_weight = armor_weight - 35;
		} else {
			air_weight = air_weight - 40;
		};
		_msg = format ["<img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/><br/><t color='#0000FF'>%1</t> is now the <t color='#808080'>'Bete Noire'</t> of the <t color='#F00000'>OPFor</t>!<br/><br/>You better take cover...<br/><img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/>", name _target_player, getMissionPath "res\skull.paa"];
		[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];

		[getpos _target_player, GRLIB_side_enemy] spawn spawn_air;
		[getpos _target_player] spawn send_paratroopers;

	};
};