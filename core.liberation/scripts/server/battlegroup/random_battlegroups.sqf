private [ "_sleeptime", "_countplayers" ];

if (isNil "bg_sleeptimer") then {bg_sleeptimer = 1800};

if (combat_readiness <= 0) then {combat_readiness = 1};

sleep ( bg_sleeptimer / combat_readiness );

while { GRLIB_csat_aggressivity > 0.5 && GRLIB_endgame == 0 } do {

	_sleeptime =  (1800 + floor(random 1800)) / (([] call  F_adaptiveOpforFactor) * GRLIB_csat_aggressivity);

	if ( combat_readiness >= 30 ) then { _sleeptime = _sleeptime * 0.80 };
	if ( combat_readiness >= 50 ) then { _sleeptime = _sleeptime * 0.70 };
	if ( combat_readiness >= 80 ) then { _sleeptime = _sleeptime * 0.60 };

	sleep _sleeptime;

	if ( !isNil "GRLIB_last_battlegroup_time" ) then {
		waitUntil { sleep 5; time > ( GRLIB_last_battlegroup_time + ( 1800 / GRLIB_csat_aggressivity ) ) };
	};

	if ( (floor random 2 == 0) && ([] call F_opforCap < GRLIB_battlegroup_cap) && (combat_readiness >= bg_readiness_min) && (diag_fps > 25.0) && (playersNumber blufor >= 8))  then {
		[] spawn spawn_battlegroup;
	};
};
