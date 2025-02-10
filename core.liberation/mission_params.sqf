// All Liberation RX Mission Parameters here
//
// in LRX_Mission_Params,
//   define parameter name and default value
//
// in LRX_Mission_Params_Def,
//   define parameter full name, list of choice, (optinal) custom value

private _lrx_getParamValue = {
	params ["_name"];
	private _ret = GRLIB_mod_list_name select {_x select 0 == _name} select 0;
	if (isNil "_ret") exitWith {"!! Unknown !!"};
	(_ret select 1);
};

private _lrx_get_mod_template = {
	params ["_mod_list"];
	private _mod_data = [["---"], ["---"]];
	{
		(_mod_data select 0) pushBack ([_x] call _lrx_getParamValue);
		(_mod_data select 1) pushBack _x;
	} foreach _mod_list;
	_mod_data;
};

private _list_west = ([GRLIB_mod_list_west] call _lrx_get_mod_template);
private _list_east = ([GRLIB_mod_list_east] call _lrx_get_mod_template);

LRX_Mission_Params = [
	["---", "GAME"],
	["Introduction", 1],			// Introduction - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["DeploymentCinematic", 1],		// Deployment cimematic - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["Opforcap", 200],				// Maximum Amount Enemy units - [default 200] - values = [100,200,300,400]
	["Unitcap", 1],					// Maximum AI units Modifier - [default 1] - values = [0.5,0.75,1,1.25,1.5,2] - Text {50%,%75,%100,%125,%150,%200}
	["Difficulty", 1],				// Difficulty - [default 1] - values = [0.5,0.75,1,1.25,1.5,2,4,10] - Text {Tourist,Easy,Normal,Moderate,Hard,Extreme,Ludicrous,Oh god oh god we are all going to die}
	["Aggressivity",1],				// CSAT aggression - [default 1] - values = [0.25,0.5,1,2,4] - Text {Anemic,Weak,Normal,Strong,Extreme}
	["VictoryCondition", 0],		// Select the Victory condition - [default 0] - values = [0,1,2,3,4...] -
	["HideOpfor", 1],				// Hide Opfor marker - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["ShowBlufor", 2],				// Hide Blufor marker - [default 1] - values = [0,1,2] - Text {Disabled,"player only",Enabled}
	["Weather", 1],					// Weather - [default 4] - values = [1,2,3,4] - Text {Always Sunny,Random without rain,Random Cloudy,Random}
	["DayDuration", 1],				// Day duration (multiplier) - [default 1] - values = [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	["NightDuration", 1],			// Night duration (multiplier) - [default 1] - values = [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 10, 20, 30, 60]
	["PassiveIncome", 0],			// Replace ammo box spawns with passive income - [default 0] - values = [1,0] - Text {Enabled,Disabled}
	["PassiveIncomeDelay", 1200],	// Passive Income Delay - values = {1200,1800,3600,7200,14400}
	["PassiveIncomeAmmount", 300],	// Passive Income Ammount - values = {100,200,300,400,500,1000,1500}
	["ResourcesMultiplier", 1],		// Resource multiplier - [default 1] - values = [0.25,0.5,0.75,1,1.25,1.5,2,3,5,10,20,50] - Text {x0.25,x0.5,x1,x1.25,x1.5,x2,x3,x5,x10,x20,x50}
	["HaloJump", 1],				// HALO jump - [default 1] - values = [1,5,10,15,20,30,0] - Text {Enabled - no cooldown,Enabled - 5min cooldown,Enabled - 10min cooldown,Enabled - 15min cooldown,Enabled - 20min cooldown,Enabled - 30min cooldown,Disabled}
	["Patrols", 1],					// Patrols Manager - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["Wildlife", 1],				// Wildlife Manager - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["Civilians", 1],				// Cilivilian Manager - [default 1] - values = [0,0.5,1,2] - Text {None,Reduced,Normal,Increased}
	["AirSupport", 1],				// Enable Air Support - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["CivPenalties", 20],			// Enable Civilian Penalty [default 20] - values = [0, 4, 6, 8, 10, 20, 25, 30, 40, 50 }

	["---", "MOD TEMPLATE"],
	["ModPresetWest", "A3_BLU"],	// Select MOD Preset for Friendly - value = computed
	["ModPresetEast", "A3_OPF"],	// Select MOD Preset for Enemy - values = computed
	["ModPresetCiv", 1],			// Select MOD Preset for Civilian - values = "All", "Friendly", "Enemy"
	["ModPresetTaxi", 1],			// Select MOD Preset for Taxi - values = "All", "Friendly", "Enemy", "Disabled"

	["---", "PLAYER"],
	["Fatigue", 0],					// Stamina - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["PAR_Revive", 1],				// PAR revive - [default 1] - values = [0,1,2,3] - Text {Disabled, Everyone can revive, Everyone can revive using Medikit/FAK, Only medics can revive}
	["PAR_AI_Revive", 7],			// PAR AI revive limit - [default 0] - values = [0,3,5,7,10,15,20]
	["PAR_BleedOut", 300],			// PAR revive Bleedout timer - [default 300] - values = [100,200,300,400,500,600]
	["PAR_Grave", 1],				// PAR grave with stuuf in box - [default 1] - values [1,0] - Text {Enabled,Disabled}
	["DeathChat", 0],				// Disable chat/voice if wounded  [default 0] - values = [1,0] - Text {Enabled,Disabled}
	["MaxSpawnPoint", 3],			// Spawn Point limit per player. [default 3] - values = {1,2,3,4}
	["Redeploy", 1],				// Allow Redeploy to all mobile Respawn - [default 1] - values = [0, 1, 2] - Text {Disabled, All, Only FOB}
	["Respawn", 20],				// Cooldown before can player respawn - [default 20] - values = [0,xxx] - Text {Disabled,Enabled}
	["SquadSize", 2],				// AI per squad at startup [default 2]  - values = {0,1,2,3,4,5,6}
	["MaxSquadSize", 5],			// AI recruitment limit per squad [default 5] - values = {0,1,2,3,4,5,6,7,8,9,10}
	["PlatoonView",0],				// UI - Show Platoon Overlay
	["NameTags",0],					// UI - Show player name tags
	["MapMarkers",0],				// UI - Show team mates on map

	["---", "ARSENAL"],
	["EnableArsenal", 1],			// Enable the Arsenal [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["FilterArsenal", 1],			// Arsenal Filter Mode [default 1] - values = [0,1,2,3,4] - Text {Disabled,"Soft","Strict","Strict+MOD",Whitelist only}
	["ForcedLoadout", 1],			// Force player default equipment  [default 0] - values = [0,1,2] - Text {Disabled,Preset1,Preset2}
	["FreeLoadout", 0],				// All equipment is worthless [default 0] - values = [1,0] - Text {Enabled,Disabled}
	["Thermic", 1],					// Enable Thermal Equipment [default 1] - values = [2,1,0] - Text {Enabled,Only at night,Disabled}

	["---", "FOB"],
	["MaxFobs", 3],					// Maximum number of FOBs allowed - [default 26] - values = [3,5,7,10,15,20,26] - Text {3,5,7,10,15,20,26}
	["MaxOutpost", 4],				// Maximum number of FOBs allowed - [default 26] - values = [3,5,7,10,15,20,26] - Text {3,5,7,10,15,20,26}
	["FobType", 0],					// The Startup Fob Vehicle - [default 0] - values = [1,0] - Text {Huron,Truck,Boat}
	["HuronType", 0],				// The type of Huron - [default 0] - values = [0,1,2] - Text {"CH-67 Huron", "CH-49 Mohawk", "UH-80 Ghost Hawk"}
	["NavalFobType", 0],			// The type of Naval FOB - [default 0] - values = [0,1,2] - Text {Disabled, "USS Liberty", "USS Freedom", "Offshare plateform"}

	["---", "MISC"],
	["FancyInfo", 2],				// Enable colorfull, fancy Informations [default 2] - values = [2,1,0] - Text {Enabled,Info,Disabled}
	["EnableLock", 1],				// Enable Vehicles Ownership - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["EnemyLock", 1],				// Lock Enemy Vehicles - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["FuelConso", 1],				// Vehicles fuel Consumption [default 0] - values = [0,0.5,1,1.5,2] - Text {Disabled,Low, Normal, Medium, High}
	["MaxGarageSize", 6],			// Virtual Garage vehicle limit [default 6] - values = {0,1,2,3,4,5,6,7,8,9,10}
	["SectorRadius", 0],			// The size of the sector - [default 0] - values = {0,300,400,500,600,700,800,900,1000,1200,1500};
	["SectorDespawn", 72], 			// Time for a sector to Despawn if no attackers - [default 72] - values = [(3*12), (6*12), (8*12), (12*12), (16*12), (20*12)]
	["BuildingRatio", 1.5],			// AI in Building ratio (CQB) - [default 1] - values = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]

	["---", "RESTART"],
	["KeepScore", 0],				// Keep the Basic Players datas (score/permissions) - [default 0] - values = [0,1] - Text {Disabled,Enabled}
	["KeepContext", 0],				// Keep the Extended Players datas (squad, arsenal, garage) - [default 0] - values = [0,1] - Text {Disabled,Enabled}

	["---", "SYSTEM"],
	["Permissions", 1],				// Permissions management - [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["CleanupVehicles", 1800],		// Cleanup abandoned vehicles outside FOBs - values = {0,900,1800,3600,7200,14400}
	["AutoSave", 1800],				// LRX Game Auto Save Delay - values = {0,900,1800,3600,7200}
	["TFRadioRange", 2000],			// The radius of TFAR relay - [default 5000] - values = {Disabled, 1km, 2km, 3km, 4km, 5km, 10km, 15km};
	["AdminMenu", 1],				// Enable the Admin Cheat Menu [default 1] - values = [1,0] - Text {Enabled,Disabled}
	["RespawnCD", 0],				// Cooldown if player respawn too fast - [default 0] - values = [0,xxx] - Text {Disabled,Enabled}
	["KickIdle", 0],				// Kick player if idle too long - [default 0] - values = {0,900,1200,1800,3600,7200}
	["TK_mode", 1],					// Teamkill Mode [default 0] - values = [0,1,2] - Text {Strict,Relax,Disabled}
	["TK_count", 4],				// Teamkill Warning Count [default 4] - values = [3, 4, 5, 6, 7, 8, 9, 10] - Text {3, 4, 5, 6, 7, 8, 9, 10}
	["Persistent", 0]				// Server start with Persistent Mode - [default 0] - values = [0,1] - Text {Disabled,Enabled}
];

LRX_Mission_Params_Def = [
	["---", "=========", []],
	["ModPresetWest", "MOD Preset Friendly", _list_west select 0, _list_west select 1],
	["ModPresetEast", "MOD Preset Enemy", _list_east select 0, _list_east select 1],
	["ModPresetCiv",  "MOD Preset Civilian", [
		"All",
		"Friendly",
		"Enemy"
		]
	],
	["ModPresetTaxi",  "MOD Preset Taxi", [
		"All",
		"Friendly",
		"Enemy",
		localize "STR_PARAMS_DISABLED"
		]
	],
	["Opforcap", localize "STR_PARAMS_OPFORCAP",
		["100", "200", "300", "400"],
		[100, 200, 300, 400]
	],
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
		localize "STR_AGGRESSIVITY_PARAM0",
		localize "STR_AGGRESSIVITY_PARAM1",
		localize "STR_AGGRESSIVITY_PARAM2",
		localize "STR_AGGRESSIVITY_PARAM3",
		localize "STR_AGGRESSIVITY_PARAM4"
		],
		[0.25, 0.5, 1, 2, 4]
	],
	["SectorRadius", localize "STR_PARAM_SECTOR_RADIUS",
		[format ["AUTO (%1)", GRLIB_sector_size], "300", "400", "600", "800", "1000", "1200", "1500", "2000"],
		[0, 300, 400, 600, 800, 1000, 1200, 1500, 2000]
	],
	["TFRadioRange", localize "STR_PARAM_TFAR_RADIUS",
		[localize "STR_PARAMS_DISABLED", "1 km", "2 km", "3 km", "4 km", "5 km", "7.5 km", "10 km", "15 km"],
		[0, 1000, 2000, 3000, 4000, 5000, 7500, 10000, 15000]
	],
	["DayDuration", localize "STR_PARAMS_DAYDURATION",
		["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "7", "10", "20", "30", "40", "50"],
		[0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 7, 10, 20, 30, 40, 50]
	],
	["NightDuration", localize "STR_PARAMS_NIGHTDURATION",
		["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "7", "10", "20", "30", "40", "50"],
		[0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 7, 10, 20, 30, 40, 50]
	],
	["BuildingRatio", localize "STR_PARAMS_BUILDING_RATIO",
		["0.5", "1", "1.5", "2", "2.5", "3"],
		[0.5, 1, 1.5, 2, 2.5, 3]
	],
	["FuelConso", localize "STR_PARAMS_FUEL_CONSO",
		[localize "STR_PARAMS_DISABLED", "Low", "Normal", "Medium", "High"],
		[0, 0.5, 1, 1.5, 2]
	],
	["FilterArsenal", localize "STR_LIMIT_ARSENAL", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_LIMIT_ARSENAL_PARAM1",
		localize "STR_LIMIT_ARSENAL_PARAM2",
		localize "STR_LIMIT_ARSENAL_PARAM3",
		localize "STR_LIMIT_ARSENAL_PARAM4",
		localize "STR_LIMIT_ARSENAL_PARAM5"
		]
	],
	["Weather", localize "STR_WEATHER_PARAM", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_WEATHER_PARAM1",
		localize "STR_WEATHER_PARAM2",
		localize "STR_WEATHER_PARAM3",
		localize "STR_WEATHER_PARAM4"
		]
	],
	["VictoryCondition", localize "STR_VICTORY_CONDITION", [
		localize "STR_VICTORY_COND0",
		localize "STR_VICTORY_COND1",
		localize "STR_VICTORY_COND2",
		localize "STR_VICTORY_COND3",
		localize "STR_VICTORY_COND4",
		localize "STR_VICTORY_COND5",
		localize "STR_VICTORY_COND6",
		localize "STR_VICTORY_COND7",
		localize "STR_VICTORY_COND8",
		localize "STR_VICTORY_COND9",
		localize "STR_VICTORY_CONDA"
		]
	],
	["ResourcesMultiplier", localize "STR_PARAMS_RESOURCESMULTIPLIER",
		["x0.25", "x0.5", "x0.75", "x1", "x1.25","x1.5","x2","x3","x5","x10","x20","x50"],
		[0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3, 5, 10, 20, 50]
	],
	["PAR_Revive", localize "STR_PARAMS_PAR_REVIVE", [
		localize "STR_PARAMS_DISABLED",
		localize "STR_PARAMS_REVIVE1",
		localize "STR_PARAMS_REVIVE2",
		localize "STR_PARAMS_REVIVE3"
		]
	],
	["PAR_AI_Revive", localize "STR_PARAMS_PAR_AI_REVIVE",
		["Unlimited", "3", "5", "7", "10", "15", "20"],
		[0, 3, 5, 7, 10, 15, 20]
	],
	["PAR_BleedOut", localize "STR_PARAMS_PAR_BLEEDOUT",
		["100", "200", "300", "400", "500", "600"],
		[100, 200, 300, 400, 500, 600]
	],
	["PAR_Grave", localize "STR_PARAMS_PAR_GRAVE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],

	["Respawn", localize "STR_RESPAWN",
		["5", "10", "20", "25", "30", "60"],
		[5, 10, 20, 25, 30, 60]
	],
	["RespawnCD", localize "STR_RESPAWN_CD",
		[localize "STR_PARAMS_DISABLED", "4", "5", "6", "7", "8", "9", "10"],
		[0, 240, 300, 360, 420, 480, 540, 600]
	],
	["TK_count", localize "STR_TK_COUNT",
		["3", "4", "5", "6", "7", "8", "9", "10"],
		[3, 4, 5, 6, 7, 8, 9, 10]
	],
	["CivPenalties", localize "STR_CIV_PENALTIES",
		[localize "STR_PARAMS_DISABLED", "4", "6", "8", "10", "20", "25", "30", "40", "50"],
		[0, 4, 6, 8, 10, 20, 25, 30, 40, 50]
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
	["MaxFobs", localize "STR_PARAM_FOBS_COUNT",
		["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	],
	["MaxOutpost", localize "STR_PARAM_OUTPOST_COUNT",
		["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	],
	["SquadSize", localize "STR_PARAM_SQUAD_SIZE_START",
		["0", "1", "2", "3", "4", "5", "6"]
	],
	["MaxSquadSize", localize "STR_PARAM_SQUAD_SIZE",
		["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	],
	["MaxGarageSize", localize "STR_PARAM_GARAGE_SIZE",
		["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	],
	["MaxSpawnPoint", localize "STR_PARAM_SPAWN_MAX",
		["1", "2", "3", "4", "5", "6"]
	],
	["SectorDespawn", localize "STR_PARAM_SECTOR_DESPAWN",
		["3", "6", "8", "12", "16", "20"],
		[(3*12), (6*12), (8*12), (12*12), (16*12), (20*12)]
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

	["FobType", localize "STR_PARAM_FOB_TYPE", ["Huron", "Truck", "Boat"]],
	["PlatoonView",localize "STR_GUI_PLATOON", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["NameTags",localize "STR_GUI_NAMETAG", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["MapMarkers",localize "STR_GUI_TEAM", [localize "STR_PARAMS_USER_DEF",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_DISABLED"]],
	["HuronType", localize "STR_PARAM_HURON_TYPE", ["CH-67 Huron","CH-49 Mohawk","UH-80 Ghost Hawk"]],
	["NavalFobType", localize "STR_PARAM_NAVAL_TYPE", [localize "STR_PARAMS_DISABLED","USS Liberty","USS Freedom","Offshore Plateform"]],
	["TK_mode", localize "STR_TK_MODE", [localize "STR_PARAMS_DISABLED",localize "STR_TK_MODE_RELAX",localize "STR_TK_MODE_STRICT"]],
	["DeploymentCinematic", localize "STR_PARAMS_DEPLOYMENTCAMERA", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Introduction", localize "STR_PARAMS_INTRO", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Fatigue", localize "STR_PARAMS_FATIGUE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Permissions", localize "STR_PERMISSIONS_PARAM", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Wildlife", localize "STR_PARAM_WILDLIFE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["PassiveIncome", localize "STR_PARAM_PASSIVE_INCOME", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Thermic", localize "STR_THERMAL", [localize "STR_PARAMS_DISABLED","Only at night",localize "STR_PARAMS_ENABLED"]],
	["EnableArsenal", localize "STR_ARSENAL", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED",localize "STR_PARAMS_ARSENAL_FOB"]],
	["EnableLock", localize "STR_VEH_LOCK", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["EnemyLock", localize "STR_OPFOR_VEH_LOCK", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["AdminMenu", "Enable the Admin Menu", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["HideOpfor", localize "STR_OPFORMARK", ["All","Fog of War"]],
	["ShowBlufor", localize "STR_BLUFORMARK", [localize "STR_PARAMS_DISABLED","Player only",localize "STR_PARAMS_ENABLED"]],
	["ForcedLoadout", localize "STR_FORCE_LOADOUT", [localize "STR_PARAMS_DISABLED","Preset 1","Preset 2"]],
	["FreeLoadout", localize "STR_FREE_LOADOUT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["DeathChat", localize "STR_DEATHCHAT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["FancyInfo", localize "STR_FANCY", [localize "STR_PARAMS_DISABLED","Info",localize "STR_PARAMS_ENABLED"]],
	["AirSupport", localize "STR_ENABLE_AIR_SUPPORT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Redeploy", localize "STR_REDEPLOY", [localize "STR_PARAMS_DISABLED", localize "STR_PARAM_REDEPLOY_ALL", localize "STR_PARAM_REDEPLOY_FOB"]],
	["KeepScore", localize "STR_KEEP_SCORE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["KeepContext", localize "STR_KEEP_CONTEXT", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]],
	["Persistent", localize "STR_PERSISTENT_MODE", [localize "STR_PARAMS_DISABLED",localize "STR_PARAMS_ENABLED"]]
];
