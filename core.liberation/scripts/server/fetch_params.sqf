//--- LRX Server Misson Parameters ----------------------------------------

diag_log "--- LRX: Loading Server settings ---";
GRLIB_endgame = 0;
GRLIB_global_stop = 0;

GRLIB_param_version = 1;
GRLIB_paramsV1_save_key = format ["%1-config", GRLIB_save_key];
GRLIB_paramsV2_save_key = format ["%1-%2", GRLIB_paramsV1_save_key, str (GRLIB_param_version)];

GRLIB_Template_Modloaded = {
	params ["_faction"];
	GRLIB_enabledPrefix findIf {!(_x#1) && {([(_x#0), _faction] call F_startsWith)}} == -1;
};

// Classename MOD source
[] call compileFinal preprocessFileLineNumbers "mod_template\mod_init.sqf";
LRX_mod_list_west = [];
LRX_mod_list_east = [];
LRX_mod_list_name = [];
if (GRLIB_LRX_Template_enabled) then {
	private _version = getNumber (configFile >> "cfgPatches" >> "LRX_Template" >> "version");
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
GRLIB_param_wipe_context = ["WipeContext",0] call bis_fnc_getParamValue;
GRLIB_force_load = ["ForceLoading",0] call bis_fnc_getParamValue;
GRLIB_log_settings = ["LogSettings",0] call bis_fnc_getParamValue;

GRLIB_trim_Params = {
	params["_params"];
	_trimmed = createHashMapFromArray (_params apply {
		[_x, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _y get GRLIB_PARAM_ValueKey]]]
	});
	_trimmed;
};

GRLIB_DefaultParams = {
	[LRX_Mission_Params] call GRLIB_trim_Params;
};

// Load Mission settings
_savedParams = profileNamespace getVariable [GRLIB_paramsV2_save_key, nil];
if (isNil "_savedParams" ) then {
	diag_log "--- LRX: No saved settings found, loading default ---";
	_savedParams = [] call GRLIB_DefaultParams;
	_v1Params = profileNamespace getVariable [GRLIB_paramsV1_save_key, nil];
	if (!(isNil "_v1Params") && {(typeName _v1Params) isEqualTo "ARRAY"}) then {
		// Convert V1 to V2
		diag_log format ["--- LRX: Old settings format detected, converting to new ---"];
		{
			if (!(isNil "_x") && {(typeName _x) isEqualTo "ARRAY" && {!(isNil {_x select 0}) && {!(isNil {_x select 1}) && {!((_x#0) isEqualTo GRLIB_PARAM_separatorKey) && (typeName (_x#0)) isEqualTo "STRING"}}}}) then {
				_key = (_x#0);
				_newParamHash = LRX_Mission_Params get _key;
				if (!(isNil "_newParamHash")) then {
					_savedValue = (_x#1);
					_defaultValue = _newParamHash get GRLIB_PARAM_ValueKey;
					if ((_savedValue isEqualType _defaultValue) && {_savedValue in (_newParamHash get GRLIB_PARAM_OptionValuesKey)}) then {
						_savedParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _savedValue]]];
					};
				};
			};
		} forEach _v1Params;
	};
	GRLIB_LRX_params = _savedParams;
} else {
	if (typeName _savedParams != "HASHMAP") then {
		diag_log format ["--- LRX: settings found but not a hashMap - resetting ---"];
		GRLIB_LRX_params = [] call GRLIB_DefaultParams;
	} else {
		diag_log "--- LRX: settings found - cleaning ---";
		_cleanedParams = createHashMap;
		{
			if (!(isNil "_x") && !(isNil "_y") && {(typeName _x) isEqualTo "STRING" && (typeName _y) isEqualTo "HASHMAP"}) then {
				_key = _x;
				_hash = _y;
				_value = _y get GRLIB_PARAM_ValueKey;
				_defParamHash = LRX_Mission_Params get _key;
				if (isNil "_defParamHash") then {
					// Delete outdated params
					diag_log format ["--- LRX: removing outdated setting: %1 ---", str _key];
				} else {
					_defaultValue = _defParamHash get GRLIB_PARAM_ValueKey;
					if (isNil "_value" || {!(_value isEqualType _defaultValue) || {!(_value in (_defParamHash get GRLIB_PARAM_OptionValuesKey))}}) then {
						// Reset invalid values
						diag_log format ["--- LRX: resetting invalid setting: %1 - %2 to %3 ---", str _key, str _value, str _defaultValue];
						if (!(isNil "_defaultValue")) then {
							_cleanedParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _defaultValue]]];
						} else {
							// Something is wrong with this parameter
							diag_log format ["--- LRX: system error, default value not found for setting %1 ---", str _key];
						};
					} else {
						// Valid value
						_cleanedParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _value]]];
					};
				};
			} else {
				// Delete invalid params
				diag_log format ["--- LRX: removing invalid setting ---"];
			};
		} forEach _savedParams;
		GRLIB_LRX_params = _cleanedParams;
	};
};
profileNamespace setVariable [GRLIB_paramsV2_save_key, GRLIB_LRX_params];

GRLIB_ParamsInitialized = (["OpenParams", 1] call bis_fnc_getParamValue) == 0;
publicVariable "GRLIB_ParamsInitialized";

if (!GRLIB_ParamsInitialized) then {
	publicVariable "GRLIB_LRX_params";
	waitUntil { sleep 1; GRLIB_ParamsInitialized };
};

// LRX Selectable
GRLIB_introduction = [GRLIB_PARAM_introductionKey] call lrx_getParamValue;
GRLIB_deployment_cinematic = [GRLIB_PARAM_DeploymentCinematic] call lrx_getParamValue;
GREUH_allow_mapmarkers = [GRLIB_PARAM_MapMarkers] call lrx_getParamValue;
GREUH_allow_platoonview = [GRLIB_PARAM_PlatoonView] call lrx_getParamValue;
GREUH_allow_nametags = [GRLIB_PARAM_NameTags] call lrx_getParamValue;
GRLIB_opforcap = [GRLIB_PARAM_Opforcap] call lrx_getParamValue;
GRLIB_unitcap = [GRLIB_PARAM_Unitcap] call lrx_getParamValue;
GRLIB_fancy_info = [GRLIB_PARAM_FancyInfo] call lrx_getParamValue;
GRLIB_hide_opfor = [GRLIB_PARAM_HideOpfor] call lrx_getParamValue;
GRLIB_show_blufor = [GRLIB_PARAM_ShowBlufor] call lrx_getParamValue;
GRLIB_thermic = [GRLIB_PARAM_Thermic] call lrx_getParamValue;
GRLIB_fob_type = [GRLIB_PARAM_FobType] call lrx_getParamValue;
GRLIB_huron_type = [GRLIB_PARAM_HuronType] call lrx_getParamValue;
GRLIB_naval_type = [GRLIB_PARAM_NavalFobType] call lrx_getParamValue;
GRLIB_max_fobs = [GRLIB_PARAM_MaxFobs] call lrx_getParamValue;
GRLIB_max_outpost = [GRLIB_PARAM_MaxOutpost] call lrx_getParamValue;
GRLIB_passive_income = [GRLIB_PARAM_PassiveIncome] call lrx_getParamValue;
GRLIB_passive_ammount = [GRLIB_PARAM_PassiveIncomeAmmount] call lrx_getParamValue;
GRLIB_resources_multiplier = [GRLIB_PARAM_ResourcesMultiplier] call lrx_getParamValue;
GRLIB_disable_death_chat = [GRLIB_PARAM_DeathChat] call lrx_getParamValue;
GRLIB_mod_west = [GRLIB_PARAM_ModPresetWest] call lrx_getParamValue;
GRLIB_mod_east = [GRLIB_PARAM_ModPresetEast] call lrx_getParamValue;
GRLIB_side_verif = [GRLIB_PARAM_SideVerification] call lrx_getParamValue;
GRLIB_mod_civ = [GRLIB_PARAM_ModPresetCiv] call lrx_getParamValue;
GRLIB_mod_taxi = [GRLIB_PARAM_ModPresetTaxi] call lrx_getParamValue;
GRLIB_enable_arsenal = [GRLIB_PARAM_EnableArsenal] call lrx_getParamValue;
GRLIB_filter_arsenal = [GRLIB_PARAM_FilterArsenal] call lrx_getParamValue;
GRLIB_forced_loadout = [GRLIB_PARAM_ForcedLoadout] call lrx_getParamValue;
GRLIB_force_english = [GRLIB_PARAM_ForceEnglish] call lrx_getParamValue;
GRLIB_difficulty_modifier = [GRLIB_PARAM_Difficulty] call lrx_getParamValue;
GRLIB_csat_aggressivity = [GRLIB_PARAM_Aggressivity] call lrx_getParamValue;
GRLIB_sector_radius = [GRLIB_PARAM_SectorRadius] call lrx_getParamValue;
GRLIB_TFR_radius = [GRLIB_PARAM_TFRadioRange] call lrx_getParamValue;
GRLIB_day_factor = [GRLIB_PARAM_DayDuration] call lrx_getParamValue;
GRLIB_night_factor = [GRLIB_PARAM_NightDuration] call lrx_getParamValue;
GRLIB_weather_param = [GRLIB_PARAM_Weather] call lrx_getParamValue;
GRLIB_fatigue = [GRLIB_PARAM_Fatigue] call lrx_getParamValue;
GRLIB_tk_mode = [GRLIB_PARAM_TK_mode] call lrx_getParamValue;
GRLIB_tk_count = [GRLIB_PARAM_TK_count] call lrx_getParamValue;
GRLIB_garage_size = [GRLIB_PARAM_MaxGarageSize] call lrx_getParamValue;
GRLIB_squad_size = [GRLIB_PARAM_SquadSize] call lrx_getParamValue;
GRLIB_max_squad_size = [GRLIB_PARAM_MaxSquadSize] call lrx_getParamValue;
GRLIB_max_spawn_point = [GRLIB_PARAM_MaxSpawnPoint] call lrx_getParamValue;
GRLIB_allow_redeploy = [GRLIB_PARAM_Redeploy] call lrx_getParamValue;
GRLIB_permissions_param = [GRLIB_PARAM_Permissions] call lrx_getParamValue;
GRLIB_permission_vehicles = [GRLIB_PARAM_EnableLock] call lrx_getParamValue;
GRLIB_permission_enemy = [GRLIB_PARAM_EnemyLock] call lrx_getParamValue;
GRLIB_civilian_activity = [GRLIB_PARAM_Civilians] call lrx_getParamValue;
GRLIB_patrols_activity = [GRLIB_PARAM_Patrols] call lrx_getParamValue;
GRLIB_wildlife_manager = [GRLIB_PARAM_Wildlife] call lrx_getParamValue;
GRLIB_civ_penalties = [GRLIB_PARAM_CivPenalties] call lrx_getParamValue;
GRLIB_halo_param = [GRLIB_PARAM_HaloJump] call lrx_getParamValue;
GRLIB_admin_menu = [GRLIB_PARAM_AdminMenu] call lrx_getParamValue;
GRLIB_cleanup_vehicles = [GRLIB_PARAM_CleanupVehicles] call lrx_getParamValue;
GRLIB_vehicles_fuel = [GRLIB_PARAM_FuelConso] call lrx_getParamValue;
GRLIB_enable_drones = [GRLIB_PARAM_Drones] call lrx_getParamValue;
GRLIB_autosave_timer = [GRLIB_PARAM_AutoSave] call lrx_getParamValue;
GRLIB_param_wipe_keepscore = [GRLIB_PARAM_KeepScore] call lrx_getParamValue;
GRLIB_param_wipe_keepcontext = [GRLIB_PARAM_KeepContext] call lrx_getParamValue;
GRLIB_respawn_timer = [GRLIB_PARAM_Respawn] call lrx_getParamValue;
GRLIB_respawn_cooldown = [GRLIB_PARAM_RespawnCD] call lrx_getParamValue;
GRLIB_kick_idle = [GRLIB_PARAM_KickIdle] call lrx_getParamValue;
GRLIB_server_persistent = [GRLIB_PARAM_Persistent] call lrx_getParamValue;
GRLIB_air_support = [GRLIB_PARAM_AirSupport] call lrx_getParamValue;
GRLIB_despawn_tickets = [GRLIB_PARAM_SectorDespawn] call lrx_getParamValue;
GRLIB_building_ai_ratio = [GRLIB_PARAM_BuildingRatio] call lrx_getParamValue;
GRLIB_victory_condition = [GRLIB_PARAM_VictoryCondition] call lrx_getParamValue;
GRLIB_Undercover_mode = [GRLIB_PARAM_UndercoverModeEnabled] call lrx_getParamValue;
GRLIB_Commander_mode = [GRLIB_PARAM_CommanderModeEnabled] call lrx_getParamValue;
GRLIB_Commander_radius = [GRLIB_PARAM_CommanderModeRadius] call lrx_getParamValue;
GRLIB_MineProbability = [GRLIB_PARAM_MineProbability] call lrx_getParamValue;
GRLIB_AlarmsEnabled = [GRLIB_PARAM_Alarms] call lrx_getParamValue;
GRLIB_Commander_AutoStart = [GRLIB_PARAM_CommanderAutoStart] call lrx_getParamValue;
GRLIB_Commander_VoteTime = [GRLIB_PARAM_CommanderVoteTimeout] call lrx_getParamValue;
GRLIB_Commander_VoteEnabled = [GRLIB_PARAM_CommPlayerVote] call lrx_getParamValue;
GRLIB_vulnerability_timer = [GRLIB_PARAM_VulnerabilityTimer] call lrx_getParamValue;
GRLIB_vehicle_defense = [GRLIB_PARAM_VehicleDefense] call lrx_getParamValue;
GRLIB_artillery_maxshot = [GRLIB_PARAM_ArtyMaxShot] call lrx_getParamValue;
A3W_Mission_count = [GRLIB_PARAM_A3WCount] call lrx_getParamValue;
A3W_Mission_delay = [GRLIB_PARAM_A3WDelay] call lrx_getParamValue;

// Disable TFAR Relay
if (GRLIB_TFR_radius == 0) then { GRLIB_TFR_enabled = false };

// Overide Huron type
switch (GRLIB_huron_type) do {
	case 0: { huron_typename = "B_Heli_Transport_03_unarmed_F" };
	case 1: { huron_typename = "I_Heli_Transport_02_F" };
	case 2: { huron_typename = "B_Heli_Transport_01_F" };
};

GRLIB_civilians_amount = GRLIB_civilians_amount * GRLIB_civilian_activity; // Maximal Number of civilians
GRLIB_opfor_cap = GRLIB_opforcap * GRLIB_unitcap;	// Maximal number of enemies units
GRLIB_battlegroup_size = GRLIB_battlegroup_size * GRLIB_unitcap; // Maximal size of enemy battlegroups
GRLIB_patrol_amount = GRLIB_patrol_amount * GRLIB_patrols_activity; // Maximal number of patrols

// PAR Revive
PAR_revive = ["PAR_Revive"] call lrx_getParamValue;
PAR_ai_revive_max = ["PAR_AI_Revive"] call lrx_getParamValue;
PAR_bleedout = ["PAR_BleedOut"] call lrx_getParamValue;
PAR_grave = ["PAR_Grave"] call lrx_getParamValue;

// Validate Mod Selection
if (typeName GRLIB_mod_west != "STRING" || typeName GRLIB_mod_east != "STRING") then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - old Parameters version detected !\n\n
	Your Settings are incompatible with this version of LRX,\n
	Go to Game Parameters and Reset Mission Settings.\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Mod Template selection.\n
	*********************************"];
};

if (GRLIB_mod_west == "---" ||  GRLIB_mod_east == "---") then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid MOD Template Selection !\n\n
	Invalid Template Selection for side West (%1) or East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Side selection or add needed Addons.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};

// SIDES
GRLIB_side_civilian = CIVILIAN;
GRLIB_side_friendly = ({if (_x select 0 == GRLIB_mod_west) exitWith {_x select 2}} forEach GRLIB_mod_list_name);
GRLIB_side_enemy = ({if (_x select 0 == GRLIB_mod_east) exitWith {_x select 2}} forEach GRLIB_mod_list_name);
if (GRLIB_side_verif == 1 && GRLIB_side_friendly == GRLIB_side_enemy) then {
	GRLIB_side_enemy = ([WEST, EAST, INDEPENDENT] - [GRLIB_side_friendly]) select 0;
};

if (GRLIB_side_civilian in [GRLIB_side_friendly, GRLIB_side_enemy]) then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Side Faction Verification Failed !\n\n
	Civilian Side is forbiden - Side West (%1) / Side East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Change faction or Edit the template.\n
	*********************************", GRLIB_side_friendly, GRLIB_side_enemy];
};

if (GRLIB_side_friendly == GRLIB_side_enemy) then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Side Faction Verification Failed !\n\n
	Same Side for both selection is disabled by settings! - Side West (%1) / Side East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Change the Side of one selection or change verification settings.\n
	*********************************", GRLIB_side_friendly, GRLIB_side_enemy];
};

if (GRLIB_mod_list_west find GRLIB_mod_west < 0 || GRLIB_mod_list_east find GRLIB_mod_east < 0) then { abort_loading = true };
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Missing: LRX_Template MOD !\n\n
	Template for side West (%1) or East (%2) do not exist.\n
	you must add LRX_Template Mod to your setup.\n
	see: https://steamcommunity.com/sharedfiles/filedetails/?id=3014195090\n\n
	Loading Aborted to protect data integrity.\n
	Load the LRX_Template Mod or change Mission Settings.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};

abort_loading = ([GRLIB_mod_west, GRLIB_mod_east] findIf {!([_x] call GRLIB_Template_Modloaded)}) != -1;
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - Invalid Side selection !\n\n
	Missing MOD Addons for side West (%1) or East (%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Side selection or add needed Addons.\n
	*********************************", GRLIB_mod_west, GRLIB_mod_east];
};

diag_log format ["--- LRX Mod Detection: %1 vs %2", GRLIB_mod_west, GRLIB_mod_east];

// Faction Colors
GRLIB_color_unknown = "ColorUNKNOWN";
GRLIB_color_civilian = "ColorCIV";

switch (GRLIB_side_friendly) do {
	if (isNil "GRLIB_color_friendly") then {
		case WEST: {
			GRLIB_color_friendly = "ColorBLUFOR";
			GRLIB_color_friendly_bright = "ColorBlue";
		};
		case EAST: {
			GRLIB_color_friendly = "ColorOPFOR";
			GRLIB_color_friendly_bright = "ColorRED";
		};
		case INDEPENDENT: {
			GRLIB_color_friendly = "ColorGUER";
			GRLIB_color_friendly_bright = "ColorGreen";
		};
		default {
			GRLIB_color_friendly = "ColorUNKNOWN";
			GRLIB_color_friendly_bright = "ColorUNKNOWN";
		};
	};
};

switch (GRLIB_side_enemy) do {
	if (isNil "GRLIB_color_enemy") then {	
		case WEST: {
			GRLIB_color_enemy = "ColorBLUFOR";
			GRLIB_color_enemy_bright = "ColorBlue";
		};
		case EAST: {
			GRLIB_color_enemy = "ColorOPFOR";
			GRLIB_color_enemy_bright = "ColorRED";
		};
		case INDEPENDENT: {
			GRLIB_color_enemy = "ColorGUER";
			GRLIB_color_enemy_bright = "ColorGreen";
		};
		default {
			GRLIB_color_enemy = "ColorUNKNOWN";
			GRLIB_color_enemy_bright = "ColorUNKNOWN";
		};
	};
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
if ( GRLIB_ACE_medical_enabled ) then { PAR_revive = 0; GRLIB_fatigue = 1 };		// Disable PAR/Fatigue if ACE Medical is present
GRLIB_fatigue = (GRLIB_fatigue == 1);
GRLIB_introduction = (GRLIB_introduction == 1);
GRLIB_deployment_cinematic = (GRLIB_deployment_cinematic == 1);
GRLIB_admin_menu = (GRLIB_admin_menu == 1);
GRLIB_hide_opfor = (GRLIB_hide_opfor == 1);
GRLIB_permission_vehicles = (GRLIB_permission_vehicles == 1);
GRLIB_permission_enemy = (GRLIB_permission_enemy == 1);
GRLIB_vehicle_defense = (GRLIB_vehicle_defense == 1);
GRLIB_use_whitelist = (GRLIB_use_whitelist == 1);
GRLIB_permissions_param = (GRLIB_permissions_param == 1);
GRLIB_use_exclusive = (GRLIB_use_exclusive == 1);
GRLIB_force_english = (GRLIB_force_english == 1);
GRLIB_enable_drones = (GRLIB_enable_drones == 1);
GRLIB_disable_death_chat = (GRLIB_disable_death_chat == 1);
GRLIB_server_persistent = (GRLIB_server_persistent == 1);
GRLIB_air_support = (GRLIB_air_support == 1);
GRLIB_Commander_mode = (GRLIB_Commander_mode == 1);
GRLIB_AlarmsEnabled = GRLIB_AlarmsEnabled == 1;
GRLIB_Commander_AutoStart = GRLIB_Commander_AutoStart == 1;
GRLIB_Commander_VoteEnabled = GRLIB_Commander_VoteEnabled == 1;

// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };

// Publish variables
publicVariable "GRLIB_endgame";
publicVariable "GRLIB_global_stop";
publicVariable "GRLIB_introduction";
publicVariable "GRLIB_deployment_cinematic";
publicVariable "GREUH_allow_mapmarkers";
publicVariable "GREUH_allow_platoonview";
publicVariable "GREUH_allow_nametags";
publicVariable "GRLIB_fancy_info";
publicVariable "GRLIB_hide_opfor";
publicVariable "GRLIB_show_blufor";
publicVariable "GRLIB_thermic";
publicVariable "GRLIB_fob_type";
publicVariable "GRLIB_huron_type";
publicVariable "GRLIB_naval_type";
publicVariable "GRLIB_max_fobs";
publicVariable "GRLIB_max_outpost";
publicVariable "GRLIB_passive_income";
publicVariable "GRLIB_passive_ammount";
publicVariable "GRLIB_resources_multiplier";
publicVariable "GRLIB_disable_death_chat";
publicVariable "GRLIB_mod_west";
publicVariable "GRLIB_mod_east";
publicVariable "GRLIB_mod_civ";
publicVariable "GRLIB_mod_taxi";
publicVariable "GRLIB_enable_arsenal";
publicVariable "GRLIB_filter_arsenal";
publicVariable "GRLIB_forced_loadout";
publicVariable "GRLIB_force_english";
publicVariable "GRLIB_sector_radius";
publicVariable "GRLIB_fatigue";
publicVariable "GRLIB_tk_mode";
publicVariable "GRLIB_tk_count";
publicVariable "GRLIB_garage_size";
publicVariable "GRLIB_squad_size";
publicVariable "GRLIB_max_squad_size";
publicVariable "GRLIB_max_spawn_point";
publicVariable "GRLIB_allow_redeploy";
publicVariable "GRLIB_permissions_param";
publicVariable "GRLIB_permission_vehicles";
publicVariable "GRLIB_halo_param";
publicVariable "GRLIB_admin_menu";
publicVariable "GRLIB_vehicles_fuel";
publicVariable "GRLIB_enable_drones";
publicVariable "GRLIB_respawn_timer";
publicVariable "GRLIB_respawn_cooldown";
publicVariable "GRLIB_kick_idle";
publicVariable "GRLIB_air_support";
publicVariable "GRLIB_Undercover_mode";
publicVariable "GRLIB_Commander_mode";
//publicVariable "GRLIB_Commander_radius";
publicVariable "GRLIB_Commander_VoteEnabled";
publicVariable "GRLIB_vehicle_defense";
publicVariable "GRLIB_artillery_maxshot";
publicVariable "PAR_revive";
publicVariable "PAR_ai_revive_max";
publicVariable "PAR_bleedout";
publicVariable "PAR_grave";
publicVariable "GRLIB_side_civilian";
publicVariable "GRLIB_side_friendly";
publicVariable "GRLIB_side_enemy";
publicVariable "GRLIB_color_friendly";
publicVariable "GRLIB_color_friendly_bright";
publicVariable "GRLIB_color_enemy";
publicVariable "GRLIB_color_enemy_bright";
publicVariable "GRLIB_color_unknown";
publicVariable "GRLIB_color_civilian";
publicVariable "FOB_boat_typename";
publicVariable "FOB_carrier";

// Params loaded
GRLIB_LRX_server_params_loaded = true;
diag_log "--- LRX: Server settings loaded ---";