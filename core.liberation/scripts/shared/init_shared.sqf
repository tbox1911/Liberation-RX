// Static manager
manage_one_static = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_static.sqf";

// Attach objects
attach_object_direct = compileFinal preprocessFileLineNumbers "scripts\shared\attach_object_direct.sqf";

// Event Handlers
damage_manager_civilian = compileFinal preprocessFileLineNumbers "scripts\shared\events\damage_manager_civilian.sqf";
damage_manager_friendly = compileFinal preprocessFileLineNumbers "scripts\shared\events\damage_manager_friendly.sqf";
damage_manager_enemy = compileFinal preprocessFileLineNumbers "scripts\shared\events\damage_manager_enemy.sqf";
damage_manager_static = compileFinal preprocessFileLineNumbers "scripts\shared\events\damage_manager_static.sqf";

// TK Manager
LRX_tk_server_actions = compileFinal preprocessFileLineNumbers "addons\TKP\tk_server_actions.sqf";

// PAR functions
PAR_is_wounded = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_is_wounded.sqf";

// Remote Call - Client Side
remote_call_a3w_info = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_a3w_info.sqf";
remote_call_ammo_bounty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_ammo_bounty.sqf";
remote_call_battlegroup = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_battlegroup.sqf";
remote_call_civ_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_civ_penalty.sqf";
remote_call_endgame = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_endgame.sqf";
remote_call_final_fight = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_final_fight.sqf";
remote_call_fireworks = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fireworks.sqf";
remote_call_fob = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fob.sqf";
remote_call_incoming = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_incoming.sqf";
remote_call_intel = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_intel.sqf";
remote_call_load_context = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_load_context.sqf";
remote_call_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_penalty.sqf";
remote_call_prisoner = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_prisoner.sqf";
remote_call_sector = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_sector.sqf";
remote_call_showinfo = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_showinfo.sqf";
remote_call_showtext = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_showtext.sqf";
remote_call_tunnel_success = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_tunnel_success.sqf";

// Vehicle Color
RPT_fnc_ResetVehicle = compileFinal preprocessFileLineNumbers "addons\VAM\fn_resetVehicle.sqf";
RPT_fnc_CompoVehicle = compileFinal preprocessFileLineNumbers "addons\VAM\fn_compVehicle.sqf";
RPT_fnc_TextureVehicle = compileFinal preprocessFileLineNumbers "addons\VAM\fn_textureVehicle.sqf";
fnc_VAM_common_camo = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_camo.sqf";
fnc_VAM_common_comp = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_comp.sqf";
