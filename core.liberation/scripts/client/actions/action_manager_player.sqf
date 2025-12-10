[] call compile preprocessFileLineNumbers "scripts\client\actions\action_manager_player_check.sqf";

GRLIB_player_fob_actions = [];
GRLIB_activated_sectors = [];
GRLIB_activated_radius = GRLIB_sector_size * 1.4;

waituntil {sleep 1; GRLIB_player_configured};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

private ["_near_spawn", "_near_spawn_tent", "_next_sector"];

private _ticks = 0;
while {true} do {
	GRLIB_player_is_menuok = [] call is_menuok;

	if (_ticks % 4 == 0) then {
		GRLIB_player_nearest_fob = ([player] call F_getNearestFob);
		GRLIB_player_fobdistance = (player distance2D GRLIB_player_nearest_fob);
		GRLIB_player_near_fob = (GRLIB_player_fobdistance <= GRLIB_fob_range);
		GRLIB_player_near_lhd = (player distance2D lhd <= GRLIB_fob_range);
		[GRLIB_player_near_fob] call player_fob_actions;

		if (GRLIB_player_is_menuok) then {
			GRLIB_player_score = ([player] call F_getScore);
			GRLIB_player_near_outpost = [player, "OUTPOST", GRLIB_fob_range] call F_check_near;
			GRLIB_player_admin = ([] call is_admin);
			GRLIB_player_commander = ([player] call F_getCommander);
			_near_spawn = [player, "SPAWN", GRLIB_ActionDist_10] call F_check_near;
			_near_spawn_tent = [player, "SPAWNT", GRLIB_ActionDist_5] call F_check_near;
			GRLIB_player_near_base = (GRLIB_player_fobdistance <= GRLIB_ActionDist_15 || GRLIB_player_near_lhd);
			GRLIB_player_near_spawn = (GRLIB_player_near_base || _near_spawn || _near_spawn_tent);
			GRLIB_player_owner_fob = (PAR_Grp_ID == ([] call F_getFobOwner));
		} else {
			GRLIB_player_near_outpost = false;
			GRLIB_player_admin = false;
			GRLIB_player_commander = false;
			GRLIB_player_near_base = false;
			GRLIB_player_near_spawn = false;
			GRLIB_player_owner_fob = false;
		};

		// Warn Sector
		_next_sector = [GRLIB_activated_radius, player, opfor_sectors] call F_getNearestSector;
		if (_next_sector != "" && !(_next_sector in GRLIB_activated_sectors)) then {
			_dist_sector = (player distance2D (markerPos _next_sector));
			if (_dist_sector <= GRLIB_activated_radius) then {
				GRLIB_activated_sectors pushBackUnique _next_sector;
				[_next_sector] spawn {
					params ["_sector"];
					private _marker_pos = markerPos _sector;
					private _player_dist = player distance2D _marker_pos;
					if (_player_dist > GRLIB_sector_size) then {
						private _msg = localize "STR_NOTIFICATION_ENTER_TERRITORY";
						[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
						sleep 3;
					};
					while {(_player_dist <= GRLIB_activated_radius)} do {
						_player_dist = player distance2D _marker_pos;
						if (_player_dist < GRLIB_sector_size) exitWith {
							private _msg = format [localize "STR_NOTIFICATION_ENTER_SECTOR", markerText _sector];
							[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
							sleep 3;
						};
						sleep 1;
					};
					waitUntil { sleep 10; (player distance2D _marker_pos > GRLIB_activated_radius)};
					GRLIB_activated_sectors = GRLIB_activated_sectors - [_sector];
				};
			};
		};
	};

	_ticks = _ticks + 1;
	if (_ticks >= 65535) then { _ticks = 0 };
	sleep 0.25;
};
