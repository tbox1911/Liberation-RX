[] call compile preprocessFileLineNumbers "scripts\client\actions\action_manager_check.sqf";

waituntil { sleep 1; GRLIB_player_spawned && (player getVariable ["GRLIB_score_set", 0] == 1)};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

private ["_near_spawn", "_near_spawnt"];
private _count = 1;
while { true } do {
	GRLIB_player_is_menuok = [] call is_menuok;
	if (_count % 4 == 0 && GRLIB_player_is_menuok) then {
		GRLIB_player_score = [player] call F_getScore;
		GRLIB_player_near_lhd = (player distance2D lhd < GRLIB_fob_range);
		GRLIB_player_nearest_fob = ([] call F_getNearestFob);
		GRLIB_player_fobdistance = (player distance2D GRLIB_player_nearest_fob);
		GRLIB_player_near_outpost = [player, "OUTPOST", GRLIB_fob_range] call F_check_near;
		GRLIB_player_admin = (player == ([] call F_getCommander) || [] call is_admin);
		_near_spawn = [player, "SPAWNV", GRLIB_ActionDist_10] call F_check_near;
		_near_spawnt = [player, "SPAWNT", GRLIB_ActionDist_5] call F_check_near;
		GRLIB_player_near_fob = (GRLIB_player_fobdistance < GRLIB_fob_range);
		GRLIB_player_near_base = (GRLIB_player_fobdistance < GRLIB_ActionDist_15 || GRLIB_player_near_lhd);
		GRLIB_player_near_spawn = (GRLIB_player_near_base || _near_spawn || _near_spawnt);
		GRLIB_player_owner_fob = (PAR_Grp_ID == ([] call F_getFobOwner));		
		_count = 0;
		sleep 0.5;
	};
	sleep 0.5;
	_count = _count + 1;
};
