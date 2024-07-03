//--- LRX Fetch Misson Parameters ----------------------------------------

// Map constant
GRLIB_map_modder = "Unknow";
GRLIB_west_modder = "Unknow";
GRLIB_east_modder = "Unknow";
[] call compileFinal preprocessFileLineNumbers "gameplay_constants.sqf";
GRLIB_params_save_key = format ["%1-config", GRLIB_save_key];

// Detect Addons
GRLIB_3CB_enabled = isClass(configFile >> "CfgMods" >> "UK3CB_BAF_Weapons"); // Returns true if UK3 CB is enabled
GRLIB_ACE_enabled = isClass(configFile >> "cfgPatches" >> "ace_main"); // Returns true if ACE is enabled
GRLIB_ACE_medical_enabled = isClass(configFile >> "cfgPatches" >> "ace_medical"); // Returns true if ACE Medical is enabled
GRLIB_ACRE_enabled = isClass(configFile >> "cfgPatches" >> "acre_main"); // Returns true if ACRE is enabled
GRLIB_AMF_enabled = isClass(configFile >> "cfgPatches" >> "AMF_weapon_F"); // Returns true if GlobMob is enabled
GRLIB_CUPU_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Creatures_Extra"); // Returns true if CUP Units is enabled
GRLIB_CUPV_enabled = isClass(configFile >> "CfgPatches" >> "CUP_AirVehciles_AH1Z"); // Returns true if CUP Vehicles is enabled
GRLIB_CUP_enabled = (GRLIB_CUPU_enabled || GRLIB_CUPV_enabled); // Returns true if CUP is enabled
GRLIB_CUPW_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Weapons_AK"); // Returns true if CUP Weapons is enabled
GRLIB_CWR_enabled = isClass(configFile >> "CfgMods" >> "cwr3_dlc"); // Returns true if CWR3 is enabled
GRLIB_EJW_enabled = isClass(configFile >> "CfgPatches" >> "Ej_u100"); // Returns true if EricJ Weapons is enabled
GRLIB_GM_enabled = isClass(configFile >> "cfgPatches" >> "gm_Core"); // Returns true if GlobMob is enabled
GRLIB_IFA_enabled = isClass(configFile >> "CfgPatches" >> "LIB_core"); // Returns true if IFA3 is enabled
GRLIB_LOP_enabled = isClass(configFile >> "CfgPatches" >> "lop_main"); // Returns true if LOP is enabled
GRLIB_LRX_Music_enabled = isClass(configFile >> "cfgPatches" >> "LRX_Music"); // Returns true if LRX Music Pack is enabled
GRLIB_LRX_Template_enabled = isClass(configFile >> "cfgPatches" >> "LRX_Template"); // Returns true if LRX Template Pack is enabled
GRLIB_LRX_Texture_enabled = isClass(configFile >> "cfgPatches" >> "LRX_Texture"); // Returns true if LRX Textture Pack is enabled
GRLIB_MFR_enabled = isClass(configfile >> "CfgPatches" >> "MFR_Dogs"); // Returns true if MFR Dogs is enabled
GRLIB_OPTRE_enabled = isClass(configFile >> "cfgPatches" >> "OPTRE_Core"); // Returns true if OPTRE is enabled
GRLIB_R3F_enabled = isClass(configFile >> "CfgPatches" >> "r3f_armes"); // Returns true if R3F is enabled
GRLIB_RHSAF_enabled = isClass(configFile >> "CfgMods" >> "RHS_AFRF"); // Returns true if RHS AF is enabled
GRLIB_RHSUS_enabled = isClass(configFile >> "CfgMods" >> "RHS_USAF"); // Returns true if RHS US is enabled
GRLIB_RHS_enabled = (GRLIB_RHSUS_enabled || GRLIB_RHSAF_enabled);  // Returns true if RHS is enabled
GRLIB_SOG_enabled = isClass(configFile >> "CfgPatches" >> "vn_misc"); // Returns true if SOG is enabled
GRLIB_TFR_enabled = isClass(configfile >> "CfgPatches" >> "task_force_radio"); // Returns true if TFAR is enabled
GRLIB_UNS_enabled = isClass(configFile >> "CfgPatches" >> "uns_main"); // Returns true if Unsung is enabled
GRLIB_WS_enabled = isClass(configFile >> "CfgPatches" >> "data_f_lxWS"); // Returns true if WS is enabled
GRLIB_ASZ_enabled = isClass(configFile >> "CfgPatches" >> "mas_itl_lite_weapons"); // Returns true if Italian ASZ is enabled

// Classename MOD source
[] call compileFinal preprocessFileLineNumbers "mod_template\mod_init.sqf";
LRX_mod_list_west = [];
LRX_mod_list_east = [];
LRX_mod_list_name = [];
if (GRLIB_LRX_Template_enabled) then {
	_version = getNumber (configFile >> "cfgPatches" >> "LRX_Template" >> "version");
	if (_version >= 2 ) then {
		[] call LRX_Template_fnc_loading;
		GRLIB_mod_list_west append LRX_mod_list_west;
		GRLIB_mod_list_east append LRX_mod_list_east;
		GRLIB_mod_list_name append LRX_mod_list_name;
	} else { abort_loading = true };
};
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid LRX MOD Template version !\n\n
	This version of LRX_Template is incompatible with this Mission.\n
	Please update your version of LRX_Template Mod at:\n
	see: https://steamcommunity.com/sharedfiles/filedetails/?id=3014195090\n\n
	Loading Aborted to protect data integrity.\n
	Upgrade your LRX Mod Template.\n
	*********************************"];
};

// Mission Parameter constant
[] call compileFinal preprocessFileLineNumbers "mission_params.sqf";

// Parameters from Lobby
GRLIB_use_whitelist = ["Whitelist",1] call bis_fnc_getParamValue;
GRLIB_use_exclusive = ["Exclusive",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_1 = ["WipeSave1",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_2 = ["WipeSave2",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_params = ["WipeSave3",0] call bis_fnc_getParamValue;
GRLIB_force_load = ["ForceLoading",0] call bis_fnc_getParamValue;
GRLIB_log_settings = ["LogSettings",0] call bis_fnc_getParamValue;

if (GRLIB_param_wipe_params == 1 && isServer) then {
	profileNamespace setVariable [GRLIB_params_save_key, LRX_Mission_Params];
};

if (GRLIB_param_wipe_params == 1 && !isDedicated && hasInterface) then {
	profileNamespace setVariable ["GREUH_OPTIONS_PROFILE", nil];
};

// Load Mission Parameters
if (isServer) then {
	GRLIB_LRX_params = profileNamespace getVariable [GRLIB_params_save_key, nil];
	if ( isNil "GRLIB_LRX_params" ) then {
		GRLIB_LRX_params = LRX_Mission_Params;
		profileNamespace setVariable [GRLIB_params_save_key, GRLIB_LRX_params];
	};
	publicVariable "GRLIB_LRX_params";
	if (GRLIB_log_settings > 0) then {
		diag_log "--- LRX Mission Settings: ";
		{
			_name = _x select 0;
			_data = [_name] call lrx_getParamData;
			_value_text = "Error!";
			if (count _data > 0) then {
				_name = _data select 0;
				_values_raw = _data select 2;
				if (isNil "_values_raw") then { _values_raw = [] };
				if (count (_values_raw) > 0) then {
					_value_text = (_data select 1) select (_values_raw find (_x select 1));
				} else {
					_value_text = (_data select 1) select (_x select 1);
				};
			};
			diag_log format ["   %1: %2", _name, _value_text ];
		} foreach GRLIB_LRX_params;
	};
} else {
	waitUntil { sleep 1; !isNil "GRLIB_LRX_params" };
};

// Open Mission Parameters
if (isNil "GRLIB_param_open_params") then {
	GRLIB_param_open_params = ["OpenParams",0] call bis_fnc_getParamValue;
};

if (GRLIB_param_open_params == 1) then {
	if (!isDedicated && hasInterface) then {
		[] execVM "scripts\client\commander\open_params.sqf";
	};
	waitUntil { sleep 1; GRLIB_param_open_params == 0 };
};

// LRX Selectable
GRLIB_introduction = ["Introduction"] call lrx_getParamValue;
GRLIB_deployment_cinematic = ["DeploymentCinematic"] call lrx_getParamValue;
GREUH_allow_mapmarkers = ["MapMarkers"] call lrx_getParamValue;
GREUH_allow_platoonview = ["PlatoonView"] call lrx_getParamValue;
GREUH_allow_nametags = ["NameTags"] call lrx_getParamValue;
GRLIB_unitcap = ["Unitcap"] call lrx_getParamValue;
GRLIB_fancy_info = ["FancyInfo"] call lrx_getParamValue;
GRLIB_hide_opfor = ["HideOpfor"] call lrx_getParamValue;
GRLIB_show_blufor = ["ShowBlufor"] call lrx_getParamValue;
GRLIB_thermic = ["Thermic"] call lrx_getParamValue;
GRLIB_fob_type = [ "FobType"] call lrx_getParamValue;
GRLIB_huron_type = [ "HuronType"] call lrx_getParamValue;
GRLIB_naval_type = [ "NavalFobType"] call lrx_getParamValue;
GRLIB_max_fobs = [ "MaxFobs"] call lrx_getParamValue;
GRLIB_max_outpost = [ "MaxOutpost"] call lrx_getParamValue;
GRLIB_passive_income = ["PassiveIncome"] call lrx_getParamValue;
GRLIB_passive_delay = ["PassiveIncomeDelay"] call lrx_getParamValue;
GRLIB_passive_ammount = ["PassiveIncomeAmmount"] call lrx_getParamValue;
GRLIB_resources_multiplier = ["ResourcesMultiplier"] call lrx_getParamValue;
GRLIB_disable_death_chat = ["DeathChat"] call lrx_getParamValue;
GRLIB_mod_preset_west = ["ModPresetWest"] call lrx_getParamValue;
GRLIB_mod_preset_east = ["ModPresetEast"] call lrx_getParamValue;
GRLIB_mod_preset_civ = ["ModPresetCiv"] call lrx_getParamValue;
GRLIB_mod_preset_taxi = ["ModPresetTaxi"] call lrx_getParamValue;
GRLIB_enable_arsenal = ["EnableArsenal"] call lrx_getParamValue;
GRLIB_filter_arsenal = ["FilterArsenal"] call lrx_getParamValue;
GRLIB_forced_loadout = ["ForcedLoadout"] call lrx_getParamValue;
GRLIB_free_loadout = ["FreeLoadout"] call lrx_getParamValue;
GRLIB_opfor_english = ["EnglishOpfor"] call lrx_getParamValue;
GRLIB_difficulty_modifier = ["Difficulty"] call lrx_getParamValue;
GRLIB_csat_aggressivity = ["Aggressivity"] call lrx_getParamValue;
GRLIB_sector_radius = ["SectorRadius"] call lrx_getParamValue;
GRLIB_TFR_radius = ["TFRadioRange"] call lrx_getParamValue;
GRLIB_day_factor = ["DayDuration"] call lrx_getParamValue;
GRLIB_night_factor = ["NightDuration"] call lrx_getParamValue;
GRLIB_weather_param = ["Weather"] call lrx_getParamValue;
GRLIB_fatigue = ["Fatigue"] call lrx_getParamValue;
GRLIB_tk_mode = ["TK_mode"] call lrx_getParamValue;
GRLIB_tk_count = ["TK_count"] call lrx_getParamValue;
GRLIB_garage_size = ["MaxGarageSize"] call lrx_getParamValue;
GRLIB_squad_size = ["SquadSize"] call lrx_getParamValue;
GRLIB_max_squad_size = ["MaxSquadSize"] call lrx_getParamValue;
GRLIB_max_spawn_point = ["MaxSpawnPoint"] call lrx_getParamValue;
GRLIB_allow_redeploy = ["Redeploy"] call lrx_getParamValue;
GRLIB_permissions_param = ["Permissions"] call lrx_getParamValue;
GRLIB_permission_vehicles = ["EnableLock"] call lrx_getParamValue;
GRLIB_permission_enemy = ["EnemyLock"] call lrx_getParamValue;
GRLIB_civilian_activity = ["Civilians"] call lrx_getParamValue;
GRLIB_patrols_activity = ["Patrols"] call lrx_getParamValue;
GRLIB_wildlife_manager = ["Wildlife"] call lrx_getParamValue;
GRLIB_civ_penalties = ["CivPenalties"] call lrx_getParamValue;
GRLIB_civ_penalties_ammount = ["CivPenaltiesAmmount"] call lrx_getParamValue;
GRLIB_halo_param = ["HaloJump"] call lrx_getParamValue;
GRLIB_admin_menu = ["AdminMenu"] call lrx_getParamValue;
GRLIB_cleanup_vehicles = ["CleanupVehicles"] call lrx_getParamValue;
GRLIB_autosave_timer = ["AutoSave"] call lrx_getParamValue;
GRLIB_param_wipe_keepscore = ["KeepScore"] call lrx_getParamValue;
GRLIB_respawn_timer = ["Respawn"] call lrx_getParamValue;
GRLIB_respawn_cooldown = ["RespawnCD"] call lrx_getParamValue;
GRLIB_kick_idle = ["KickIdle"] call lrx_getParamValue;
GRLIB_server_persistent = ["Persistent"] call lrx_getParamValue;
GRLIB_air_support = ["AirSupport"] call lrx_getParamValue;
GRLIB_despawn_tickets = ["SectorDespawn"] call lrx_getParamValue;
GRLIB_building_ai_ratio = ["BuildingRatio"] call lrx_getParamValue;
GRLIB_victory_condition = ["VictoryCondition"] call lrx_getParamValue;

// PAR Revive
PAR_revive = ["PAR_Revive"] call lrx_getParamValue;
PAR_ai_revive = ["PAR_AI_Revive"] call lrx_getParamValue;
PAR_bleedout = ["PAR_BleedOut"] call lrx_getParamValue;
PAR_grave = ["PAR_Grave"] call lrx_getParamValue;

// Hardcoded
GRLIB_endgame = 0;
if (isNil "GRLIB_global_stop") then { GRLIB_global_stop = 0 };
GRLIB_min_score_player = 20;				// Minimal player score to be saved
GRLIB_opfor_cap = 180 * GRLIB_unitcap;		// Maximal number of enemies units
GRLIB_blufor_cap = 50;						// Maximal number of friendly units
GRLIB_max_active_sectors = 4;				// Maximal active sectors at the same time
GRLIB_battlegroup_cap = GRLIB_battlegroup_cap * (sqrt GRLIB_unitcap) * (sqrt GRLIB_csat_aggressivity);
GRLIB_patrol_cap = GRLIB_patrol_cap * GRLIB_unitcap;
GRLIB_battlegroup_size = 4;
GRLIB_battlegroup_size = GRLIB_battlegroup_size * GRLIB_unitcap;
GRLIB_civilians_amount = 12;
GRLIB_civilians_amount = GRLIB_civilians_amount * GRLIB_civilian_activity;
GRLIB_patrol_amount = 7;
GRLIB_patrol_amount = GRLIB_patrol_amount * GRLIB_patrols_activity;
GRLIB_secondary_missions_costs = [100, 50, 10, 800];
GRLIB_defense_costs = [0, 100, 200, 300];

// Select MOD name
GRLIB_mod_west = "";
GRLIB_mod_east = "";
if (GRLIB_mod_preset_west <= count GRLIB_mod_list_west) then {
	GRLIB_mod_west = GRLIB_mod_list_west select GRLIB_mod_preset_west;
};
if (GRLIB_mod_preset_east <= count GRLIB_mod_list_east) then {
	GRLIB_mod_east = GRLIB_mod_list_east select GRLIB_mod_preset_east;
};
GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";

if ( GRLIB_mod_west == "" || GRLIB_mod_east == "") then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Missing MOD Template !\n\n
	Template for side West or East do not exist.\n
	you must add LRX_Template Mod to your setup.\n
	see: https://steamcommunity.com/sharedfiles/filedetails/?id=3014195090\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Mod Template selection.\n
	*********************************"];
};

diag_log format ["--- LRX Mod Detection: %1 vs %2", GRLIB_mod_west, GRLIB_mod_east];

// Check side Addon
private _startsWithMultipleInv = {
	params ["_item", "_list"];
	private _ret = false;
	{
		if ([_item, _x] call F_startsWith) exitWith { _ret = true };
	} foreach _list;
	_ret;
};

if ( !GRLIB_CUP_enabled && ["CP_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_EJW_enabled && ["EJW_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_R3F_enabled && ["R3F_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_RHSUS_enabled && ["RHS_USAF", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_RHSAF_enabled && ["RHS_AFRF", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_GM_enabled && ["GM_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_OPTRE_enabled && ["OPTRE", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_WS_enabled && ["WS_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_SOG_enabled && ["SOG_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_CWR_enabled && ["CWR3_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_3CB_enabled && ["3CB", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_UNS_enabled && ["UNS_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_IFA_enabled && ["IFA_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_AMF_enabled && ["AMF_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };
if ( !GRLIB_ASZ_enabled && ["ASZ_", [GRLIB_mod_west, GRLIB_mod_east]] call _startsWithMultipleInv) then { abort_loading = true };

if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid Side selection !\n\n
	Missing MOD Addons for side West (%1) or East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Side selection or add needed Addons.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};

// Overide Huron type
switch (GRLIB_huron_type) do {
	case 0: {huron_typename = "B_Heli_Transport_03_unarmed_F" };
	case 1: {huron_typename = "I_Heli_Transport_02_F" };
	case 2: {huron_typename = "B_Heli_Transport_01_F" };
};

// Overide Naval FOB
FOB_carrier = "";
FOB_carrier_center = "";
switch (GRLIB_naval_type) do {
	case 1: {FOB_carrier = "Land_Destroyer_01_base_F"; FOB_carrier_center = "Land_Destroyer_01_hull_04_F" };
	case 2: {FOB_carrier = "Land_Carrier_01_base_F"; FOB_carrier_center = "Land_Carrier_01_island_02_F" };
	case 3: {FOB_carrier = "fob_water1"; FOB_carrier_center = 7 };
};

if ( GRLIB_ACE_enabled ) then { GRLIB_fancy_info = 0 };		// Disable Fancy if ACE present
if ( GRLIB_ACE_medical_enabled ) then { PAR_revive = 0; GRLIB_fatigue = 1 };		// Disable PAR/Fatigue if ACE Medical is present
if ( GRLIB_fatigue == 1 ) then { GRLIB_fatigue = true } else { GRLIB_fatigue = false };
if ( GRLIB_introduction == 1 ) then { GRLIB_introduction = true } else { GRLIB_introduction = false };
if ( GRLIB_deployment_cinematic == 1 ) then { GRLIB_deployment_cinematic = true } else { GRLIB_deployment_cinematic = false };
if ( GRLIB_admin_menu == 1 ) then { GRLIB_admin_menu = true } else { GRLIB_admin_menu = false };
if ( GRLIB_hide_opfor == 1 ) then { GRLIB_hide_opfor = true } else { GRLIB_hide_opfor = false };
if ( GRLIB_permission_vehicles == 1 ) then { GRLIB_permission_vehicles = true } else { GRLIB_permission_vehicles = false };
if ( GRLIB_permission_enemy == 1 ) then { GRLIB_permission_enemy = true } else { GRLIB_permission_enemy = false };
if ( GRLIB_passive_income == 1 ) then { GRLIB_passive_income = true } else { GRLIB_passive_income = false };
if ( GRLIB_permissions_param == 1 ) then { GRLIB_permissions_param = true } else { GRLIB_permissions_param = false };
if ( GRLIB_use_whitelist == 1 ) then { GRLIB_use_whitelist = true } else { GRLIB_use_whitelist = false };
if ( GRLIB_use_exclusive == 1 ) then { GRLIB_use_exclusive = true } else { GRLIB_use_exclusive = false };
if ( GRLIB_civ_penalties == 1 ) then { GRLIB_civ_penalties = true } else { GRLIB_civ_penalties = false };
if ( GRLIB_opfor_english == 1 ) then { GRLIB_opfor_english = true } else { GRLIB_opfor_english = false };
if ( GRLIB_disable_death_chat == 1 ) then { GRLIB_disable_death_chat = true } else { GRLIB_disable_death_chat = false };
if ( GRLIB_server_persistent == 1 ) then { GRLIB_server_persistent = true } else { GRLIB_server_persistent = false };
if ( GRLIB_air_support == 1 ) then { GRLIB_air_support = true } else { GRLIB_air_support = false };
if ( GRLIB_free_loadout == 1 ) then { GRLIB_free_loadout = true } else { GRLIB_free_loadout = false };

// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };

// Params loaded
GRLIB_LRX_params_loaded = true;
publicVariable "GRLIB_LRX_params_loaded";
