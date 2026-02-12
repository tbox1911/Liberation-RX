//--- LRX Server Misson Parameters ----------------------------------------

diag_log "--- LRX: Loading Server settings ---";

GRLIB_endgame = 0;
publicVariable "GRLIB_endgame";

GRLIB_global_stop = 0;
publicVariable "GRLIB_global_stop";

GRLIB_LRX_Template_version = 0;
if (GRLIB_LRX_Template_enabled) then {GRLIB_LRX_Template_version = LRX_Template_version };
publicVariable "GRLIB_LRX_Template_version";

// Mission Parameter constant
[] call compileFinal preprocessFileLineNumbers "scripts\shared\mission_params.sqf";

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

// Save back cleaned params
profileNamespace setVariable [GRLIB_paramsV2_save_key, GRLIB_LRX_params];

// Publish LRX variables (mod + conf)
publicVariable "GRLIB_mod_list_west";
publicVariable "GRLIB_mod_list_east";
publicVariable "GRLIB_mod_list_name";
publicVariable "GRLIB_LRX_params";
sleep 0.5;

if (!GRLIB_ParamsInitialized) then {
	diag_log "--- LRX: Waiting for Admin to configure Mission ---";
	waitUntil { sleep 1; GRLIB_ParamsInitialized };
};

// LRX Selectable
[] call F_readParamsLRX;

A3W_Mission_count = [GRLIB_PARAM_A3WCount] call lrx_getParamValue;
A3W_Mission_delay = [GRLIB_PARAM_A3WDelay] call lrx_getParamValue;
GRLIB_autosave_timer = [GRLIB_PARAM_AutoSave] call lrx_getParamValue;
GRLIB_building_ai_ratio = [GRLIB_PARAM_BuildingRatio] call lrx_getParamValue;
GRLIB_cleanup_vehicles = [GRLIB_PARAM_CleanupVehicles] call lrx_getParamValue;
GRLIB_Commander_AutoStart = [GRLIB_PARAM_CommanderAutoStart] call lrx_getParamValue;
GRLIB_Commander_VoteTime = [GRLIB_PARAM_CommanderVoteTimeout] call lrx_getParamValue;
GRLIB_csat_aggressivity = [GRLIB_PARAM_Aggressivity] call lrx_getParamValue;
GRLIB_day_factor = [GRLIB_PARAM_DayDuration] call lrx_getParamValue;
GRLIB_despawn_tickets = [GRLIB_PARAM_SectorDespawn] call lrx_getParamValue;
GRLIB_difficulty_modifier = [GRLIB_PARAM_Difficulty] call lrx_getParamValue;
GRLIB_hide_opfor = [GRLIB_PARAM_HideOpfor] call lrx_getParamValue;
GRLIB_MineProbability = [GRLIB_PARAM_MineProbability] call lrx_getParamValue;
GRLIB_night_factor = [GRLIB_PARAM_NightDuration] call lrx_getParamValue;
GRLIB_param_wipe_keepcontext = [GRLIB_PARAM_KeepContext] call lrx_getParamValue;
GRLIB_param_wipe_keepscore = [GRLIB_PARAM_KeepScore] call lrx_getParamValue;
GRLIB_passive_ammount = [GRLIB_PARAM_PassiveIncomeAmmount] call lrx_getParamValue;
GRLIB_passive_income = [GRLIB_PARAM_PassiveIncome] call lrx_getParamValue;
GRLIB_server_persistent = [GRLIB_PARAM_Persistent] call lrx_getParamValue;
GRLIB_side_verif = [GRLIB_PARAM_SideVerification] call lrx_getParamValue;
GRLIB_victory_condition = [GRLIB_PARAM_VictoryCondition] call lrx_getParamValue;
GRLIB_vulnerability_timer = [GRLIB_PARAM_VulnerabilityTimer] call lrx_getParamValue;
GRLIB_weather_param = [GRLIB_PARAM_Weather] call lrx_getParamValue;

// Transfom true/false Param
GRLIB_server_persistent = (GRLIB_server_persistent == 1);
GRLIB_Commander_AutoStart = (GRLIB_Commander_AutoStart == 1);
GRLIB_hide_opfor = (GRLIB_hide_opfor == 1);

GRLIB_civilians_amount = GRLIB_civilians_amount * GRLIB_civilian_activity; // Maximal Number of civilians
GRLIB_opfor_cap = GRLIB_opforcap * GRLIB_unitcap;	// Maximal number of enemies units
GRLIB_battlegroup_size = GRLIB_battlegroup_size * GRLIB_unitcap; // Maximal size of enemy battlegroups
GRLIB_patrol_amount = GRLIB_patrol_amount * GRLIB_patrols_activity; // Maximal number of patrols

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

// Publish variables
publicVariable "GRLIB_side_friendly";
publicVariable "GRLIB_side_enemy";
publicVariable "GRLIB_side_civilian";
sleep 1;

// Params loaded
GRLIB_LRX_server_params_loaded = true;
publicVariable "GRLIB_LRX_server_params_loaded";

diag_log "--- LRX: Server settings loaded ---";