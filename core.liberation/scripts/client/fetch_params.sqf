//--- LRX Client Misson Parameters ----------------------------------------
diag_log "--- LRX: Loading client settings ---";

// Edit Mission settings
call compileFinal preprocessFileLineNumbers "scripts\client\ui\settings_menu.sqf";

// Mission Parameter constant
if (!isServer) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\shared\mission_params.sqf";
};

waitUntil { sleep 1; !isNil "GRLIB_LRX_params" };
if (!GRLIB_ParamsInitialized) then {
	[] execVM "scripts\client\commander\open_params.sqf";
	waitUntil { sleep 1; GRLIB_ParamsInitialized };
};

// LRX Selectable
if (!isServer) then { [] call F_readParamsLRX };

GREUH_allow_mapmarkers = [GRLIB_PARAM_MapMarkers] call lrx_getParamValue;
GREUH_allow_nametags = [GRLIB_PARAM_NameTags] call lrx_getParamValue;
GREUH_allow_platoonview = [GRLIB_PARAM_PlatoonView] call lrx_getParamValue;
GRLIB_admin_menu = [GRLIB_PARAM_AdminMenu] call lrx_getParamValue;
GRLIB_air_support = [GRLIB_PARAM_AirSupport] call lrx_getParamValue;
GRLIB_artillery_maxshot = [GRLIB_PARAM_ArtyMaxShot] call lrx_getParamValue;
GRLIB_deployment_cinematic = [GRLIB_PARAM_DeploymentCinematic] call lrx_getParamValue;
GRLIB_disable_death_chat = [GRLIB_PARAM_DeathChat] call lrx_getParamValue;
GRLIB_fatigue = [GRLIB_PARAM_Fatigue] call lrx_getParamValue;
GRLIB_forced_loadout = [GRLIB_PARAM_ForcedLoadout] call lrx_getParamValue;
GRLIB_garage_size = [GRLIB_PARAM_MaxGarageSize] call lrx_getParamValue;
GRLIB_introduction = [GRLIB_PARAM_introductionKey] call lrx_getParamValue;
GRLIB_kick_idle = [GRLIB_PARAM_KickIdle] call lrx_getParamValue;
GRLIB_max_fobs = [GRLIB_PARAM_MaxFobs] call lrx_getParamValue;
GRLIB_max_outpost = [GRLIB_PARAM_MaxOutpost] call lrx_getParamValue;
GRLIB_permissions_param = [GRLIB_PARAM_Permissions] call lrx_getParamValue;
GRLIB_respawn_cooldown = [GRLIB_PARAM_RespawnCD] call lrx_getParamValue;
GRLIB_show_blufor = [GRLIB_PARAM_ShowBlufor] call lrx_getParamValue;
GRLIB_thermic = [GRLIB_PARAM_Thermic] call lrx_getParamValue;
GRLIB_tk_count = [GRLIB_PARAM_TK_count] call lrx_getParamValue;
GRLIB_tk_mode = [GRLIB_PARAM_TK_mode] call lrx_getParamValue;
GRLIB_vehicle_defense = [GRLIB_PARAM_VehicleDefense] call lrx_getParamValue;
GRLIB_vehicles_fuel = [GRLIB_PARAM_FuelConso] call lrx_getParamValue;

// PAR Revive
PAR_revive = ["PAR_Revive"] call lrx_getParamValue;
PAR_ai_revive_max = ["PAR_AI_Revive"] call lrx_getParamValue;
PAR_bleedout = ["PAR_BleedOut"] call lrx_getParamValue;
PAR_respawn_btn = ["PAR_Respawn"] call lrx_getParamValue;

PAR_grave = ["PAR_Grave"] call lrx_getParamValue;
// Disable PAR/Fatigue if ACE Medical is present
if (GRLIB_ACE_medical_enabled) then { PAR_revive = 0; PAR_grave = 0; GRLIB_fatigue = 1 };

// Transfom true/false Param
GRLIB_introduction = (GRLIB_introduction == 1);
GRLIB_deployment_cinematic = (GRLIB_deployment_cinematic == 1);
GRLIB_vehicle_defense = (GRLIB_vehicle_defense == 1);
GRLIB_disable_death_chat = (GRLIB_disable_death_chat == 1);
GRLIB_fatigue = (GRLIB_fatigue == 1);
GRLIB_permissions_param = (GRLIB_permissions_param == 1);
GRLIB_air_support = (GRLIB_air_support == 1);
GRLIB_admin_menu = (GRLIB_admin_menu == 1);

waitUntil { sleep 1; !isNil "GRLIB_LRX_server_params_loaded" };

diag_log "--- LRX: Client settings loaded ---";