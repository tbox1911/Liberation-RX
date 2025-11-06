diag_log "--- Server Init start ---";

// EventHandler
addMissionEventHandler ['HandleDisconnect', {
	params ["_unit", "_id", "_uid", "_name"];
	if (_name select [0,3] in ["HC1", "HC2"]) exitWith {};
	[_unit, _uid, true] call save_context;
	[_unit, _uid] call cleanup_player;
	false;
}];

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	if (_name select [0,14] == "headlessclient") exitWith {};
	private _player_left = count (AllPlayers - (entities "HeadlessClient_F"));
	if (_player_left == 0) then {
		diag_log "--- LRX Mission End!";
		if (time < 300) then {
			diag_log format ["--- LRX MP Saving cooldown (no save done), %1sec remaining...", round (300 - time)];
		} else {
			[] call save_game_mp;
		};
		if (!GRLIB_server_persistent) then {
			{ deleteMarker _x } forEach allMapMarkers;
			{ deleteVehicle _x } forEach allUnits;
			{ deleteVehicle _x } forEach vehicles;
			endMission "END";
			forceEnd;
		};
	};
}];

GRLIB_active_commander = objNull;
publicVariable "GRLIB_active_commander";

addMissionEventHandler ["OnUserAdminStateChanged", {
	params ["_networkId", "_loggedIn", "_votedIn"];
	if (_loggedIn) then {
		GRLIB_active_commander = (_networkId getUserInfo 10);
		publicVariable "GRLIB_active_commander";
	} else {
		private _commander = (allPlayers select {(typeOf _x == commander_classname)});
		if (count _commander > 0) then {
			GRLIB_active_commander = _commander select 0;
		} else {
			GRLIB_active_commander = objNull;
		};
		publicVariable "GRLIB_active_commander";
		{unassignCurator _x} forEach allCurators;
	};
}];

// AI Skill
// skillMin, skillAimMin, skillMax, skillAimMax
[
 true,
 [
  [GRLIB_side_friendly, 0.52, 0.36, 0.81, 0.64 ],
  [GRLIB_side_enemy,    0.52, 0.36, 0.81, 0.64 ]
 ]
] call BIS_fnc_EXP_camp_dynamicAISkill;

// Terrain Quality / View Distance
// Low = 50 (NoGrass), Low = 40 (Grass), Normal = 25, High = 12.5, Very High = 6.25, Ultra = 3.125
if (isDedicated) then {
	setTerrainGrid 25;
	setViewDistance 1600;
	setObjectViewDistance [1000, 500];
};

// Relationship
civilian setFriend [GRLIB_side_friendly, 1];
civilian setFriend [GRLIB_side_enemy, 1];

GRLIB_side_friendly setFriend [civilian, 1];
GRLIB_side_enemy setFriend [civilian, 1];

GRLIB_side_enemy setFriend [GRLIB_side_friendly, 0];
GRLIB_side_friendly setFriend [GRLIB_side_enemy, 0];

// Init owner on map vehicles
{
	if (_x iskindof "LandVehicle" || _x iskindof "Air" || _x iskindof "Ship_F") then {
		_x removeAllMPEventHandlers "MPKilled";
		_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVehicleLock "UNLOCKED";
			_x setVariable ["GRLIB_vehicle_owner", "public", true];
		};
	};
} foreach vehicles;

// Init owner on user placed objects
{
	if (getObjectType _x >= 8 && !(_x iskindof "CAManBase")) then {
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVariable ["GRLIB_vehicle_owner", "server", true];
		};
	};
} forEach (allMissionObjects "");

// Init LRX vehicle paints
[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init_static.sqf";

// Init Chimera unit look
[] call compileFinal preprocessFileLineNumbers "scripts\server\game\chimera_units_overide.sqf";

// Cleanup
kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\kill_manager.sqf";
cleanup_player = compileFinal preprocessFileLineNumbers "scripts\server\game\cleanup_player.sqf";

// Load Objects
//attach_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\attach_object_direct.sqf";
load_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\load_object_direct.sqf";
save_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\save_object_direct.sqf";
init_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\init_object_direct.sqf";

// AI
add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_civ_waypoints_veh = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints_veh.sqf";
add_convoy_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_convoy_waypoints.sqf";
defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\defence_ai.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
battlegroup_ai_direct = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai_direct.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
convoy_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\convoy_ai.sqf";
escape_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\escape_ai.sqf";
civilian_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\civilian_ai.sqf";
civilian_ai_veh = compileFinal preprocessFileLineNumbers "scripts\server\ai\civilian_ai_veh.sqf";
prisoner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisoner_ai.sqf";
prisoner_ai_loop = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisoner_ai_loop.sqf";
prisoner_captured = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisoner_captured.sqf";
bomber_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\bomber_ai.sqf";
patrol_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\patrol_ai.sqf";
patrol_ai_uavs = compileFinal preprocessFileLineNumbers "scripts\server\ai\patrol_ai_uavs.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";

// Battlegroup
spawn_air = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_air.sqf";
send_drones = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_drones.sqf";
send_paratroopers = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_paratroopers.sqf";
spawn_halo_vehicle = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_halo_vehicle.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";
spawn_battlegroup_direct = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup_direct.sqf";
manage_one_enemy_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_enemy_patrol.sqf";

// Game
[] call compileFinal preprocessFileLineNumbers "scripts\server\game\save_game_mp_init.sqf";
load_game_mp = compileFinal preprocessFileLineNumbers "scripts\server\game\load_game_mp.sqf";
save_game_mp = compileFinal preprocessFileLineNumbers "scripts\server\game\save_game_mp.sqf";
load_player_context = compileFinal preprocessFileLineNumbers "scripts\server\game\load_player_context.sqf";
load_squad_context = compileFinal preprocessFileLineNumbers "scripts\server\game\load_squad_context.sqf";
save_context = compileFinal preprocessFileLineNumbers "scripts\server\game\save_context.sqf";
blufor_victory = compileFinal preprocessFileLineNumbers "scripts\server\game\blufor_victory.sqf";

// Bases
fob_init = compileFinal preprocessFileLineNumbers "scripts\server\base\fob_init.sqf";
fob_init_data = compileFinal preprocessFileLineNumbers "scripts\server\base\fob_init_data.sqf";
fob_init_officer = compileFinal preprocessFileLineNumbers "scripts\server\base\fob_init_officer.sqf";

// Secondary objectives
fob_hunting = compileFinal preprocessFileLineNumbers "scripts\server\secondary\fob_hunting.sqf";
convoy_hijack = compileFinal preprocessFileLineNumbers "scripts\server\secondary\convoy_hijack.sqf";
search_and_rescue = compileFinal preprocessFileLineNumbers "scripts\server\secondary\search_and_rescue.sqf";
final_situaton = compileFinal preprocessFileLineNumbers "scripts\server\secondary\final_situaton.sqf";

// Sector
attack_in_progress_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_fob.sqf";
attack_in_progress_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_sector.sqf";
destroy_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\destroy_fob.sqf";
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
ied_trap_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_trap_manager.sqf";
spawn_static = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_static.sqf";
manage_ammoboxes = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_ammoboxes.sqf";
manage_intels = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_intels.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
spawn_defenders = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_defenders.sqf";
spawn_prisonners = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_prisonners.sqf";
start_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\start_sector.sqf";

// Ressources
count_box = compileFinal preprocessFileLineNumbers "scripts\server\resources\count_box.sqf";
spawn_box = compileFinal preprocessFileLineNumbers "scripts\server\resources\spawn_box.sqf";

// Various
boxSetup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_boxSetup.sqf";
createlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createLandMines.sqf";
showlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_showLandMines.sqf";
clearlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_clearLandMines.sqf";
createCustomGroup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createCustomGroup.sqf";

// Warehouse
warehouse_update = compileFinal preprocessFileLineNumbers "scripts\server\game\warehouse_update.sqf";

// Remote Call - Server Side
mobile_respawn_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\mobile_respawn_remote_call.sqf";
addel_group_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\addel_group_remote_call.sqf";
ammo_add_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\ammo_add_remote_call.sqf";
ammo_del_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\ammo_del_remote_call.sqf";
build_cutter_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_cutter_remote_call.sqf";
build_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_fob_remote_call.sqf";
build_vehicle_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_vehicle_remote_call.sqf";
call_artillery_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\call_artillery_remote_call.sqf";
destroy_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\destroy_fob_remote_call.sqf";
destroy_static_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\destroy_static_remote_call.sqf";
dog_action_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\dog_action_remote_call.sqf";
ied_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\ied_remote_call.sqf";
intel_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\intel_remote_call.sqf";
load_player_context_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_player_context_remote_call.sqf";
load_squad_context_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_squad_context_remote_call.sqf";
load_truck_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_truck_remote_call.sqf";
load_cargo_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_cargo_remote_call.sqf";
prisoner_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\prisoner_remote_call.sqf";
bomber_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\bomber_remote_call.sqf";
sector_defenses_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sector_defenses_remote_call.sqf";
sector_liberated_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sector_liberated_remote_call.sqf";
send_aircraft_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\send_aircraft_remote_call.sqf";
sendammo_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sendammo_remote_call.sqf";
sog_tunnel_enter_remotecall = compileFinal preprocessFileLineNumbers "scripts\server\sog\sog_tunnel_enter_remotecall.sqf";
sound_range_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sound_range_remote_call.sqf";
speak_manager_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\speak_manager_remote_call.sqf";
start_secondary_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\start_secondary_remote_call.sqf";
unload_truck_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\unload_truck_remote_call.sqf";
upgrade_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\upgrade_fob_remote_call.sqf";
vehicle_lock_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vehicle_lock_remote_call.sqf";
vehicle_unflip_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vehicle_unflip_remote_call.sqf";
warehouse_init_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\warehouse_init_remote_call.sqf";
warehouse_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\warehouse_remote_call.sqf";
activate_sector_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\activate_sector_remote_call.sqf";
vote_sector_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vote_sector_remote_call.sqf";

// A3W Side Mission - Server Side
a3w_follow_player = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\a3w_follow_player.sqf";

// PAR Remote Call - Server Side
PAR_remote_bounty = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_bounty.sqf";
PAR_remote_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_sortie.sqf";

if (!([] call F_getValid)) exitWith {};

[] call load_game_mp;
if (abort_loading) exitWith {
	GRLIB_init_server = false;
	publicVariable "GRLIB_init_server";
	publicVariable "abort_loading";
	publicVariable "abort_loading_msg";
};

[] execVM "scripts\server\game\synchronise_vars.sqf";
[] execVM "scripts\server\game\apply_saved_scores.sqf";
[] execVM "scripts\server\base\fobbox_manager.sqf";
[] execVM "scripts\server\base\huron_manager.sqf";
[] execVM "scripts\server\game\spawn_radio_towers.sqf";
[] execVM "scripts\server\game\hall_of_fame.sqf";
[] execVM "scripts\server\battlegroup\counter_battlegroup.sqf";
[] execVM "scripts\server\battlegroup\random_battlegroups.sqf";
[] execVM "scripts\server\battlegroup\readiness_decrease.sqf";
[] execVM "scripts\server\resources\manage_resources.sqf";
[] execVM "scripts\server\patrols\civilian_patrols.sqf";
[] execVM "scripts\server\patrols\enemy_patrols.sqf";
[] execVM "scripts\server\sector\lose_sectors.sqf";
[] execVM "scripts\server\game\manage_score.sqf";
[] execVM "scripts\server\game\manage_time.sqf";
[] execVM "scripts\server\game\manage_weather.sqf";
[] execVM "scripts\server\game\init_marker.sqf";
[] execVM "scripts\server\game\manage_undercover.sqf";
[] execVM "scripts\server\base\fob_markers.sqf";
[] execVM "scripts\server\secondary\autostart.sqf";
[] execVM "scripts\server\game\zeus_synchro.sqf";
[] execVM "scripts\server\game\clean.sqf";
[] execVM "scripts\server\game\periodic_save.sqf";
[] execVM "scripts\server\a3w\init_missions.sqf";
[] execVM "scripts\server\offloading\show_fps.sqf";
[] execVM "scripts\server\wildlife\manage_wildlife.sqf";
[] execVM "scripts\server\sector\static_manager.sqf";
[] execVM "scripts\server\sector\sector_markers_manager.sqf";

// Offloading
[] execVM "scripts\server\offloading\offload_calculation.sqf";
[] execVM "scripts\server\offloading\offload_manager.sqf";

// Manage sectors
GRLIB_sector_spawning = false;
publicVariable "GRLIB_sector_spawning";
if (GRLIB_Commander_mode) then {
	// Commander functions
	manage_sectors_commander = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_sectors_commander.sqf";
	commander_voteHandler = compileFinal preprocessFileLineNumbers "scripts\server\sector\commander_sector_vote.sqf";
	// Commander mode
	GRLIB_connectMarkers = createHashMap;
	GRLIB_Sector_Votes = createHashMap;
	[] spawn manage_sectors_commander;
	[] spawn commander_voteHandler;
} else {
	// Classic mode
	[] execVM "scripts\server\sector\manage_sectors.sqf";
};

global_locked_group = [];
publicVariable "global_locked_group";

sleep 2;
GRLIB_init_server = true;
publicVariable "GRLIB_init_server";
diag_log "--- Server Init stop ---";
