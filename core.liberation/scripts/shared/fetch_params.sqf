if ( isMultiplayer ) then {
	GRLIB_difficulty_modifier = ["Difficulty",1] call bis_fnc_getParamValue;
	GRLIB_time_factor = ["DayDuration",1] call bis_fnc_getParamValue;
	GRLIB_resources_multiplier = ["ResourcesMultiplier",1] call bis_fnc_getParamValue;
	GRLIB_fatigue = ["Fatigue",0] call bis_fnc_getParamValue;
	GRLIB_revive = ["Revive",2] call bis_fnc_getParamValue;
	GRLIB_tk_mode = ["TK_mode",0] call bis_fnc_getParamValue;
	GRLIB_tk_count = ["TK_count",4] call bis_fnc_getParamValue;
	GRLIB_introduction = ["Introduction",1] call bis_fnc_getParamValue;
	GRLIB_deployment_cinematic = ["DeploymentCinematic",1] call bis_fnc_getParamValue;
	GRLIB_unitcap = ["Unitcap",1] call bis_fnc_getParamValue;
	GRLIB_adaptive_opfor = ["AdaptToPlayercount",1] call bis_fnc_getParamValue;
	GRLIB_civilian_activity = ["Civilians",1] call bis_fnc_getParamValue;
	GRLIB_wildlife_manager = ["Wildlife",1] call bis_fnc_getParamValue;
	GRLIB_admin_menu = ["AdminMenu",1] call bis_fnc_getParamValue;
	GRLIB_param_wipe_savegame_1 = ["WipeSave1",0] call bis_fnc_getParamValue;
	GRLIB_param_wipe_savegame_2 = ["WipeSave2",0] call bis_fnc_getParamValue;
	GRLIB_passive_income = ["PassiveIncome",0] call bis_fnc_getParamValue;
	GRLIB_permissions_param = ["Permissions",1] call bis_fnc_getParamValue;
	GRLIB_halo_param = ["HaloJump",1] call bis_fnc_getParamValue;
	GRLIB_use_whitelist = ["Whitelist",0] call bis_fnc_getParamValue;
	GRLIB_cleanup_vehicles = ["CleanupVehicles",2] call bis_fnc_getParamValue;
	GRLIB_csat_aggressivity = ["Aggressivity",1] call bis_fnc_getParamValue;
	GRLIB_weather_param = ["Weather",4] call bis_fnc_getParamValue;
	GRLIB_shorter_nights = ["ShorterNights",1] call bis_fnc_getParamValue;
	GRLIB_ammo_bounties = [ "AmmoBounties",0] call bis_fnc_getParamValue;
	GRLIB_civ_penalties = [ "CivPenalties",0] call bis_fnc_getParamValue;
	GRLIB_remote_sensors = [ "DisableRemoteSensors",0] call bis_fnc_getParamValue;
	GRLIB_blufor_defenders = [ "BluforDefenders",1] call bis_fnc_getParamValue;
	GRLIB_autodanger = [ "Autodanger",0] call bis_fnc_getParamValue;
	GRLIB_maximum_fobs = [ "MaximumFobs",5] call bis_fnc_getParamValue;
	GRLIB_fob_type = [ "FobType",0] call bis_fnc_getParamValue;
	GRLIB_squad_size = ["SquadSize",3] call bis_fnc_getParamValue;
	GRLIB_max_squad_size = ["MaxSquadSize",7] call bis_fnc_getParamValue;
	GRLIB_enable_arsenal = ["EnableArsenal",1] call bis_fnc_getParamValue;
	GRLIB_limited_arsenal = ["LimitedArsenal",1] call bis_fnc_getParamValue;
	GRLIB_forced_loadout = ["ForcedLoadout",0] call bis_fnc_getParamValue;
	GRLIB_fancy_info = ["FancyInfo",1] call bis_fnc_getParamValue;
	GRLIB_hide_opfor = ["HideOpfor",0] call bis_fnc_getParamValue;
	GRLIB_thermic = ["Thermic",1] call bis_fnc_getParamValue;
} else {
	GRLIB_difficulty_modifier = 1;
	GRLIB_time_factor = 1;
	GRLIB_resources_multiplier = 1;
	GRLIB_fatigue = 0;
	GRLIB_revive = 2;
	GRLIB_tk_mode = 0;
	GRLIB_tk_count = 4;
	GRLIB_introduction = 0;
	GRLIB_deployment_cinematic = 0;
	GRLIB_adaptive_opfor = 1;
	GRLIB_unitcap = 1;
	GRLIB_civilian_activity = 1;
	GRLIB_wildlife_manager = 1;
	GRLIB_admin_menu = 1;
	GRLIB_param_wipe_savegame_1 = 0;
	GRLIB_param_wipe_savegame_2 = 0;
	GRLIB_passive_income = 0;
	GRLIB_permissions_param = 1;
	GRLIB_halo_param = 1;
	GRLIB_use_whitelist = 0;
	GRLIB_cleanup_vehicles = 2;
	GRLIB_csat_aggressivity = 1;
	GRLIB_weather_param = 4;
	GRLIB_shorter_nights = 1;
	GRLIB_ammo_bounties = 1;
	GRLIB_civ_penalties = 1;
	GRLIB_remote_sensors = 0;
	GRLIB_blufor_defenders = 1;
	GRLIB_autodanger = 0;
	GRLIB_maximum_fobs = 5;
	GRLIB_fob_type = 0;
	GRLIB_squad_size = 3;
	GRLIB_max_squad_size = 10;
	GRLIB_enable_arsenal = 1;
	GRLIB_limited_arsenal = 1;
	GRLIB_forced_loadout = 0;
	GRLIB_fancy_info = 2;
	GRLIB_hide_opfor = 0;
	GRLIB_thermic = 1;
};

GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";

//Detect Addons ACE ACRE OPTRE GM
GRLIB_ACE_enabled = isClass(configFile >> "cfgPatches" >> "ace_main"); // Returns true if ACE is enabled
GRLIB_ACRE_enabled = isClass(configFile >> "cfgPatches" >> "acre_main"); // Returns true if ACRE is enabled
GRLIB_OPTRE_enabled = isClass(configFile >> "cfgPatches" >> "OPTRE_Core"); // Returns true if OPTRE is enabled
GRLIB_GM_enabled = isClass(configFile >> "cfgPatches" >> "gm_Core"); // Returns true if GlobMob is enabled
GRLIB_CUPW_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Weapons_AK"); // Returns true if CUP Weapons is enabled

if ( GRLIB_ACE_enabled ) then {	GRLIB_revive = 0; GRLIB_fatigue = 1; GRLIB_fancy_info = 0; GRLIB_limited_arsenal = 0 };  // Disable PAR/Fatigue/Fancy if ACE present
if ( GRLIB_OPTRE_enabled ) then { GRLIB_MOD_signature = "OPTRE_" };
if ( GRLIB_GM_enabled ) then { GRLIB_MOD_signature = "gm_" };

if ( GRLIB_fatigue == 1 ) then { GRLIB_fatigue = true } else { GRLIB_fatigue = false };
if ( GRLIB_introduction == 1 ) then { GRLIB_introduction = true } else { GRLIB_introduction = false };
if ( GRLIB_deployment_cinematic == 1 ) then { GRLIB_deployment_cinematic = true } else { GRLIB_deployment_cinematic = false };
if ( GRLIB_admin_menu == 1 ) then { GRLIB_admin_menu = true } else { GRLIB_admin_menu = false };
if ( GRLIB_hide_opfor == 1 ) then { GRLIB_hide_opfor = true } else { GRLIB_hide_opfor = false };
if ( GRLIB_enable_arsenal == 1 ) then { GRLIB_enable_arsenal = true } else { GRLIB_enable_arsenal = false };
if ( GRLIB_limited_arsenal == 1 ) then { GRLIB_limited_arsenal = true } else { GRLIB_limited_arsenal = false };
if ( GRLIB_adaptive_opfor == 1 ) then { GRLIB_adaptive_opfor = true } else { GRLIB_adaptive_opfor = false };
if ( GRLIB_passive_income == 1 ) then { GRLIB_passive_income = true } else { GRLIB_passive_income = false };
if ( GRLIB_permissions_param == 1 ) then { GRLIB_permissions_param = true } else { GRLIB_permissions_param = false };
if ( GRLIB_use_whitelist == 1 ) then { GRLIB_use_whitelist = true } else { GRLIB_use_whitelist = false };
if ( GRLIB_shorter_nights == 1 ) then { GRLIB_shorter_nights = true } else { GRLIB_shorter_nights = false };
if ( GRLIB_ammo_bounties == 1 ) then { GRLIB_ammo_bounties = true } else { GRLIB_ammo_bounties = false };
if ( GRLIB_civ_penalties == 1 ) then { GRLIB_civ_penalties = true } else { GRLIB_civ_penalties = false };
if ( GRLIB_blufor_defenders == 1 ) then { GRLIB_blufor_defenders = true } else { GRLIB_blufor_defenders = false };
if ( GRLIB_autodanger == 1 ) then { GRLIB_autodanger = true } else { GRLIB_autodanger = false };
if ( GRLIB_thermic == 1 ) then { GRLIB_thermic = true } else { GRLIB_thermic = false };