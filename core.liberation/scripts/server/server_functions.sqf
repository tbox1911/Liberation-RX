// Init LRX vehicle paints
[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init_static.sqf";

// Init Chimera unit look
[] call compileFinal preprocessFileLineNumbers "scripts\server\game\chimera_units_overide.sqf";

// Cleanup
kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\events\kill_manager.sqf";
cleanup_uid = compileFinal preprocessFileLineNumbers "scripts\server\game\cleanup_uid.sqf";
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
spawn_prisoners = compileFinal preprocessFileLineNumbers "scripts\server\sector\spawn_prisoners.sqf";
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
warehouse_init = compileFinal preprocessFileLineNumbers "scripts\server\game\warehouse_init.sqf";
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
warehouse_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\warehouse_remote_call.sqf";
activate_sector_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\activate_sector_remote_call.sqf";
vote_sector_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vote_sector_remote_call.sqf";

// A3W Side Mission - Server Side
a3w_follow_player = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\a3w_follow_player.sqf";

// PAR Remote Call - Server Side
PAR_remote_bounty = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_bounty.sqf";
PAR_remote_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_sortie.sqf";
