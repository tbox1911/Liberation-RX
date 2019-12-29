diag_log "--- Client Init start ---";

[] execVM "scripts\client\commander\enforce_whitelist.sqf";
[] execVM "scripts\client\ui\intro.sqf";
[] execVM "scripts\client\misc\init_markers.sqf";

if ( typeOf player == "VirtualSpectator_F" ) exitWith {
	[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
	[] execVM "scripts\client\markers\fob_markers.sqf";
	[] execVM "scripts\client\markers\group_icons.sqf";
	[] execVM "scripts\client\markers\hostile_groups.sqf";
	[] execVM "scripts\client\markers\huron_marker.sqf";
	[] execVM "scripts\client\markers\sector_manager.sqf";
	[] execVM "scripts\client\markers\spot_timer.sqf";
	[] execVM "scripts\client\misc\synchronise_vars.sqf";
	[] execVM "scripts\client\ui\ui_manager.sqf";
};

respawn_lhd = compileFinal preprocessFileLineNumbers "scripts\client\spawn\respawn_lhd.sqf";
spawn_camera = compileFinal preprocessFileLineNumbers "scripts\client\spawn\spawn_camera.sqf";
cinematic_camera = compileFinal preprocessFileLineNumbers "scripts\client\ui\cinematic_camera.sqf";
write_credit_line = compileFinal preprocessFileLineNumbers "scripts\client\ui\write_credit_line.sqf";
do_load_box = compileFinal preprocessFileLineNumbers "scripts\client\ammoboxes\do_load_box.sqf";
set_rank = compileFinal preprocessFileLineNumbers "scripts\client\misc\set_rank.sqf";
kick_player = compileFinal preprocessFileLineNumbers "scripts\client\misc\kick_player.sqf";
vehicle_permissions = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_permissions.sqf";
fetch_permission = compileFinal preprocessFileLineNumbers "scripts\client\misc\fetch_permission.sqf";
clear_wpt = compileFinal preprocessFileLineNumbers "scripts\client\misc\clear_waypoints.sqf";
is_owner = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_owner.sqf";
player_EVH = compileFinal preprocessFileLineNumbers "addons\FAR_revive\FAR_EventHandler.sqf";

R3F_LOG_joueur_deplace_objet = objNull;
GRLIB_player_spawned = false;
disableMapIndicators [false,true,false,false];
[player, configfile >> "CfgVehicles" >> typeOf player] call BIS_fnc_loadInventory;
player setVariable ["GRLIB_score_set", nil, true];
player setVariable ["GREUH_ammo_count", GREUH_start_ammo, true];
if (isMultiplayer) then {
	MGI_Grp_ID = getPlayerUID player;
} else {
	MGI_Grp_ID = str round(random 4096);
};

[] execVM "scripts\client\ui\tutorial_manager.sqf";
[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\actions\action_manager.sqf";
[] execVM "scripts\client\actions\action_manager_veh.sqf";
[] execVM "scripts\client\actions\recycle_manager.sqf";
[] execVM "scripts\client\ammoboxes\ammobox_action_manager.sqf";
[] execVM "scripts\client\build\build_overlay.sqf";
[] execVM "scripts\client\build\do_build.sqf";
[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
[] execVM "scripts\client\markers\fob_markers.sqf";
[] execVM "scripts\client\markers\group_icons.sqf";
[] execVM "scripts\client\markers\hostile_groups.sqf";
[] execVM "scripts\client\markers\huron_marker.sqf";
[] execVM "scripts\client\markers\sector_manager.sqf";
[] execVM "scripts\client\markers\spot_timer.sqf";
[] execVM "scripts\client\misc\broadcast_squad_colors.sqf";
[] execVM "scripts\client\misc\disable_remote_sensors.sqf";
[] execVM "scripts\client\misc\sides_stats_manager.sqf";
//[] execVM "scripts\client\misc\offload_diag.sqf";
[] execVM "scripts\client\misc\permissions_warning.sqf";
[] execVM "scripts\client\misc\resupply_manager.sqf";
[] execVM "scripts\client\misc\secondary_jip.sqf";
[] execVM "scripts\client\misc\stop_renegade.sqf";
[] execVM "scripts\client\misc\synchronise_vars.sqf";
[] execVM "scripts\client\misc\protect_static.sqf";
[] execVM "scripts\client\misc\manage_weather.sqf";
[] execVM "scripts\client\ui\ui_manager.sqf";

// Group Managment
my_group = createGroup [GRLIB_side_friendly, true];
[player] joinSilent (my_group);
[my_group, "add"] remoteExec ["addel_group", 2];

// Init Tips Tables from XML
GREUH_TipsText = [];
{
	if (_x select [0, 1] != "t" && _x != "br") then {
    	GREUH_TipsText pushback (_x select [8]);
	};
} forEach ((localize "STR_TIPS_TEXT1") splitString "></");

{
	[_x] call BIS_fnc_drawCuratorLocations;
} foreach allCurators;

if (!GRLIB_ACE_enabled) then {
	[] execVM "scripts\client\misc\support_manager.sqf";
	[] execVM "addons\MGI\MGI_AI_Revive.sqf";
	[] execVM "addons\MGR\MagRepack_init.sqf";
	[] execVM "addons\NRE\NRE_init.sqf";
	[] execVM "addons\RPT\RPT_init.sqf";
	[] execVM "addons\fpsFix\vehicleManager.sqf";
	[] execVM "addons\KEY\shortcut_init.sqf";
};

// Sign Add
["<t size='2'>READ ME</t>", (getPos chimera_sign), 15, 0] spawn BIS_fnc_3Dcredits;
chimera_sign addAction ["<t color='#FFFFFF'>-= READ  ME =-</t>",{createDialog "liberation_notice"},"",999,true,true,"","",5];
chimera_sign addAction ["<t color='#FFFFFF'>-=   TIPS   =-</t>",{createDialog "liberation_tips"},"",998,true,true,"","",5];

diag_log "--- Client Init stop ---";