kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\kill_manager.sqf";
clean_vehicle = compileFinal preprocessFileLineNumbers "scripts\shared\clean_vehicle.sqf";
protect_static = compileFinal preprocessFileLineNumbers "scripts\shared\protect_static.sqf";
damage_manager_EH = compileFinal preprocessFileLineNumbers "scripts\shared\damage_manager.sqf";
prisonner_captured = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_captured.sqf";

// Remote Call
// Server Side
build_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_fob_remote_call.sqf";
destroy_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\destroy_fob_remote_call.sqf";
sector_liberated_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sector_liberated_remote_call.sqf";
intel_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\intel_remote_call.sqf";
start_secondary_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\start_secondary_remote_call.sqf";
airdrop_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\airdrop_remote_call.sqf";
send_para_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\send_para_remote_call.sqf";
send_aircraft_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\send_aircraft_remote_call.sqf";
addel_group_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\addel_group_remote_call.sqf";
addel_beacon_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\addel_beacon_remote_call.sqf";
sendammo_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sendammo_remote_call.sqf";
dog_action_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\dog_action_remote_call.sqf";
vehicle_garage_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\vehicle_garage_remote_call.sqf";
a3w_create_enemy = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\a3w_create_enemy.sqf";
unload_truck_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\unload_truck_remote_call.sqf";
recover_ai_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\recover_ai_remote_call.sqf";

// Client Side
remote_call_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_penalty.sqf";
remote_call_sector = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_sector.sqf";
remote_call_fob = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fob.sqf";
remote_call_battlegroup = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_battlegroup.sqf";
remote_call_endgame = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_endgame.sqf";
remote_call_ammo_bounty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_ammo_bounty.sqf";
remote_call_civ_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_civ_penalty.sqf";
remote_call_intel = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_intel.sqf";
remote_call_incoming = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_incoming.sqf";
remote_call_showinfo = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_showinfo.sqf";
remote_call_a3w_info = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_a3w_info.sqf";

// Vehicle Color
[] execVM "addons\RPT\RPT_init.sqf";
RPT_fnc_TextureVehicle = compileFinal preprocessFileLineNumbers "addons\RPT\fn_textureVehicle.sqf";

[] execVM "scripts\shared\scan_skill.sqf";
