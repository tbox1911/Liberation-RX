private [ "_playtime_days", "_playtime_hours", "_playtime_minutes", "_playtime_seconds", "_comma", "_playtime_str" ];
if (isDedicated) exitWith {};

disableUserInput true;
player allowDamage false;
closeDialog 0;
if (lifestate player == "INCAPACITATED") then {
	"colorCorrections" ppEffectEnable false;
	"filmGrain" ppEffectEnable false;
};

["<t size = '2.5'>" + localize "STR_VICTORY_TITLE" + "</t>", 0, 0, 15, 0, 0, 90] spawn BIS_fnc_dynamicText;
playSound "worship";
sleep 20;

if ( isNil "cinematic_camera_started" ) then { cinematic_camera_started = false };
private _line_delay = 0.75;
private _page_delay = 5;

if (alive player && isNull objectParent player) then {
	player switchCamera "EXTERNAL";
	player switchMove "";
	player playMoveNow "acts_briefing_sb_in";
	uiSleep 14;
};

[] spawn cinematic_camera;

createDialog "liberation_endscreen";
waitUntil { dialog };

uiSleep 3;
_playtime_days = floor (stats_playtime / 86400);
_playtime_hours = floor ((stats_playtime % 86400) / 3600);
_playtime_minutes = floor ((stats_playtime % 3600) / 60);
_playtime_seconds = stats_playtime % 60;

_playtime_str = "";
_comma = "";
if ( _playtime_days > 0 ) then { _playtime_str = format [ "%1 %2" , _playtime_days, localize "STR_STATS_DAY" ]; _comma = ","; };
if ( _playtime_hours > 0 ) then { _playtime_str = format [ "%1%4 %2 %3" , _playtime_str, _playtime_hours, localize "STR_STATS_HOURS", _comma ]; _comma = ","; };
if ( _playtime_minutes > 0 ) then { _playtime_str = format [ "%1%4 %2 %3" , _playtime_str, _playtime_minutes, localize "STR_STATS_MINUTES", _comma ]; _comma = ","; };
if ( _playtime_seconds > 0 ) then { _playtime_str = format [ "%1%4 %2 %3" , _playtime_str, _playtime_seconds, localize "STR_STATS_SECONDS", _comma ]; _comma = ","; };

[ 690, format [ "%1 %2", localize "STR_STATS_PLAYTIME", _playtime_str ] ] call write_credit_line;

uiSleep 3;
disableUserInput false;
disableUserInput true;
disableUserInput false;
[ 691, format [ "%1 %2", localize "STR_STATS_1", stats_opfor_soldiers_killed ] ] call write_credit_line;
uiSleep _line_delay;
[ 692, format [ "%1 %2", localize "STR_STATS_2", stats_opfor_killed_by_players ] ] call write_credit_line;
uiSleep _line_delay;
[ 693, format [ "%1 %2", localize "STR_STATS_3", stats_blufor_soldiers_killed ] ] call write_credit_line;
uiSleep _line_delay;
[ 694, format [ "%1 %2", localize "STR_STATS_27", stats_blufor_soldiers_recruited ] ] call write_credit_line;
uiSleep _line_delay;
[ 695, format [ "%1 %2", localize "STR_STATS_4", stats_civilians_killed ] ] call write_credit_line;
uiSleep _line_delay;
[ 696, format [ "%1 %2", localize "STR_STATS_5", stats_civilians_killed_by_players ] ] call write_credit_line;
uiSleep _page_delay;
ctrlSetText [ 691, "" ];
ctrlSetText [ 692, "" ];
ctrlSetText [ 693, "" ];
ctrlSetText [ 694, "" ];
ctrlSetText [ 695, "" ];
ctrlSetText [ 696, "" ];

uiSleep _line_delay;
[ 691, format [ "%1 %2", localize "STR_STATS_7", stats_opfor_vehicles_killed ] ] call write_credit_line;
uiSleep _line_delay;
[ 692, format [ "%1 %2", localize "STR_STATS_8", stats_opfor_vehicles_killed_by_players ] ] call write_credit_line;
uiSleep _line_delay;
[ 693, format [ "%1 %2", localize "STR_STATS_9", stats_blufor_vehicles_killed ] ] call write_credit_line;
uiSleep _line_delay;
[ 694, format [ "%1 %2", localize "STR_STATS_10", stats_blufor_vehicles_built ] ] call write_credit_line;
uiSleep _line_delay;
[ 695, format [ "%1 %2", localize "STR_STATS_11", stats_vehicles_recycled ] ] call write_credit_line;
uiSleep _line_delay;
[ 696, format [ "%1 %2", localize "STR_STATS_12", stats_ammo_spent ] ] call write_credit_line;
uiSleep _page_delay;
ctrlSetText [ 691, "" ];
ctrlSetText [ 692, "" ];
ctrlSetText [ 693, "" ];
ctrlSetText [ 694, "" ];
ctrlSetText [ 695, "" ];
ctrlSetText [ 696, "" ];

uiSleep _line_delay;
[ 691, format [ "%1 %2", localize "STR_STATS_13", stats_sectors_liberated ] ] call write_credit_line;
uiSleep _line_delay;
[ 692, format [ "%1 %2", localize "STR_STATS_14", stats_sectors_lost ] ] call write_credit_line;
uiSleep _line_delay;
[ 693, format [ "%1 %2", localize "STR_STATS_15", stats_fobs_built ] ] call write_credit_line;
uiSleep _line_delay;
[ 694, format [ "%1 %2", localize "STR_STATS_16", stats_fobs_lost ] ] call write_credit_line;
uiSleep _line_delay;
[ 695, format [ "%1 %2", localize "STR_STATS_17", stats_secondary_objectives ] ] call write_credit_line;
uiSleep _line_delay;
[ 696, format [ "%1 %2", localize "STR_STATS_18", stats_prisonners_captured ] ] call write_credit_line;
uiSleep _page_delay;
ctrlSetText [ 691, "" ];
ctrlSetText [ 692, "" ];
ctrlSetText [ 693, "" ];
ctrlSetText [ 694, "" ];
ctrlSetText [ 695, "" ];
ctrlSetText [ 696, "" ];

uiSleep _line_delay;
[ 691, format [ "%1 %2", localize "STR_STATS_19", stats_hostile_battlegroups ] ] call write_credit_line;
uiSleep _line_delay;
[ 692, format [ "%1 %2", localize "STR_STATS_20", stats_reinforcements_called ] ] call write_credit_line;
uiSleep _line_delay;
[ 693, format [ "%1 %2", localize "STR_STATS_21", stats_readiness_earned ] ] call write_credit_line;
uiSleep _line_delay;
[ 694, format [ "%1 %2", localize "STR_STATS_22", stats_ieds_detonated ] ] call write_credit_line;
uiSleep _line_delay;
[ 695, format [ "%1 %2", localize "STR_STATS_23", stats_spartan_respawns ] ] call write_credit_line;
uiSleep _page_delay;
ctrlSetText [ 691, "" ];
ctrlSetText [ 692, "" ];
ctrlSetText [ 693, "" ];
ctrlSetText [ 694, "" ];
ctrlSetText [ 695, "" ];

uiSleep _line_delay;
[ 691, format [ "%1 %2", localize "STR_STATS_24", stats_player_deaths ] ] call write_credit_line;
uiSleep 2;
[ 692, format [ "%1 %2", localize "STR_STATS_6", stats_blufor_teamkills ] ] call write_credit_line;
uiSleep 2;
[ 693, format [ "%1 %2", localize "STR_STATS_25", floor(random 128) ] ] call write_credit_line;
uiSleep _page_delay;
ctrlSetText [ 691, "" ];
ctrlSetText [ 692, "" ];
ctrlSetText [ 693, "" ];

uiSleep _line_delay;
[ 693, localize "STR_STATS_26" ] call write_credit_line;
uiSleep _line_delay;
[ 694, localize "STR_STATS_28" ] call write_credit_line;
uiSleep _line_delay;
[ 695, localize "STR_STATS_29" ] call write_credit_line;

titleText [localize "STR_VICTORY_TITLE" ,"BLACK", 5];
waitUntil { !dialog };
cinematic_camera_started = false;
sleep 10;
endMission "END";
forceEnd;
