diag_log "--- HC Server Init start ---";
[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";

// Cleanup
kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\kill_manager.sqf";
cleanup_player = compileFinal preprocessFileLineNumbers "scripts\server\game\cleanup_player.sqf";

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

// Sector
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
ied_trap_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_trap_manager.sqf";
spawn_static = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_static.sqf";
manage_ammoboxes = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_ammoboxes.sqf";
manage_intels = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_intels.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
spawn_defenders = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_defenders.sqf";

//Various
boxSetup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_boxSetup.sqf";
createlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createLandMines.sqf";
showlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_showLandMines.sqf";
clearlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_clearLandMines.sqf";
cleanMissionVehicles = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_cleanMissionVehicles.sqf";
createCustomGroup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createCustomGroup.sqf";

[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\show_fps_hc.sqf";

diag_log "--- HC Server Init stop ---";