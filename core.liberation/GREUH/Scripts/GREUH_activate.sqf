desiredviewdistance_inf = viewDistance;
desiredviewdistance_veh = viewDistance;
desiredviewdistance_obj = 75;
desired_fps = 0;
show_teammates = false;
show_nametags = false;
show_platoon = false;
desired_vehvolume = 100;

greuh_options_profile = profileNamespace getVariable "GREUH_OPTIONS_PROFILE";
if ( !isNil "greuh_options_profile" ) then {
	desiredviewdistance_inf = greuh_options_profile select 0;
	desiredviewdistance_veh = greuh_options_profile select 1;
	desiredviewdistance_obj = greuh_options_profile select 2;
	show_teammates = greuh_options_profile select 3;
	show_platoon = greuh_options_profile select 4;
	if ( count greuh_options_profile > 5 ) then {
		desired_vehvolume = greuh_options_profile select 5;
		if ( isNil "desired_vehvolume" ) then {
			desired_vehvolume = 100;
		};
	};
	if ( count greuh_options_profile > 6 ) then {
		show_nametags = greuh_options_profile select 6;
		if ( isNil "show_nametags" ) then {
			show_nametags = false;
		};
	};
	if ( count greuh_options_profile > 7) then {
		desired_fps = greuh_options_profile select 7;
		if ( isNil "desired_fps" ) then {
			desired_fps = 0;
		};
	};
};

[] call compile preprocessFileLineNumbers "GREUH\GREUH_config.sqf";
[] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
[] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_revive_camera.sqf";
if ( GREUH_allow_mapmarkers ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_playermarkers.sqf"; };
if ( GREUH_allow_platoonview ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_platoonoverlay.sqf"; };
if ( GREUH_allow_platoonview ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_cache_units.sqf"; };
if ( GREUH_allow_customsquads ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_squadmanagement.sqf"; };
if ( GREUH_allow_viewdistance ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_view_distance_management.sqf"; };
if ( GREUH_allow_viewdistance ) then { [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_dynamic_view_distance.sqf"; };
if (!([] call F_getValid)) exitWith {endMission "LOSER"};
