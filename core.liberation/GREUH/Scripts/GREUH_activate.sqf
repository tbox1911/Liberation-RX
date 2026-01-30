desiredviewdistance_inf = viewDistance;
desiredviewdistance_veh = (viewDistance + 1000);
desiredviewdistance_obj = 75;
desired_fps = 0;
show_teammates = true;
show_nametags = true;
show_platoon = true;
desired_vehvolume = 35;

greuh_options_profile = profileNamespace getVariable "GREUH_OPTIONS_PROFILE";
if ( !isNil "greuh_options_profile" ) then {
	desiredviewdistance_inf = greuh_options_profile select 0;
	desiredviewdistance_veh = greuh_options_profile select 1;
	desiredviewdistance_obj = greuh_options_profile select 2;
	show_teammates = greuh_options_profile select 3;
	show_platoon = greuh_options_profile select 4;
	show_nametags = greuh_options_profile select 5;
	desired_vehvolume = greuh_options_profile select 6;
	desired_fps = greuh_options_profile select 7;
};

switch (GREUH_allow_mapmarkers) do {
	case 0: { GREUH_allow_mapmarkers = true };
	case 1: { show_teammates = true; GREUH_allow_mapmarkers = false };
	case 2: { show_teammates = false; GREUH_allow_mapmarkers = false };
};
switch (GREUH_allow_platoonview) do {
	case 0: { GREUH_allow_platoonview = true };
	case 1: { show_platoon = true; GREUH_allow_platoonview = false };
	case 2: { show_platoon = false; GREUH_allow_platoonview = false };
};
switch (GREUH_allow_nametags) do {
	case 0: { GREUH_allow_nametags = true };
	case 1: { show_nametags = true; GREUH_allow_nametags = false };
	case 2: { show_nametags = false; GREUH_allow_nametags = false };
};

private _group_name = profileNamespace getVariable ["GRLIB_group_name", ""];
if (_group_name != "") then {
	(group player) setGroupIdGlobal [_group_name];
};

[] call compile preprocessFileLineNumbers "GREUH\GREUH_config.sqf";
[] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
[] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_platoonoverlay.sqf";

if ( GREUH_allow_viewdistance ) then {
	[] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_view_distance_management.sqf";
	//[] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_dynamic_view_distance.sqf";
};
if (!([] call F_getValid)) exitWith {endMission "LOSER"};
