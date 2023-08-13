[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";

add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_defense_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_defense_waypoints.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
prisonner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_ai.sqf";
prisonner_captured = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_captured.sqf";
bomber_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\bomber_ai.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";
reinforcements_manager = compileFinal preprocessFileLineNumbers "scripts\server\patrols\reinforcements_manager.sqf";
send_paratroopers = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_paratroopers.sqf";
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
ied_trap_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_trap_manager.sqf";
static_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\static_manager.sqf";
patrol_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\patrol_manager.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";
spawn_battlegroup_direct = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup_direct.sqf";
spawn_air = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_air.sqf";
boxSetup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_boxSetup.sqf";
createlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createLandMines.sqf";
showlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_showLandMines.sqf";
clearlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_clearLandMines.sqf";

[] execVM "scripts\server\offloading\show_fps.sqf";