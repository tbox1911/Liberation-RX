// All Liberation RX Mission Parameters here
//
// in LRX_Mission_Params, 
//   define parameter name and default value 
//
// in LRX_Mission_Params_Def,
//   define parameter full name, list of choice, (optinal) custom value

private _lrx_getParamValue = {
	params ["_param"];
	_def = "Unknown!";
	{
		if (_x select 0 == _param) exitWith { _def = _x select 1 };
	} forEach GRLIB_mod_list_name;
	_def;
};

private _list_west = [];
{ 
  _list_west pushback ([_x] call _lrx_getParamValue); 
} foreach GRLIB_mod_list_west; 

private _list_east = [];
{ 
  _list_east pushback ([_x] call _lrx_getParamValue); 
} foreach GRLIB_mod_list_east; 

LRX_Mission_Params = [
	["Introduction", 1],			// Introduction - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["DeploymentCinematic", 1],		// Deployment cimematic - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["PlatoonView",0],				// UI - Show Platoon Overlay
	["NameTags",0],					// UI - Show player name tags
	["MapMarkers",0],				// UI - Show team mates on map
	["Unitcap", 1],					// Maximum amount AI units - [default 1] - values = [0.5,0.75,1,1.25,1.5,2] - Text {50%,%75,%100,%125,%150,%200}
	["Difficulty", 1],				// Difficulty - [default 1] - values = [0.5,0.75,1,1.25,1.5,2,4,10] - Text {Tourist,Easy,Normal,Moderate,Hard,Extreme,Ludicrous,Oh god oh god we are all going to die}
	["Aggressivity",1],				// CSAT aggression - [default 1] - values = [0.25,0.5,1,2,4] - Text {Anemic,Weak,Normal,Strong,Extreme}
	["AdaptToPlayercount", 1],		// Hostile presence adapts to player count - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["SectorRadius", 0],			// The size of the sector - [default 0] - values = {0,300,400,500,600,700,800,900,1000,1200,1500};
	["DayDuration", 1],				// Day duration (multiplier) - [default 1] - values = [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	["NightDuration", 1],			// Night duration (multiplier) - [default 1] - values = [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	["Thermic", 1],					// Enable Thermal Equipment [default 1] - values = [2,1,0] - Text {Enabled,Only at night,Disabled}
	["EnableArsenal", 1],			// Enable the Arsenal [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["FilterArsenal", 1],			// Arsenal Filter Mode [default 1] - values = [0,1,2,3,4] - Text {Disabled,"Soft","Strict","Strict+MOD",Whitelist only}
	["ModPresetWest", 0],			// Select MOD Preset for Friendly side - value =  { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25 } Text = "A3_BLU", "A3_OPF",  etc...
	["ModPresetEast", 0],			// Select MOD Preset for Enemy side - values = { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25 } text "A3_OPF", "A3_BLU", "A3_IND",  etc...
	["Weather", 1],					// Weather - [default 4] - values = [1,2,3,4] - Text {Always Sunny,Random without rain,Random Cloudy,Random}
	["ResourcesMultiplier", 1],		// Resource multiplier - [default 1] - values = [0.25,0.5,0.75,1,1.25,1.5,2,3,5,10,20,50] - Text {x0.25,x0.5,x1,x1.25,x1.5,x2,x3,x5,x10,x20,x50}
	["Fatigue", 0],					// Stamina - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["Revive", 3],					// PAR revive - [default 3] - values = [3,2,1,0] - Text {Enabled - Everyone can revive,Enabled - Everyone can revive using Medikit/FAK,Enabled - Only medics can revive,Disabled}
	["TK_mode", 1],					// Teamkill Mode [default 0] - values = [0,1,2] - Text {Strict,Relax,Disabled}
	["TK_count", 4],				// Teamkill Warning Count [default 4] - values = [3, 4, 5, 6, 7, 8, 9, 10] - Text {3, 4, 5, 6, 7, 8, 9, 10}
	["Civilians", 1],				// Cilivilian activity - [default 1] - values = [0,0.5,1,2] - Text {None,Reduced,Normal,Increased}
	["Patrols", 1],					// Cilivilian activity - [default 1] - values = [0,0.5,1,2] - Text {None,Reduced,Normal,Increased}	
	["Wildlife", 1],				// Wildlife Manager - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["PassiveIncome", 0],			// Replace ammo box spawns with passive income - [default 0] - values = [1,0] - Text {Enabled,Disabled}
	["PassiveIncomeDelay", 1200],	// Passive Income Delay - values = {1200,1800,3600,7200,14400}
	["PassiveIncomeAmmount", 300],	// Passive Income Ammount - values = {100,200,300,400,500,1000,1500}
	["HaloJump", 1],				// HALO jump - [default 1] - values = [1,5,10,15,20,30,0] - Text {Enabled - no cooldown,Enabled - 5min cooldown,Enabled - 10min cooldown,Enabled - 15min cooldown,Enabled - 20min cooldown,Enabled - 30min cooldown,Disabled}
	["BluforDefenders", 1],			// BLUFOR defenders in owned sectors - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["MaximumFobs", 5],				// Maximum number of FOBs allowed - [default 26] - values = [3,5,7,10,15,20,26] - Text {3,5,7,10,15,20,26}
	["FobType", 0],					// The Startup Fob Vehicle - [default 0] - values = [1,0] - Text {Huron,Truck}
	["HuronType", 0],				// The type of Huron - [default 0] - values = [0,1,2,3] - Text {Disabled, "CH-67 Huron", "CH-49 Mohawk", "UH-80 Ghost Hawk"}
	["SquadSize", 2],				// AI per squad at startup [default 2]  - values = {0,1,2,3,4,5,6}
	["MaxSquadSize", 7],			// AI recruitment limit per squad [default 7] - values = {0,1,2,3,4,5,6,7}
	["MaxSpawnPoint", 3],			// Spawn Point limit per player. [default 3] - values = {1,2,3,4}
	["Permissions", 1],				// Permissions management - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["EnableLock", 1],				// Enable Vehicles Ownership - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["CleanupVehicles", 1800],		// Cleanup abandoned vehicles outside FOBs - values = {0,900,1800,3600,7200,14400}
	["AutoSave", 1800],				// LRX Game Auto Save Delay - values = {0,900,1800,3600,7200}
	["AdminMenu", 1],				// Enable the Admin Cheat Menu [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["HideOpfor", 1],				// Hide Opfor marker - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["ShowBlufor", 2],				// Hide Blufor marker - [default 1] - values = [0,1,2] - Text {Disabled,"player only",Enabled}
	["ForcedLoadout", 1],			// Force player default equipment  [default 0] - values = [0,1,2] - Text {Disabled,Preset1,Preset2}
	["DeathChat", 0],				// Disable chat/voice if wounded  [default 0] - values = [1,0] - Text {Enabled,Disabled}
	["FancyInfo", 1],				// Enable colorfull, fancy Informations [default 2] - values = [2,1,0] - Text {Enabled,Info,Disabled}
	["KeepScore", 0],				// Keep the Players datas (score/permissions) - [default 0] - values = [0,1] - Text {Disabled,Enabled}
	["RespawnCD", 0],				// Cooldown if player respawn too fast - [default 0] - values = [0,1] - Text {Disabled,Enabled}
	["KickIdle", 0],				// Kick player if idle too long - [default 0] - values = {0,900,1200,1800,3600,7200}
	["Persistent", 0]				// Server start with Persistent Mode - [default 0] - values = [0,1] - Text {Disabled,Enabled}
];

LRX_Mission_Params_Def = [
	["ModPresetWest", "MOD Preset - Friendly", _list_west],
	["ModPresetEast", "MOD Preset - Enemy", _list_east],
	["Unitcap", localize "STR_PARAMS_UNITCAP", [
		localize "STR_PARAMS_UNITCAP1",
		localize "STR_PARAMS_UNITCAP2",
		localize "STR_PARAMS_UNITCAP3",
		localize "STR_PARAMS_UNITCAP4",
		localize "STR_PARAMS_UNITCAP5",
		localize "STR_PARAMS_UNITCAP6"
		],
		[0.5, 0.75, 1, 1.25, 1.5, 2]
	],
	["Difficulty", localize "STR_PARAMS_DIFFICULTY", [
		localize "STR_PARAMS_DIFFICULTY1",
		localize "STR_PARAMS_DIFFICULTY2",
		localize "STR_PARAMS_DIFFICULTY3",
		localize "STR_PARAMS_DIFFICULTY4",
		localize "STR_PARAMS_DIFFICULTY5",
		localize "STR_PARAMS_DIFFICULTY6",
		localize "STR_PARAMS_DIFFICULTY7",
		localize "STR_PARAMS_DIFFICULTY8"
		],
		[0.5, 0.75, 1, 1.25, 1.5, 2, 4, 10]
	],
	["Aggressivity", localize "STR_AGGRESSIVITY_PARAM", [
		localize "STR_AGGRESSIVITY_PARAM1",
		localize "STR_AGGRESSIVITY_PARAM2",
		localize "STR_AGGRESSIVITY_PARAM3",
		localize "STR_AGGRESSIVITY_PARAM4"
		],
		[0.25, 0.5, 1, 2, 4]
	],
	["SectorRadius", localize "STR_PARAM_SECTOR_RADIUS",
		[localize "STR_PARAMS_DISABLED", "300", "400", "600", "800", "1000", "1200", "1500"],
		[0, 300, 400, 600, 800, 1000, 1200, 1500]
	],
	["DayDuration", localize "STR_PARAMS_DAYDURATION", 
		["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "10", "20", "30", "60"],
		[0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	],
	["NightDuration", localize "STR_PARAMS_NIGHTDURATION",
		["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "10", "20", "30", "60"],
		[0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	],
	["FilterArsenal", localize "STR_LIMIT_ARSENAL", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_LIMIT_ARSENAL_PARAM1",
		localize "STR_LIMIT_ARSENAL_PARAM2",
		localize "STR_LIMIT_ARSENAL_PARAM3",
		localize "STR_LIMIT_ARSENAL_PARAM4"
		]
	],
	["Weather", localize "STR_WEATHER_PARAM", [
		localize "STR_WEATHER_PARAM1",
		localize "STR_WEATHER_PARAM2",
		localize "STR_WEATHER_PARAM3",
		localize "STR_WEATHER_PARAM4",
		localize "STR_WEATHER_PARAM5"
		]
	],
	["ResourcesMultiplier", localize "STR_PARAMS_RESOURCESMULTIPLIER",
		["x0.25", "x0.5", "x0.75", "x1", "x1.25","x1.5","x2","x3","x5","x10","x20","x50"],
		[0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3, 5, 10, 20, 50]
	],
	["Revive", localize "STR_PARAMS_REVIVE", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_PARAMS_REVIVE1",
		localize "STR_PARAMS_REVIVE2",
		localize "STR_PARAMS_REVIVE3"
		]
	],
	["TK_count", localize "STR_TK_COUNT",
		["3", "4", "5", "6", "7", "8", "9", "10"],
		[3, 4, 5, 6, 7, 8, 9, 10]
	],
	["Civilians", localize "STR_PARAMS_CIVILIANS", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_PARAMS_CIVILIANS1",
		localize "STR_PARAMS_CIVILIANS2",
		localize "STR_PARAMS_CIVILIANS3"
		],
		[0, 0.5, 1, 2]
	],
	["Patrols", localize "STR_PARAMS_PATROLS", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_PARAMS_CIVILIANS1",
		localize "STR_PARAMS_CIVILIANS2",
		localize "STR_PARAMS_CIVILIANS3"
		],
		[0, 0.5, 1, 2]
	],	
	["HaloJump", localize "STR_HALO_PARAM", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_HALO_PARAM1",
		localize "STR_HALO_PARAM2",
		localize "STR_HALO_PARAM3",
		localize "STR_HALO_PARAM4",
		localize "STR_HALO_PARAM5",
		localize "STR_HALO_PARAM6"
		],
		[0, 1, 5, 10, 15, 20, 30]
	],
	["MaximumFobs", localize "STR_PARAM_FOBS_COUNT",
		["3", "5", "7", "10", "15", "20"],
		[3, 5, 7, 10, 15, 20]
	],
	["SquadSize", localize "STR_PARAM_SQUAD_SIZE_START",
		["0", "1", "2", "3", "4", "5", "6"]
	],
	["MaxSquadSize", localize "STR_PARAM_SQUAD_SIZE",
		["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	],
	["MaxSpawnPoint", localize "STR_PARAM_SPAWN_MAX",
		["1", "2", "3", "4", "5", "6"],
		[1, 2, 3, 4, 5, 6]
	],
	["CleanupVehicles", localize "STR_CLEANUP_PARAM", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_CLEANUP_PARAM1",
		localize "STR_CLEANUP_PARAM2",
		localize "STR_CLEANUP_PARAM3",
		localize "STR_CLEANUP_PARAM4",
		localize "STR_CLEANUP_PARAM5"		
		],
		[0, 900, 1200, 1800, 3600, 7200]
	],
	["AutoSave", localize "STR_AUTO_SAVE", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_CLEANUP_PARAM1",
		localize "STR_CLEANUP_PARAM2",
		localize "STR_CLEANUP_PARAM3",
		localize "STR_CLEANUP_PARAM4",
		localize "STR_CLEANUP_PARAM5"		
		],
		[0, 900, 1200, 1800, 3600, 7200]
	],

	["PassiveIncomeDelay", localize "STR_PARAM_PASSIVE_INCOME_DELAY", [
		localize "STR_CLEANUP_PARAM2",
		localize "STR_CLEANUP_PARAM3",
		localize "STR_CLEANUP_PARAM4",
		localize "STR_CLEANUP_PARAM5"
		],
		[1200, 1800, 3600, 7200]
	],

	["PassiveIncomeAmmount", localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT",
		["100", "200", "300", "400", "500", "1000", "1500"],
		[100, 200, 300, 400, 500, 1000, 1500]
	],

	["KickIdle", localize "STR_KICK_IDLE", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_CLEANUP_PARAM1",
		localize "STR_CLEANUP_PARAM2",
		localize "STR_CLEANUP_PARAM3",
		localize "STR_CLEANUP_PARAM4",
		localize "STR_CLEANUP_PARAM5"		
		],
		[0, 900, 1200, 1800, 3600, 7200]
	],

	["FobType", localize "STR_PARAM_FOB_TYPE", ["Huron", "Truck"]],
	["PlatoonView",localize "STR_GUI_PLATOON", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["NameTags",localize "STR_GUI_NAMETAG", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["MapMarkers",localize "STR_GUI_TEAM", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["HuronType", localize "STR_PARAM_HURON_TYPE", [localize "STR_PARAMS_DISABLED","CH-67 Huron","CH-49 Mohawk","UH-80 Ghost Hawk"]],
	["TK_mode", localize "STR_TK_MODE", [localize "STR_PARAMS_DISABLED",localize "STR_TK_MODE_RELAX",localize "STR_TK_MODE_STRICT"]],	
	["DeploymentCinematic", localize "STR_PARAMS_DEPLOYMENTCAMERA", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["AdaptToPlayercount", localize "STR_PARAM_ADAPT_TO_PLAYERCOUNT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["BluforDefenders", localize "STR_PARAM_BLUFOR_DEFENDERS", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Introduction", localize "STR_PARAMS_INTRO", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Fatigue", localize "STR_PARAMS_FATIGUE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Permissions", localize "STR_PERMISSIONS_PARAM", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Wildlife", localize "STR_PARAM_WILDLIFE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["PassiveIncome", localize "STR_PARAM_PASSIVE_INCOME", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Thermic", localize "STR_THERMAL", [localize "STR_PARAMS_DISABLED","Only at night",localize "STR_PARAMS_ENABLED"]],
	["EnableArsenal", localize "STR_ARSENAL", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],	
	["EnableLock", localize "STR_VEH_LOCK", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],	
	["AdminMenu", "Enable the Admin Menu", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["HideOpfor", localize "STR_OPFORMARK", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["ShowBlufor", localize "STR_BLUFORMARK", [localize "STR_PARAMS_DISABLED","Player only",localize "STR_PARAMS_ENABLED"]],
	["ForcedLoadout", localize "STR_FORCE_LOADOUT", [localize "STR_PARAMS_DISABLED","Preset 1","Preset 2"]],
	["DeathChat", localize "STR_DEATHCHAT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["FancyInfo", localize "STR_FANCY", [localize "STR_PARAMS_DISABLED","Info",localize "STR_PARAMS_ENABLED"]],
	["RespawnCD", localize "STR_RESPAWN_CD", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["KeepScore", localize "STR_KEEP_SCORE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Persistent", localize "STR_PERSISTENT_MODE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]]
];
