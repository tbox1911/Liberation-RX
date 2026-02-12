// LRX Selectable

GRLIB_opforcap = [GRLIB_PARAM_Opforcap] call lrx_getParamValue;
GRLIB_unitcap = [GRLIB_PARAM_Unitcap] call lrx_getParamValue;
GRLIB_fancy_info = [GRLIB_PARAM_FancyInfo] call lrx_getParamValue;
GRLIB_fob_type = [GRLIB_PARAM_FobType] call lrx_getParamValue;
GRLIB_huron_type = [GRLIB_PARAM_HuronType] call lrx_getParamValue;
GRLIB_naval_type = [GRLIB_PARAM_NavalFobType] call lrx_getParamValue;
GRLIB_resources_multiplier = [GRLIB_PARAM_ResourcesMultiplier] call lrx_getParamValue;
GRLIB_mod_west = [GRLIB_PARAM_ModPresetWest] call lrx_getParamValue;
GRLIB_mod_east = [GRLIB_PARAM_ModPresetEast] call lrx_getParamValue;
GRLIB_mod_civ = [GRLIB_PARAM_ModPresetCiv] call lrx_getParamValue;
GRLIB_mod_taxi = [GRLIB_PARAM_ModPresetTaxi] call lrx_getParamValue;
GRLIB_enable_arsenal = [GRLIB_PARAM_EnableArsenal] call lrx_getParamValue;
GRLIB_filter_arsenal = [GRLIB_PARAM_FilterArsenal] call lrx_getParamValue;
GRLIB_free_loadout = [GRLIB_PARAM_FreeLoadout] call lrx_getParamValue;
GRLIB_force_english = [GRLIB_PARAM_ForceEnglish] call lrx_getParamValue;
GRLIB_sector_radius = [GRLIB_PARAM_SectorRadius] call lrx_getParamValue;
GRLIB_TFR_radius = [GRLIB_PARAM_TFRadioRange] call lrx_getParamValue;
GRLIB_squad_size = [GRLIB_PARAM_SquadSize] call lrx_getParamValue;
GRLIB_max_squad_size = [GRLIB_PARAM_MaxSquadSize] call lrx_getParamValue;
GRLIB_max_spawn_point = [GRLIB_PARAM_MaxSpawnPoint] call lrx_getParamValue;
GRLIB_allow_redeploy = [GRLIB_PARAM_Redeploy] call lrx_getParamValue;
GRLIB_permission_vehicles = [GRLIB_PARAM_EnableLock] call lrx_getParamValue;
GRLIB_permission_enemy = [GRLIB_PARAM_EnemyLock] call lrx_getParamValue;
GRLIB_civilian_activity = [GRLIB_PARAM_Civilians] call lrx_getParamValue;
GRLIB_patrols_activity = [GRLIB_PARAM_Patrols] call lrx_getParamValue;
GRLIB_wildlife_manager = [GRLIB_PARAM_Wildlife] call lrx_getParamValue;
GRLIB_civ_penalties = [GRLIB_PARAM_CivPenalties] call lrx_getParamValue;
GRLIB_halo_param = [GRLIB_PARAM_HaloJump] call lrx_getParamValue;
GRLIB_enable_drones = [GRLIB_PARAM_Drones] call lrx_getParamValue;
GRLIB_alarms_enabled = [GRLIB_PARAM_Alarms] call lrx_getParamValue;
GRLIB_Undercover_mode = [GRLIB_PARAM_UndercoverModeEnabled] call lrx_getParamValue;
GRLIB_Commander_mode = [GRLIB_PARAM_CommanderModeEnabled] call lrx_getParamValue;
GRLIB_Commander_radius = [GRLIB_PARAM_CommanderModeRadius] call lrx_getParamValue;
GRLIB_Commander_VoteEnabled = [GRLIB_PARAM_CommPlayerVote] call lrx_getParamValue;

// Disable TFAR Relay
if (GRLIB_TFR_radius == 0) then { GRLIB_TFR_enabled = false };

// Overide Huron type
switch (GRLIB_huron_type) do {
	case 0: { huron_typename = "B_Heli_Transport_03_unarmed_F" };
	case 1: { huron_typename = "I_Heli_Transport_02_F" };
	case 2: { huron_typename = "B_Heli_Transport_01_F" };
};

// Fix missing Apex
GRLIB_APEX_enabled = (395180 in (getDLCs 1));		// Returns true if Apex is enabled
FOB_boat_typename = "B_G_Boat_Transport_02_F";
if (!GRLIB_APEX_enabled && !isDedicated) then {
	huron_typename = "I_Heli_Transport_02_F";
	FOB_boat_typename = "B_G_Boat_Transport_01_F";
};

// Overide Naval FOB
FOB_carrier = "";
switch (GRLIB_naval_type) do {
	case 1: { FOB_carrier = "Land_Destroyer_01_base_F" };
	case 2: { FOB_carrier = "Land_Carrier_01_base_F" };
	case 3: { FOB_carrier = "fob_water1" };
};

// Transfom true/false Param
if ( GRLIB_ACE_enabled ) then { GRLIB_fancy_info = 0 };		// Disable Fancy if ACE present

GRLIB_permission_vehicles = (GRLIB_permission_vehicles == 1);
GRLIB_permission_enemy = (GRLIB_permission_enemy == 1);
GRLIB_free_loadout = (GRLIB_free_loadout == 1);
GRLIB_force_english = (GRLIB_force_english == 1);
GRLIB_enable_drones = (GRLIB_enable_drones == 1);
GRLIB_Commander_mode = (GRLIB_Commander_mode == 1);
GRLIB_alarms_enabled = (GRLIB_alarms_enabled == 1);
GRLIB_Commander_VoteEnabled = GRLIB_Commander_VoteEnabled == 1;

// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };
