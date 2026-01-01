//--- LRX Shared Misson Parameters ----------------------------------------

// Map constant
GRLIB_map_modder = "Unknow";
GRLIB_west_modder = "Unknow";
GRLIB_east_modder = "Unknow";
[] call compileFinal preprocessFileLineNumbers "gameplay_constants.sqf";

// Detect Addons
GRLIB_3CB_enabled = isClass(configFile >> "CfgPatches" >> "UK3CB_Factions_Common"); // Returns true if 3CB is enabled
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
GRLIB_SPE_enabled = isClass(configFile >> "CfgPatches" >> "WW2_SPE_Mortain"); // Returns true if SPE is enabled
GRLIB_TFR_enabled = isClass(configfile >> "CfgPatches" >> "task_force_radio"); // Returns true if TFAR is enabled
GRLIB_UNS_enabled = isClass(configFile >> "CfgPatches" >> "uns_main"); // Returns true if Unsung is enabled
GRLIB_WS_enabled = isClass(configFile >> "CfgPatches" >> "data_f_lxWS"); // Returns true if WS is enabled
GRLIB_ASZ_enabled = isClass(configFile >> "CfgPatches" >> "mas_itl_lite_weapons"); // Returns true if Italian ASZ is enabled
GRLIB_SMA_enabled = isClass(configFile >> "CfgPatches" >> "SMA_CMORE"); // Returns true if Specialist Military Arms (SMA) is enabled

GRLIB_enabledPrefix = [
	["3CB", GRLIB_3CB_enabled],
	["AMF_", GRLIB_AMF_enabled],
	["ASZ_", GRLIB_ASZ_enabled],
	["CP_", GRLIB_CUP_enabled],
	["CWR3_", GRLIB_CWR_enabled],
	["EJW_", GRLIB_EJW_enabled],
	["GM_", GRLIB_GM_enabled],
	["IFA_", GRLIB_IFA_enabled],
	["OPTRE", GRLIB_OPTRE_enabled],
	["R3F_", GRLIB_R3F_enabled],
	["RHS_AFRF", GRLIB_RHSAF_enabled],
	["RHS_USAF", GRLIB_RHSUS_enabled],
	["SOG_", GRLIB_SOG_enabled],
	["UNS_", GRLIB_UNS_enabled],
	["WS_", GRLIB_WS_enabled]
];

// Mission Parameter constant
//[] call compileFinal preprocessFileLineNumbers "mission_params.sqf";

// Hardcoded
GRLIB_fob_range = 125;								// FOB build range max
GRLIB_outpost_range = 80;							// Outpost build range max
GRLIB_min_score_player = 20;						// Minimal player score to be saved
GRLIB_blufor_cap = 50;								// Maximal number of friendly units
GRLIB_max_active_sectors = 4;						// Maximal active sectors at the same time
GRLIB_recycling_percentage = 0.75;					// Factor for recycling cost
GRLIB_radiotower_size = GRLIB_sector_size * 3;
GRLIB_battlegroup_size = 4;
GRLIB_civilians_amount = 12;
GRLIB_patrol_amount = 8;
GRLIB_secondary_missions_costs = [150, 70, 10, 1000];
GRLIB_defense_costs = [0, 100, 200, 300];

GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";
