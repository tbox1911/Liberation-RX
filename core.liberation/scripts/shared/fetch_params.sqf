//--- LRX Fetch Misson Parameters ----------------------------------------

// Map constant
[] call compileFinal preprocessFileLineNUmbers "gameplay_constants.sqf";

// Classename MOD source
[] call compileFinal preprocessFileLineNUmbers "mod_template\mod_init.sqf";

// Mission Parameter constant
[] call compileFinal preprocessFileLineNUmbers "mission_params.sqf";

//--- Parameters from Lobby ----------------------------------------------
GRLIB_use_whitelist = ["Whitelist",1] call bis_fnc_getParamValue;
GRLIB_use_exclusive = ["Exclusive",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_1 = ["WipeSave1",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_2 = ["WipeSave2",0] call bis_fnc_getParamValue;
GRLIB_param_open_params = ["OpenParams",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_params = ["WipeSave3",0] call bis_fnc_getParamValue;
GRLIB_force_load = ["ForceLoading",0] call bis_fnc_getParamValue;
//------------------------------------------------------------------------

private _lrx_getParamValue = {
	params ["_param", "_def"];
	{
		if (_x select 0 == _param) exitWith { _def = _x select 1 };
	} forEach _lrx_liberation_params;
	_def;
};

private _params_name = format ["%1-config", GRLIB_save_key];
if (GRLIB_param_wipe_params == 1) then { profileNamespace setVariable [_params_name, LRX_Mission_Params]; };

// Open Mission Parameters
if (GRLIB_param_open_params == 1) then {
	if (!isDedicated && hasInterface) then {
		[] execVM "scripts\client\commander\open_params.sqf";
	};
	waitUntil { sleep 1; GRLIB_param_open_params == 0 };
};

// Load Mission Parameters
private _lrx_liberation_params = profileNamespace getVariable _params_name;
if ( isNil "_lrx_liberation_params" ) then {
	_lrx_liberation_params = LRX_Mission_Params;
	profileNamespace setVariable [_params_name, _lrx_liberation_params];
};

// Selectable
GRLIB_introduction = ["Introduction",1] call _lrx_getParamValue;
GRLIB_deployment_cinematic = ["DeploymentCinematic",1] call _lrx_getParamValue;
GRLIB_unitcap = ["Unitcap",1] call _lrx_getParamValue;
GRLIB_fancy_info = ["FancyInfo",1] call _lrx_getParamValue;
GRLIB_hide_opfor = ["HideOpfor",1] call _lrx_getParamValue;
GRLIB_thermic = ["Thermic",1] call _lrx_getParamValue;
GRLIB_disable_death_chat = ["DeathChat", 1] call _lrx_getParamValue;
GRLIB_mod_preset_west = ["ModPresetWest", 0] call _lrx_getParamValue;
GRLIB_mod_preset_east = ["ModPresetEast", 0] call _lrx_getParamValue;
GRLIB_enable_arsenal = ["EnableArsenal",1] call _lrx_getParamValue;
GRLIB_filter_arsenal = ["FilterArsenal",1] call _lrx_getParamValue;
GRLIB_forced_loadout = ["ForcedLoadout",1] call _lrx_getParamValue;
GRLIB_opfor_english = ["EnglishOpfor", 0] call _lrx_getParamValue;
GRLIB_fob_type = [ "FobType",0] call _lrx_getParamValue;
GRLIB_huron_type = [ "HuronType", 0] call _lrx_getParamValue;
GRLIB_maximum_fobs = [ "MaximumFobs",5] call _lrx_getParamValue;
GRLIB_passive_income = ["PassiveIncome",0] call _lrx_getParamValue;
GRLIB_difficulty_modifier = ["Difficulty",1] call _lrx_getParamValue;
GRLIB_csat_aggressivity = ["Aggressivity",1] call _lrx_getParamValue;
GRLIB_adaptive_opfor = ["AdaptToPlayercount",1] call _lrx_getParamValue;
GRLIB_sector_radius = ["SectorRadius",0] call _lrx_getParamValue;
GRLIB_day_factor = ["DayDuration",1] call _lrx_getParamValue;
GRLIB_night_factor = ["NightDuration",1] call _lrx_getParamValue;
GRLIB_weather_param = ["Weather",1] call _lrx_getParamValue;
GRLIB_resources_multiplier = ["ResourcesMultiplier",1] call _lrx_getParamValue;
GRLIB_fatigue = ["Fatigue",0] call _lrx_getParamValue;
GRLIB_revive = ["Revive",3] call _lrx_getParamValue;
GRLIB_tk_mode = ["TK_mode",1] call _lrx_getParamValue;
GRLIB_tk_count = ["TK_count",4] call _lrx_getParamValue;
GRLIB_squad_size = ["SquadSize",2] call _lrx_getParamValue;
GRLIB_max_squad_size = ["MaxSquadSize",7] call _lrx_getParamValue;
GRLIB_max_spawn_point = ["MaxSpawnPoint",3] call _lrx_getParamValue;
GRLIB_permissions_param = ["Permissions",1] call _lrx_getParamValue;
GRLIB_permission_vehicles = ["EnableLock",1] call _lrx_getParamValue;
GRLIB_civilian_activity = ["Civilians",1] call _lrx_getParamValue;
GRLIB_wildlife_manager = ["Wildlife",1] call _lrx_getParamValue;
GRLIB_ammo_bounties = [ "AmmoBounties",0] call _lrx_getParamValue;
GRLIB_civ_penalties = [ "CivPenalties",0] call _lrx_getParamValue;
GRLIB_halo_param = ["HaloJump",1] call _lrx_getParamValue;
GRLIB_blufor_defenders = [ "BluforDefenders",1] call _lrx_getParamValue;
GRLIB_admin_menu = ["AdminMenu",1] call _lrx_getParamValue;
GRLIB_cleanup_vehicles = ["CleanupVehicles",1800] call _lrx_getParamValue;
GRLIB_autosave_timer = ["AutoSave",3600] call _lrx_getParamValue;
GRLIB_param_wipe_keepscore = ["KeepScore",0] call _lrx_getParamValue;

// Hardcoded
GRLIB_endgame = 0;
GRLIB_min_score_player = 20;	// Minimal player score to be saved
GRLIB_blufor_cap = GRLIB_blufor_cap * GRLIB_unitcap;
GRLIB_sector_cap = GRLIB_sector_cap * GRLIB_unitcap;
GRLIB_battlegroup_cap = GRLIB_battlegroup_cap * (sqrt GRLIB_unitcap) * (sqrt GRLIB_csat_aggressivity);
GRLIB_patrol_cap = GRLIB_patrol_cap * GRLIB_unitcap;
GRLIB_battlegroup_size = GRLIB_battlegroup_size * GRLIB_unitcap;
GRLIB_civilians_amount = GRLIB_civilians_amount * GRLIB_civilian_activity;

// Select MOD name
if (isNil "GRLIB_mod_west") then { GRLIB_mod_west = GRLIB_mod_list_west select GRLIB_mod_preset_west };
if (isNil "GRLIB_mod_east") then { GRLIB_mod_east = GRLIB_mod_list_east select GRLIB_mod_preset_east };
GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";

// Check wrong sides
if (GRLIB_force_load == 0 && GRLIB_mod_west == GRLIB_mod_east) then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid Side selection !\n\n
	side West (%1) conflict with side East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Side selection.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};
diag_log format ["--- LRX Mod Detection: %1 vs %2", GRLIB_mod_west, GRLIB_mod_east];

// Detect Addons
GRLIB_LRX_Music_enabled = isClass(configFile >> "cfgPatches" >> "LRX_Music"); // Returns true if LRX Music Pack is enabled
GRLIB_LRX_Texture_enabled = isClass(configFile >> "cfgPatches" >> "LRX_Texture"); // Returns true if LRX Textture Pack is enabled
GRLIB_ACE_enabled = isClass(configFile >> "cfgPatches" >> "ace_main"); // Returns true if ACE is enabled
GRLIB_ACE_medical_enabled = isClass(configFile >> "cfgPatches" >> "ace_medical"); // Returns true if ACE Medical is enabled
GRLIB_ACRE_enabled = isClass(configFile >> "cfgPatches" >> "acre_main"); // Returns true if ACRE is enabled
GRLIB_OPTRE_enabled = isClass(configFile >> "cfgPatches" >> "OPTRE_Core"); // Returns true if OPTRE is enabled
GRLIB_WS_enabled = isClass(configFile >> "CfgPatches" >> "data_f_lxWS"); // Returns true if WS is enabled
GRLIB_GM_enabled = isClass(configFile >> "cfgPatches" >> "gm_Core"); // Returns true if GlobMob is enabled
GRLIB_CUPW_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Weapons_AK"); // Returns true if CUP Weapons is enabled
GRLIB_CUPU_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Creatures_Extra"); // Returns true if CUP Units is enabled
GRLIB_CUPV_enabled = isClass(configFile >> "CfgPatches" >> "CUP_AirVehciles_AH1Z"); // Returns true if CUP Vehicles is enabled
GRLIB_EJW_enabled = isClass(configFile >> "CfgPatches" >> "Ej_u100"); // Returns true if EricJ Weapons is enabled
GRLIB_RHS_enabled = isClass(configFile >> "CfgPatches" >> "rhs_main"); // Returns true if RHS is enabled
GRLIB_LOP_enabled = isClass(configFile >> "CfgPatches" >> "lop_main"); // Returns true if LOP is enabled
GRLIB_R3F_enabled = isClass(configFile >> "CfgPatches" >> "r3f_armes"); // Returns true if R3F is enabled
GRLIB_SOG_enabled = isClass(configFile >> "CfgPatches" >> "vn_misc"); // Returns true if SOG is enabled
GRLIB_3CB_enabled = isClass(configFile >> "CfgMods" >> "UK3CB_BAF_Weapons"); // Returns true if UK3 CB is enabled
GRLIB_CWR_enabled = isClass(configFile >> "CfgMods" >> "cwr3_dlc"); // Returns true if CWR3 is enabled
GRLIB_UNS_enabled = isClass(configFile >> "CfgPatches" >> "uns_main"); // Returns true if Unsung is enabled
GRLIB_IFA_enabled = isClass(configFile >> "CfgPatches" >> "LIB_core"); // Returns true if IFA3 is enabled

// Check side Addon
if ( (!GRLIB_CUPU_enabled || !GRLIB_CUPV_enabled) && ["CP_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_EJW_enabled && ["EJW_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_R3F_enabled && ["R3F_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_RHS_enabled && ["RHS_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_GM_enabled && ["GM_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_OPTRE_enabled && ["OPTRE", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_WS_enabled && ["WS_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_SOG_enabled && ["SOG_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_CWR_enabled && ["CWR3_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_3CB_enabled && ["3CB", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_UNS_enabled && ["UNS_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };
if ( !GRLIB_IFA_enabled && ["IFA_", [GRLIB_mod_west, GRLIB_mod_east]] call F_startsWithMultiple) then { abort_loading = true };

if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid Side selection !\n\n
	Missing MOD Addons for side West (%1) or side East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Side selection.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};

// Overide Huron type
if ( GRLIB_mod_west in ["A3_BLU", "A3_IND"]) then {
	switch (GRLIB_huron_type) do {
		case 1: {huron_typename = "B_Heli_Transport_03_unarmed_F" };
		case 2: {huron_typename = "I_Heli_Transport_02_F" };
		case 3: {huron_typename = "B_Heli_Transport_01_F" };
	};
};

// ACE
if ( GRLIB_ACE_enabled ) then { GRLIB_fancy_info = 0 };		// Disable Fancy if ACE present
if ( GRLIB_ACE_medical_enabled ) then { GRLIB_revive = 0; GRLIB_fatigue = 1 };		// Disable PAR/Fatigue if ACE Medical is present
if ( GRLIB_fatigue == 1 ) then { GRLIB_fatigue = true } else { GRLIB_fatigue = false };
if ( GRLIB_introduction == 1 ) then { GRLIB_introduction = true } else { GRLIB_introduction = false };
if ( GRLIB_deployment_cinematic == 1 ) then { GRLIB_deployment_cinematic = true } else { GRLIB_deployment_cinematic = false };
if ( GRLIB_admin_menu == 1 ) then { GRLIB_admin_menu = true } else { GRLIB_admin_menu = false };
if ( GRLIB_hide_opfor == 1 ) then { GRLIB_hide_opfor = true } else { GRLIB_hide_opfor = false };
if ( GRLIB_enable_arsenal == 1 ) then { GRLIB_enable_arsenal = true } else { GRLIB_enable_arsenal = false };
if ( GRLIB_permission_vehicles == 1 ) then { GRLIB_permission_vehicles = true } else { GRLIB_permission_vehicles = false };
if ( GRLIB_adaptive_opfor == 1 ) then { GRLIB_adaptive_opfor = true } else { GRLIB_adaptive_opfor = false };
if ( GRLIB_passive_income == 1 ) then { GRLIB_passive_income = true } else { GRLIB_passive_income = false };
if ( GRLIB_permissions_param == 1 ) then { GRLIB_permissions_param = true } else { GRLIB_permissions_param = false };
if ( GRLIB_use_whitelist == 1 ) then { GRLIB_use_whitelist = true } else { GRLIB_use_whitelist = false };
if ( GRLIB_use_exclusive == 1 ) then { GRLIB_use_exclusive = true } else { GRLIB_use_exclusive = false };
if ( GRLIB_ammo_bounties == 1 ) then { GRLIB_ammo_bounties = true } else { GRLIB_ammo_bounties = false };
if ( GRLIB_civ_penalties == 1 ) then { GRLIB_civ_penalties = true } else { GRLIB_civ_penalties = false };
if ( GRLIB_blufor_defenders == 1 ) then { GRLIB_blufor_defenders = true } else { GRLIB_blufor_defenders = false };
if ( GRLIB_opfor_english == 1 ) then { GRLIB_opfor_english = true } else { GRLIB_opfor_english = false };
if ( GRLIB_disable_death_chat == 1 ) then { GRLIB_disable_death_chat = true } else { GRLIB_disable_death_chat = false };

// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };

// Map - Template Creators
GRLIB_map_modder = "Unknow";
GRLIB_west_modder = "Unknow";
GRLIB_east_modder = "Unknow";
