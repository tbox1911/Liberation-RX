diag_log "--- Server Init start ---";
//[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";
[] execVM "scripts\loadouts\init_loadouts.sqf";

// AI
GRLIB_AI_toggle = true;
add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_defense_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_defense_waypoints.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
csat_abandon_vehicle = compileFinal preprocessFileLineNumbers "scripts\server\ai\csat_abandon_vehicle.sqf";
patrol_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\patrol_ai.sqf";
prisonner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_ai.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";

// Battlegroup
spawn_air = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_air.sqf";
spawn_airblu = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_airblu.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";

// Game
check_victory_conditions = compileFinal preprocessFileLineNumbers "scripts\server\game\check_victory_conditions.sqf";

// Patrol
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";
manage_one_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_patrol.sqf";
reinforcements_manager = compileFinal preprocessFileLineNumbers "scripts\server\patrols\reinforcements_manager.sqf";
send_paratroopers = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_paratroopers.sqf";

// Resources
recalculate_caps = compileFinal preprocessFileLineNumbers "scripts\server\resources\recalculate_caps.sqf";

// Secondary objectives
fob_hunting = compileFinal preprocessFileLineNumbers "scripts\server\secondary\fob_hunting.sqf";
convoy_hijack = compileFinal preprocessFileLineNumbers "scripts\server\secondary\convoy_hijack.sqf";
search_and_rescue = compileFinal preprocessFileLineNumbers "scripts\server\secondary\search_and_rescue.sqf";

// Sector
attack_in_progress_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_fob.sqf";
attack_in_progress_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_sector.sqf";
destroy_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\destroy_fob.sqf";
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
boxSetup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_boxSetup.sqf";
manage_ammoboxes = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_ammoboxes.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
wait_to_spawn_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\wait_to_spawn_sector.sqf";

[] execVM "scripts\server\battlegroup\counter_battlegroup.sqf";
[] execVM "scripts\server\battlegroup\random_battlegroups.sqf";
[] execVM "scripts\server\battlegroup\readiness_increase.sqf";
[] execVM "scripts\server\patrols\civilian_patrols.sqf";
[] execVM "scripts\server\patrols\manage_patrols.sqf";
[] execVM "scripts\server\patrols\reinforcements_resetter.sqf";
[] execVM "scripts\server\sector\lose_sectors.sqf";
[] execVM "scripts\server\sector\manage_sectors.sqf";
[] execVM "scripts\server\resources\manage_resources.sqf";
[] execVM "scripts\server\resources\recalculate_resources.sqf";
[] execVM "scripts\server\resources\recalculate_timer.sqf";
[] execVM "scripts\server\resources\unit_cap.sqf";
[] execVM "scripts\server\game\apply_default_permissions.sqf";
[] execVM "scripts\server\game\apply_saved_scores.sqf";
[] execVM "scripts\server\game\capture_vehicles.sqf";
//[] execVM "scripts\server\game\clean.sqf";
//[] execVM "scripts\server\game\cleanup_vehicles.sqf";
[] execVM "scripts\server\game\fucking_set_fog.sqf";
[] execVM "scripts\server\game\manage_time.sqf";
[] execVM "scripts\server\game\manage_weather.sqf";
[] execVM "scripts\server\game\playtime.sqf";
[] execVM "scripts\server\game\spawn_radio_towers.sqf";
[] execVM "scripts\server\game\synchronise_vars.sqf";
[] execVM "scripts\server\game\zeus_synchro.sqf";
[] execVM "scripts\server\game\manage_score.sqf";
[] execVM "scripts\server\game\hall_of_fame.sqf";
[] execVM "scripts\server\game\periodic_save.sqf";
[] execVM "scripts\server\game\save_manager.sqf";
[] execVM "scripts\server\base\fobbox_manager.sqf";
[] execVM "scripts\server\base\huron_manager.sqf";
[] execVM "scripts\server\secondary\autostart.sqf";
[] execVM "scripts\server\a3w\init_missions.sqf";
[] execVM "scripts\server\offloading\offload_calculation.sqf";
[] execVM "scripts\server\offloading\offload_manager.sqf";
[] execVM "scripts\server\offloading\show_fps.sqf";

{
	if ( (_x != player) && (_x distance (getmarkerpos GRLIB_respawn_marker) < 200 ) ) then {deleteVehicle _x};
} foreach allUnits;

if (isNil "BTC_tk_PVEH") then { BTC_tk_PVEH = [] };
publicVariable "BTC_tk_PVEH";

if (isNil "global_locked_group") then { global_locked_group = [] };
publicVariable "global_locked_group";

addMissionEventHandler ['HandleDisconnect',{deleteVehicle (_this select 0);}];
onPlayerDisconnected { [_uid] call compile preprocessfilelinenumbers "scripts\server\game\cleanup_player.sqf" };

diag_log "--- Server Init stop ---";