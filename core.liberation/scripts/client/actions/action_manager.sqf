[] call compile preprocessFile "scripts\client\actions\action_manager_check.sqf";

waituntil { sleep 1; GRLIB_player_spawned && (player getVariable ["GRLIB_score_set", 0] == 1)};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

private ["_near_spawn", "_near_spawnt"];

while { true } do {
	GRLIB_player_is_menuok = [] call is_menuok;
	GRLIB_player_score = [player] call F_getScore;
	GRLIB_player_near_lhd = (player distance2D lhd < GRLIB_fob_range);
	GRLIB_player_fobdistance = (player distance2D ([] call F_getNearestFob));
	GRLIB_player_near_outpost = [player, "OUTPOST", GRLIB_fob_range] call F_check_near;
	GRLIB_player_admin = (player == ([] call F_getCommander) || [] call is_admin);
	_near_spawn = [player, "SPAWNV", GRLIB_ActionDist_10] call F_check_near;
	_near_spawnt = [player, "SPAWNT", GRLIB_ActionDist_5] call F_check_near;
	GRLIB_player_near_base = (GRLIB_player_fobdistance < GRLIB_ActionDist_15 || GRLIB_player_near_lhd);
	GRLIB_player_near_spawn = (GRLIB_player_near_base || _near_spawn || _near_spawnt);
	GRLIB_player_owner_fob = (PAR_Grp_ID == ([getPosATL player] call F_getFobOwner));

	// FOB Sign Actions
	if ( (GRLIB_player_near_lhd || GRLIB_player_fobdistance < GRLIB_fob_range) && cursorObject isKindof FOB_sign) then {
		if (count (actionIDs cursorObject) == 0) then {
			cursorObject addAction ["<t color='#FFFFFF'>" + "-= Hall of Fame =-" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([5] call F_notice_hof) spawn BIS_fnc_dynamicText},"",989,true,true,"","GRLIB_player_is_menuok",5];
			cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_READ_ME" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{createDialog "liberation_notice"},"",988,true,true,"","GRLIB_player_is_menuok",5];
			cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_TIPS" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{createDialog "liberation_tips"},"",987,true,true,"","GRLIB_player_is_menuok",5];
			cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_NEWS" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([] call F_notice_news) spawn BIS_fnc_dynamicText},"",986,true,true,"","GRLIB_player_is_menuok",5];
			cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_METEO" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([] call F_notice_weather) spawn BIS_fnc_dynamicText},"",985,true,true,"","GRLIB_player_is_menuok",5];
		};
	};
	sleep 1;
};
