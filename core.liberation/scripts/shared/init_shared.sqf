kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\kill_manager.sqf";
clean_vehicle = compileFinal preprocessFileLineNumbers "scripts\shared\clean_vehicle.sqf";
damage_manager_friendly = compileFinal preprocessFileLineNumbers "scripts\shared\damage_manager_friendly.sqf";
damage_manager_enemy = compileFinal preprocessFileLineNumbers "scripts\shared\damage_manager_enemy.sqf";
damage_manager_static = compileFinal preprocessFileLineNumbers "scripts\shared\damage_manager_static.sqf";

// Remote Call
// Server Side
build_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_fob_remote_call.sqf";
build_cutter_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_cutter_remote_call.sqf";
warehouse_init_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\warehouse_init_remote_call.sqf";
warehouse_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\warehouse_remote_call.sqf";
destroy_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\destroy_fob_remote_call.sqf";
upgrade_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\upgrade_fob_remote_call.sqf";
sector_liberated_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sector_liberated_remote_call.sqf";
intel_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\intel_remote_call.sqf";
start_secondary_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\start_secondary_remote_call.sqf";
airdrop_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\airdrop_remote_call.sqf";
send_para_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\send_para_remote_call.sqf";
send_aircraft_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\send_aircraft_remote_call.sqf";
call_artillery_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\call_artillery_remote_call.sqf";
addel_group_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\addel_group_remote_call.sqf";
addel_beacon_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\addel_beacon_remote_call.sqf";
sendammo_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sendammo_remote_call.sqf";
dog_action_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\dog_action_remote_call.sqf";
vehicle_garage_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vehicle_garage_remote_call.sqf";
vehicle_lock_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vehicle_lock_remote_call.sqf";
a3w_create_enemy = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\a3w_create_enemy.sqf";
load_truck_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_truck_remote_call.sqf";
unload_truck_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\unload_truck_remote_call.sqf";
load_context_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\load_context_remote_call.sqf";
ammo_add_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\ammo_add_remote_call.sqf";
ammo_del_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\ammo_del_remote_call.sqf";
eject_crew_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\eject_crew_remote_call.sqf";
sog_tunnel_enter_remotecall = compileFinal preprocessFileLineNumbers "scripts\server\sog\sog_tunnel_enter_remotecall.sqf";

// Client Side
remote_call_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_penalty.sqf";
remote_call_sector = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_sector.sqf";
remote_call_fob = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fob.sqf";
remote_call_battlegroup = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_battlegroup.sqf";
remote_call_endgame = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_endgame.sqf";
remote_call_final_fight = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_final_fight.sqf";
remote_call_ammo_bounty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_ammo_bounty.sqf";
remote_call_civ_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_civ_penalty.sqf";
remote_call_intel = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_intel.sqf";
remote_call_incoming = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_incoming.sqf";
remote_call_showinfo = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_showinfo.sqf";
remote_call_a3w_info = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_a3w_info.sqf";
remote_call_tunnel_success = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_tunnel_success.sqf";
remote_call_fireworks = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fireworks.sqf";

// Vehicle Color
[] execVM "addons\VAM\RPT_init.sqf";
RPT_fnc_TextureVehicle = compileFinal preprocessFileLineNumbers "addons\VAM\fn_textureVehicle.sqf";
RPT_fnc_CompoVehicle = compileFinal preprocessFileLineNumbers "addons\VAM\fn_compVehicle.sqf";
fnc_VAM_common_camo = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_camo.sqf";
fnc_VAM_common_comp = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_comp.sqf";
