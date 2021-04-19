private [ "_sleeptime", "_target_player", "_target_pos" ];

if ( isNil "infantry_weight" ) then { infantry_weight = 33 };
if ( isNil "armor_weight" ) then { armor_weight = 33 };
if ( isNil "air_weight" ) then { air_weight = 33 };

sleep 1800;

while { GRLIB_csat_aggressivity >= 0.9 && GRLIB_endgame == 0 } do {

	_sleeptime = (1800 + floor(random 1800)) / (([] call  F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);

	if ( combat_readiness >= 80 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 90 ) then { _sleeptime = _sleeptime * 0.75 };
	if ( combat_readiness >= 95 ) then { _sleeptime = _sleeptime * 0.75 };

	sleep _sleeptime;

	waitUntil {
		sleep 5;
	 	combat_readiness >= 70 && (armor_weight >= 50 || air_weight >= 50);
	 };

	 _target_player = objNull;
	 {
	 	if (!(isNull _target_player)) exitWith {};

	 	if (( armor_weight >= 50 ) && ((vehicle _x) isKindOf "Tank")) then {
	 		_target_player = _x;
	 	};

	 	if (( air_weight >= 50 ) && ((vehicle _x) isKindOf "Air")) then {
	 		_target_player = _x;
	 	};

	 } foreach allPlayers;

	 if (!(isNull _target_player)) then {
		 _targetsector = [99999, getpos _target_player] call F_getNearestSector;
		_msg = format ["<img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/><br/><t color='#0000FF'>%1</t> is now the <t color='#808080'>'Bete Noire'</t> of the <t color='#F00000'>OPFor</t>!<br/><br/>You better take cover...<br/><img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/>", name _target_player, getMissionPath "res\skull.paa"];
		[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];

		[markerPos _targetsector, GRLIB_side_enemy] spawn spawn_air;
		[_targetsector] spawn send_paratroopers;
	 };
};