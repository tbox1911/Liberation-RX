[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";

add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_defense_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_defense_waypoints.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
patrol_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\patrol_ai.sqf";
prisonner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_ai.sqf";
bomber_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\bomber_ai.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";
showlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_showLandMines.sqf";

ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
manage_one_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_patrol.sqf";
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";
manage_one_wildlife = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_wildlife.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";

[] execVM "scripts\client\misc\synchronise_vars.sqf";
[] execVM "scripts\server\offloading\show_fps.sqf";