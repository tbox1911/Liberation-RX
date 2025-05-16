//--- LRX Fetch Misson Parameters ----------------------------------------

// Map constant
GRLIB_map_modder = "Unknow";
GRLIB_west_modder = "Unknow";
GRLIB_east_modder = "Unknow";
[] call compileFinal preprocessFileLineNumbers "gameplay_constants.sqf";
GRLIB_param_version = 1;
GRLIB_paramsV1_save_key = format ["%1-config", GRLIB_save_key];
GRLIB_paramsV2_save_key = format ["%1-%2", GRLIB_paramsV1_save_key, str (GRLIB_param_version)];

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

diag_log "--- LRX: Loading settings ---";
// Load Mission settings
if (isServer) then {

	_savedParams = profileNamespace getVariable [GRLIB_paramsV2_save_key, nil];
	if ( isNil "_savedParams" ) then {
		diag_log "--- LRX: No saved settings found, loading default ---";
		_savedParams = +LRX_Mission_Params;
		_v1Params = profileNamespace getVariable [GRLIB_paramsV1_save_key, nil];
		if (!isNil "_v1Params") then {
			// Convert V1 to V2
			diag_log format ["--- LRX: Old settings format detected, converting to new ---"];
			{
				_key = _x select 0;
				if (!(_key isEqualTo GRLIB_PARAM_separatorKey)) then {
					_value = _x select 1;
					_newParamHash = LRX_Mission_Params get _key;
					// Dont add obsolete params
					if (!isNil "_newParamHash") then {
						_defaultValue = _newParamHash get GRLIB_PARAM_ValueKey;
						if ((_value isEqualType _defaultValue) && {_value in (_newParamHash get GRLIB_PARAM_OptionValuesKey)}) then {
							_savedParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _value]]];
						};
					};
				};
			} forEach _v1Params;
		};
		GRLIB_LRX_params = [_savedParams] call GRLIB_trim_Params;
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

	publicVariable "GRLIB_LRX_params";
	profileNamespace setVariable [GRLIB_paramsV2_save_key, GRLIB_LRX_params];
	saveProfileNamespace;
	diag_log format ["--- LRX: settings saved ---"];
} else {
	waitUntil { sleep 1; !isNil "GRLIB_LRX_params" };
};

// Group the parameters by category - respects order of params
GRLIB_groupedParams = createHashMap;
{
	_key = _x;
	_hash = LRX_Mission_Params get _key;
	_category = _hash get GRLIB_PARAM_CategoryKey;
	_groupParams = GRLIB_groupedParams getOrDefault [_category, []];
	_groupParams pushBack [_key, _hash];
	GRLIB_groupedParams set [_category, _groupParams];
} forEach LRX_ParamArray;

GRLIB_ParamControls = [];

GRLIB_SetupParamMenu = {
	private _display = findDisplay 5119;
	private _idx = 1;

	{
		_category = _x;
		_paramArray = GRLIB_groupedParams get _category;
		if (!isNil "_paramArray") then {
			_control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
			_control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
			_control ctrlSetBackgroundColor [0,0,0.80,0.12];
			_control ctrlCommit 0;
			GRLIB_ParamControls pushBack _control;

			_control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
			_control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.5 * safeZoneW, 0.025  * safezoneH];
			_control ctrlSetText format ["%1 %2 %1", GRLIB_PARAM_separatorKey, _category];
			_control ctrlCommit 0;
			GRLIB_ParamControls pushBack _control;

			_idx = _idx + 1;

			{
				_key = _x select 0;
				_hash = _x select 1;
				if ( _idx % 2 == 0 ) then {
					_control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
					_control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
					_control ctrlSetBackgroundColor [0.75,1,0.75,0.12];
					_control ctrlCommit 0;
					GRLIB_ParamControls pushBack _control;
				};	
				_control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
				_control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.45 * safeZoneW, 0.025  * safezoneH];
				_control ctrlSetText (_hash get GRLIB_PARAM_NameKey);
				_description = _hash get GRLIB_PARAM_DescriptionKey;
				if (!isNil "_description") then {
					_control ctrlSetTooltip _description;
				};
				_control ctrlCommit 0;
				GRLIB_ParamControls pushBack _control;

				_control = _display ctrlCreate [ "RscCombo", (200 + _idx), _display displayCtrl 9969 ];
				_control ctrlSetPosition [ ((0.072 * 6.5) - 0.02) * safeZoneW, ((_idx * 0.025) * safezoneH) + 0.0025, ((0.072 * 2) * safeZoneW), 0.022  * safezoneH];
				_control ctrlSetBackgroundColor [0.2,0.23,0.18,0.85];
				if ( _idx % 2 == 0 ) then {
					_control ctrlSetBackgroundColor [0.27,0.30,0.23,0.85];
				};
				GRLIB_ParamControls pushBack _control;

				{ 
					_control lbAdd _x;
				} forEach (_hash get GRLIB_PARAM_OptionLabelKey);
				_optionDescription = _hash getOrDefault [GRLIB_PARAM_OptionDescriptionKey, []];
				{ 
					
					_control lbSetTooltip [_forEachIndex, _x];
				} forEach _optionDescription;

				_default = _hash get GRLIB_PARAM_ValueKey;
				_selection = (GRLIB_ModParams getOrDefault [_key, _hash]) getOrDefault [GRLIB_PARAM_ValueKey, _default];
				_values = _hash get GRLIB_PARAM_OptionValuesKey;
				if (count (_values) > 0) then {
					_selection = (_values) find _selection;
					if (_selection == -1) then { _selection = 0 };
				};
				_control lbSetCurSel _selection;
				_control ctrlAddEventHandler ["LBSelChanged", format ["[(_this#1),%1] call GRLIB_SetValue;", str _key]];
				_control ctrlCommit 0;
				_idx = _idx + 1;
			} forEach _paramArray;
		};
	} foreach GRLIB_PARAM_CatOrder;
	
};

GRLIB_SetValue = {
	params ["_lbCurSel", "_key"];
	_parHash = LRX_Mission_Params get _key;
	_values = _parHash get GRLIB_PARAM_OptionValuesKey;
	_newValue = _values#_lbCurSel;
	GRLIB_ModParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _newValue]]];
};

GRLIB_CreateParamDialog = {
	[] call GRLIB_CloseDialog;
	createDialog "liberation_params";
	waitUntil { dialog };

	private _display = findDisplay 5119;

	private _control = _display ctrlCreate ["RscText", (100 + 0), _display displayCtrl 9969];
	_control ctrlSetPosition [0,  (0 * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
	_control ctrlSetText format ["Parameters Profile name: %1", GRLIB_paramsV2_save_key];
	_control ctrlSetTextColor [0.5,0.5,0.5,1];
	_control ctrlCommit 0;
	[] call GRLIB_SetupParamMenu;

	// Instead of disabling the escape key, lets just reopen the dialog if it somehow gets closed - until the player saves, cancels, or used the game menu to exit the mission - i personally hate disabling players keys it makes them feel trapped
	GRLIB_DialogOpen = true;
	0 spawn {
		while {GRLIB_DialogOpen} do {
			if (!dialog) exitWith {
				0 spawn GRLIB_CreateParamDialog;
			};	
			sleep 1;
		};
	};
};

GRLIB_refreshDialog = {
	// Reset the dialog without closing it
	{
		ctrlDelete _x;
	} forEach GRLIB_ParamControls;
	GRLIB_ParamControls = [];
	[] call GRLIB_SetupParamMenu;
};

GRLIB_resetParams = {
	GRLIB_ModParams = [LRX_Mission_Params] call GRLIB_trim_Params;
	[] call GRLIB_refreshDialog;
};

GRLIB_cancelParams = {
	GRLIB_ModParams = +GRLIB_LRX_params;
	[] call GRLIB_refreshDialog;
};

GRLIB_saveParams = {
	[] call GRLIB_CloseDialog;
	[
		[GRLIB_ModParams],
		{
			params ["_params"];
			profileNamespace setVariable [GRLIB_paramsV2_save_key, _params];
			saveProfileNamespace;
			GRLIB_LRX_params = _params;
			publicVariable "GRLIB_LRX_params";
			GRLIB_InitialParamsSet = true;
			publicVariable "GRLIB_InitialParamsSet";
		}
	] remoteExec ["bis_fnc_call", 2];

	waitUntil { sleep 0.5; GRLIB_InitialParamsSet};

	// If dialog opened mid-game - we may be able to upgrade this to modify variables mid-game
	if (!(isNil "GRLIB_init_server")) then {
		[localize "STR_MISSION_RESTART_REQUIRED",localize "STR_LRX_SETTINGS_TITLE",true] call BIS_fnc_guiMessage;
	};
};

GRLIB_CloseDialog = {
	// Close the dialog
	GRLIB_DialogOpen = false;
	closeDialog 0;
	GRLIB_ParamControls = [];
};

GRLIB_DialogOpen = false;
GRLIB_ModParams = +GRLIB_LRX_params;

if (isNil "GRLIB_InitialParamsSet") then {
	GRLIB_InitialParamsSet = (["OpenParams", 1] call bis_fnc_getParamValue) == 0;
};

if (!GRLIB_InitialParamsSet) then {
	// Open Mission Parameters - only called by client
	if (!isDedicated && hasInterface) then {
		[] execVM "scripts\client\commander\open_params.sqf";
	};
	waitUntil { sleep 1; GRLIB_InitialParamsSet };
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
GRLIB_passive_delay = [GRLIB_PARAM_PassiveIncomeDelay] call lrx_getParamValue;
GRLIB_passive_ammount = [GRLIB_PARAM_PassiveIncomeAmmount] call lrx_getParamValue;
GRLIB_resources_multiplier = [GRLIB_PARAM_ResourcesMultiplier] call lrx_getParamValue;
GRLIB_disable_death_chat = [GRLIB_PARAM_DeathChat] call lrx_getParamValue;
GRLIB_mod_west = [GRLIB_PARAM_ModPresetWest] call lrx_getParamValue;
GRLIB_mod_east = [GRLIB_PARAM_ModPresetEast] call lrx_getParamValue;
GRLIB_mod_preset_civ = [GRLIB_PARAM_ModPresetCiv] call lrx_getParamValue;
GRLIB_mod_preset_taxi = [GRLIB_PARAM_ModPresetTaxi] call lrx_getParamValue;
GRLIB_enable_arsenal = [GRLIB_PARAM_EnableArsenal] call lrx_getParamValue;
GRLIB_filter_arsenal = [GRLIB_PARAM_FilterArsenal] call lrx_getParamValue;
GRLIB_forced_loadout = [GRLIB_PARAM_ForcedLoadout] call lrx_getParamValue;
GRLIB_free_loadout = [GRLIB_PARAM_FreeLoadout] call lrx_getParamValue;
GRLIB_opfor_english = 0; //TODO - add this parameter
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
GRLIB_Commander_mode = [GRLIB_PARAM_CommanderModeEnabled] call lrx_getParamValue;
GRLIB_Commander_radius = [GRLIB_PARAM_CommanderModeRadius] call lrx_getParamValue;
GRLIB_MineProbability = [GRLIB_PARAM_MineProbability] call lrx_getParamValue;
GRLIB_AlarmsEnabled = [GRLIB_PARAM_Alarms] call lrx_getParamValue;
GRLIB_Commander_AutoStart = [GRLIB_PARAM_CommanderAutoStart] call lrx_getParamValue;
GRLIB_Commander_VoteTime = [GRLIB_PARAM_CommanderVoteTimeout] call lrx_getParamValue;
GRLIB_Commander_VoteEnabled = [GRLIB_PARAM_CommPlayerVote] call lrx_getParamValue;

// PAR Revive
PAR_revive = ["PAR_Revive"] call lrx_getParamValue;
PAR_AI_reviveMax = ["PAR_AI_Revive"] call lrx_getParamValue;
PAR_bleedout = ["PAR_BleedOut"] call lrx_getParamValue;
PAR_grave = ["PAR_Grave"] call lrx_getParamValue;

// Hardcoded
GRLIB_endgame = 0;
if (isNil "GRLIB_global_stop") then { GRLIB_global_stop = 0 };
GRLIB_min_score_player = 20;				// Minimal player score to be saved
GRLIB_opfor_cap = GRLIB_opforcap * GRLIB_unitcap;		// Maximal number of enemies units
GRLIB_blufor_cap = 50;						// Maximal number of friendly units
GRLIB_max_active_sectors = 4;				// Maximal active sectors at the same time
GRLIB_battlegroup_size = 4;
GRLIB_battlegroup_size = GRLIB_battlegroup_size * GRLIB_unitcap;
GRLIB_civilians_amount = 12;
GRLIB_civilians_amount = GRLIB_civilians_amount * GRLIB_civilian_activity;
GRLIB_patrol_amount = 8;
GRLIB_patrol_amount = GRLIB_patrol_amount * GRLIB_patrols_activity;
GRLIB_secondary_missions_costs = [150, 70, 10, 1000];
GRLIB_defense_costs = [0, 100, 200, 300];
GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";

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
if ( GRLIB_ACE_medical_enabled ) then { PAR_revive = 0; GRLIB_fatigue = 1 };		// Disable PAR/Fatigue if ACE Medical is present
GRLIB_fatigue = (GRLIB_fatigue == 1);
GRLIB_introduction = (GRLIB_introduction == 1);
GRLIB_deployment_cinematic = (GRLIB_deployment_cinematic == 1);
GRLIB_admin_menu = (GRLIB_admin_menu == 1);
GRLIB_hide_opfor = (GRLIB_hide_opfor == 1);
GRLIB_permission_vehicles = (GRLIB_permission_vehicles == 1);
GRLIB_permission_enemy = (GRLIB_permission_enemy == 1);
GRLIB_passive_income = (GRLIB_passive_income == 1);
GRLIB_permissions_param = (GRLIB_permissions_param == 1);
GRLIB_use_whitelist = (GRLIB_use_whitelist == 1);
GRLIB_use_exclusive = (GRLIB_use_exclusive == 1);
GRLIB_opfor_english = (GRLIB_opfor_english == 1);
GRLIB_enable_drones = (GRLIB_enable_drones == 1);
GRLIB_disable_death_chat = (GRLIB_disable_death_chat == 1);
GRLIB_server_persistent = (GRLIB_server_persistent == 1);
GRLIB_air_support = (GRLIB_air_support == 1);
GRLIB_free_loadout = (GRLIB_free_loadout == 1);
GRLIB_Commander_mode = (GRLIB_Commander_mode == 1);
GRLIB_AlarmsEnabled = GRLIB_AlarmsEnabled == 1;
GRLIB_Commander_AutoStart = GRLIB_Commander_AutoStart == 1;
GRLIB_Commander_VoteEnabled = GRLIB_Commander_VoteEnabled == 1;

// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };

// Params loaded
GRLIB_LRX_params_loaded = true;
