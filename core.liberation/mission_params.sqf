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
	params ["_mod_list", "_side"];
	private _mod_data = [["---"], ["---"]];
	{
        _faction = _x;
        // Filter available factions to ones that can actually be used
        if ([_x, _side] call GRLIB_Template_Modloaded) then {
            (_mod_data select 0) pushBack ([_faction] call _lrx_getParamValue);
            (_mod_data select 1) pushBack _faction;
        };
	} foreach _mod_list;
	_mod_data;
};

private _list_west = ([GRLIB_mod_list_west, "west"] call _lrx_get_mod_template);
private _list_east = ([GRLIB_mod_list_east, "east"] call _lrx_get_mod_template);

GRLIB_PARAM_separatorKey = "---";

// Parameter key mapping
GRLIB_PARAM_introductionKey = "Introduction";
GRLIB_PARAM_DeploymentCinematic = "DeploymentCinematic";
GRLIB_PARAM_Opforcap = "Opforcap";
GRLIB_PARAM_Unitcap = "Unitcap";
GRLIB_PARAM_Difficulty = "Difficulty";
GRLIB_PARAM_Aggressivity = "Aggressivity";
GRLIB_PARAM_VictoryCondition = "VictoryCondition";
GRLIB_PARAM_HideOpfor = "HideOpfor";
GRLIB_PARAM_ShowBlufor = "ShowBlufor";
GRLIB_PARAM_Weather = "Weather";
GRLIB_PARAM_DayDuration = "DayDuration";
GRLIB_PARAM_NightDuration = "NightDuration";
GRLIB_PARAM_PassiveIncome = "PassiveIncome";
GRLIB_PARAM_PassiveIncomeDelay = "PassiveIncomeDelay";
GRLIB_PARAM_PassiveIncomeAmmount = "PassiveIncomeAmmount";
GRLIB_PARAM_ResourcesMultiplier = "ResourcesMultiplier";
GRLIB_PARAM_HaloJump = "HaloJump";
GRLIB_PARAM_Patrols = "Patrols";
GRLIB_PARAM_Wildlife = "Wildlife";
GRLIB_PARAM_Civilians = "Civilians";
GRLIB_PARAM_AirSupport = "AirSupport";
GRLIB_PARAM_CivPenalties = "CivPenalties";
GRLIB_PARAM_ModPresetWest = "ModPresetWest";
GRLIB_PARAM_ModPresetEast = "ModPresetEast";
GRLIB_PARAM_ModPresetCiv = "ModPresetCiv";
GRLIB_PARAM_ModPresetTaxi = "ModPresetTaxi";
GRLIB_PARAM_Fatigue = "Fatigue";
GRLIB_PARAM_PAR_Revive = "PAR_Revive";
GRLIB_PARAM_PAR_AI_Revive = "PAR_AI_Revive";
GRLIB_PARAM_PAR_BleedOut = "PAR_BleedOut";
GRLIB_PARAM_PAR_Grave = "PAR_Grave";
GRLIB_PARAM_DeathChat = "DeathChat";
GRLIB_PARAM_MaxSpawnPoint = "MaxSpawnPoint";
GRLIB_PARAM_Redeploy = "Redeploy";
GRLIB_PARAM_Respawn = "Respawn";
GRLIB_PARAM_SquadSize = "SquadSize";
GRLIB_PARAM_MaxSquadSize = "MaxSquadSize";
GRLIB_PARAM_PlatoonView = "PlatoonView";
GRLIB_PARAM_NameTags = "NameTags";
GRLIB_PARAM_MapMarkers = "MapMarkers";
GRLIB_PARAM_EnableArsenal = "EnableArsenal";
GRLIB_PARAM_FilterArsenal = "FilterArsenal";
GRLIB_PARAM_ForcedLoadout = "ForcedLoadout";
GRLIB_PARAM_FreeLoadout = "FreeLoadout";
GRLIB_PARAM_Thermic = "Thermic";
GRLIB_PARAM_MaxFobs = "MaxFobs";
GRLIB_PARAM_MaxOutpost = "MaxOutpost";
GRLIB_PARAM_FobType = "FobType";
GRLIB_PARAM_HuronType = "HuronType";
GRLIB_PARAM_NavalFobType = "NavalFobType";
GRLIB_PARAM_FancyInfo = "FancyInfo";
GRLIB_PARAM_EnableLock = "EnableLock";
GRLIB_PARAM_EnemyLock = "EnemyLock";
GRLIB_PARAM_FuelConso = "FuelConso";
GRLIB_PARAM_MaxGarageSize = "MaxGarageSize";
GRLIB_PARAM_SectorRadius = "SectorRadius";
GRLIB_PARAM_SectorDespawn = "SectorDespawn";
GRLIB_PARAM_BuildingRatio = "BuildingRatio";
GRLIB_PARAM_KeepScore = "KeepScore";
GRLIB_PARAM_KeepContext = "KeepContext";
GRLIB_PARAM_Permissions = "Permissions";
GRLIB_PARAM_CleanupVehicles = "CleanupVehicles";
GRLIB_PARAM_AutoSave = "AutoSave";
GRLIB_PARAM_TFRadioRange = "TFRadioRange";
GRLIB_PARAM_AdminMenu = "AdminMenu";
GRLIB_PARAM_RespawnCD = "RespawnCD";
GRLIB_PARAM_KickIdle = "KickIdle";
GRLIB_PARAM_TK_mode = "TK_mode";
GRLIB_PARAM_TK_count = "TK_count";
GRLIB_PARAM_Persistent = "Persistent";
GRLIB_PARAM_CommanderModeEnabled = "CommanderMode";
GRLIB_PARAM_CommanderModeRadius = "CommanderRadius";

// Categories - can be localized now
GRLIB_PARAM_GameCatKey = "Game";
GRLIB_PARAM_PlayerCatKey = "Player";
GRLIB_PARAM_ArsenalCatKey = "Arsenal";
GRLIB_PARAM_TemplateCatKey = "Mod Template";
GRLIB_PARAM_MiscCatKey = "Misc";
GRLIB_PARAM_RestartCatKey = "Restart";
GRLIB_PARAM_ExperimentalCatKey = "Experimental";
GRLIB_PARAM_SystemCatKey = "System";
GRLIB_PARAM_FobCatKey = "FOB";

// Categories will be displayed in this order - this can be changed whenever, but any new categories MUST be added to this list
GRLIB_PARAM_CatOrder = [
    GRLIB_PARAM_GameCatKey,
    GRLIB_PARAM_PlayerCatKey,
    GRLIB_PARAM_ArsenalCatKey,
    GRLIB_PARAM_TemplateCatKey,
    GRLIB_PARAM_SystemCatKey,
    GRLIB_PARAM_FobCatKey,
    GRLIB_PARAM_MiscCatKey,
    GRLIB_PARAM_RestartCatKey,
    GRLIB_PARAM_ExperimentalCatKey
];

// Save navigation keys
GRLIB_PARAM_ValueKey = "Value";
GRLIB_PARAM_NameKey = "Name";
GRLIB_PARAM_OptionLabelKey = "OptionLabels";
GRLIB_PARAM_OptionValuesKey = "OptionValues";
GRLIB_PARAM_CategoryKey = "Category";
GRLIB_PARAM_DescriptionKey = "Description";

LRX_Mission_Params = createHashMapFromArray [
    [GRLIB_PARAM_introductionKey, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_INTRO"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables the introduction sequence."]
    ]],
    [GRLIB_PARAM_DeploymentCinematic, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_DEPLOYMENTCAMERA"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Toggles the deployment cinematic settings."]
    ]],
    [GRLIB_PARAM_Opforcap, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 200],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_OPFORCAP"],
        [GRLIB_PARAM_OptionLabelKey, ["100", "200", "300", "400"]],
        [GRLIB_PARAM_OptionValuesKey, [100, 200, 300, 400]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the enemy force cap to limit maximum enemy units."]
    ]],
    [GRLIB_PARAM_Unitcap, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_UNITCAP"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_UNITCAP1",
            localize "STR_PARAMS_UNITCAP2",
            localize "STR_PARAMS_UNITCAP3",
            localize "STR_PARAMS_UNITCAP4",
            localize "STR_PARAMS_UNITCAP5",
            localize "STR_PARAMS_UNITCAP6"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0.5, 0.75, 1, 1.25, 1.5, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Adjusts the unit cap multiplier for player forces."]
    ]],
    [GRLIB_PARAM_Difficulty, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_DIFFICULTY"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DIFFICULTY1",
            localize "STR_PARAMS_DIFFICULTY2",
            localize "STR_PARAMS_DIFFICULTY3",
            localize "STR_PARAMS_DIFFICULTY4",
            localize "STR_PARAMS_DIFFICULTY5",
            localize "STR_PARAMS_DIFFICULTY6",
            localize "STR_PARAMS_DIFFICULTY7",
            localize "STR_PARAMS_DIFFICULTY8"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0.5, 0.75, 1, 1.25, 1.5, 2, 4, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the game difficulty level using various multipliers."]
    ]],
    [GRLIB_PARAM_Aggressivity, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_AGGRESSIVITY_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_AGGRESSIVITY_PARAM0",
            localize "STR_AGGRESSIVITY_PARAM1",
            localize "STR_AGGRESSIVITY_PARAM2",
            localize "STR_AGGRESSIVITY_PARAM3",
            localize "STR_AGGRESSIVITY_PARAM4"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0.25, 0.5, 1, 2, 4]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines the aggressivity level of enemy forces."]
    ]],
    [GRLIB_PARAM_VictoryCondition, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_VICTORY_CONDITION"],
        [GRLIB_PARAM_OptionLabelKey, [
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
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Selects the victory condition for the game scenario."]
    ]],
    [GRLIB_PARAM_HideOpfor, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_OPFORMARK"],
        [GRLIB_PARAM_OptionLabelKey, ["All", "Fog of War"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines if enemy forces are fully visible or hidden in fog of war."]
    ]],
    [GRLIB_PARAM_ShowBlufor, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_BLUFORMARK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Player only", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the visibility options of friendly forces on the map."]
    ]],
    [GRLIB_PARAM_Weather, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_WEATHER_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_WEATHER_PARAM1",
            localize "STR_WEATHER_PARAM2",
            localize "STR_WEATHER_PARAM3",
            localize "STR_WEATHER_PARAM4"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Controls weather settings and intensity during the game."]
    ]],
    [GRLIB_PARAM_DayDuration, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_DAYDURATION"],
        [GRLIB_PARAM_OptionLabelKey, ["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "7", "10", "20", "30", "40", "50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 7, 10, 20, 30, 40, 50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Adjusts the duration of daytime within the mission."]
    ]],
    [GRLIB_PARAM_NightDuration, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_NIGHTDURATION"],
        [GRLIB_PARAM_OptionLabelKey, ["0.25", "0.5", "1", "1.5", "2", "2.5", "3", "5", "7", "10", "20", "30", "40", "50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25, 0.5, 1, 1.5, 2, 2.5, 3, 5, 7, 10, 20, 30, 40, 50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Adjusts the duration of nighttime within the mission."]
    ]],
    [GRLIB_PARAM_PassiveIncome, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_PASSIVE_INCOME"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables automatic passive income generation."]
    ]],
    [GRLIB_PARAM_PassiveIncomeDelay, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1200],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_PASSIVE_INCOME_DELAY"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [1200, 1800, 3600, 7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the delay (in seconds) between passive income payouts."]
    ]],
    [GRLIB_PARAM_PassiveIncomeAmmount, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 300],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["100", "200", "300", "400", "500", "1000", "1500"]],
        [GRLIB_PARAM_OptionValuesKey, [100, 200, 300, 400, 500, 1000, 1500]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Defines the amount of passive income awarded per interval."]
    ]],
    [GRLIB_PARAM_ResourcesMultiplier, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_RESOURCESMULTIPLIER"],
        [GRLIB_PARAM_OptionLabelKey, ["x0.25", "x0.5", "x0.75", "x1", "x1.25", "x1.5", "x2", "x3", "x5", "x10", "x20", "x50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3, 5, 10, 20, 50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Applies a multiplier to resources available in the mission."]
    ]],
    [GRLIB_PARAM_HaloJump, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_HALO_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_HALO_PARAM1",
            localize "STR_HALO_PARAM2",
            localize "STR_HALO_PARAM3",
            localize "STR_HALO_PARAM4",
            localize "STR_HALO_PARAM5",
            localize "STR_HALO_PARAM6"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 5, 10, 15, 20, 30]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures options for halo jump functionality."]
    ]],
    [GRLIB_PARAM_Patrols, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PATROLS"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_PARAMS_CIVILIANS1",
            localize "STR_PARAMS_CIVILIANS2",
            localize "STR_PARAMS_CIVILIANS3"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 0.5, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the patrol mode for civilian units in the mission."]
    ]],
    [GRLIB_PARAM_Wildlife, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_WILDLIFE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables wildlife presence in the mission."]
    ]],
    [GRLIB_PARAM_Civilians, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_CIVILIANS"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_PARAMS_CIVILIANS1",
            localize "STR_PARAMS_CIVILIANS2",
            localize "STR_PARAMS_CIVILIANS3"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 0.5, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures civilian presence and behavior settings."]
    ]],
    [GRLIB_PARAM_AirSupport, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ENABLE_AIR_SUPPORT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Toggles the availability of air support during the mission."]
    ]],
    [GRLIB_PARAM_CivPenalties, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 20],
        [GRLIB_PARAM_NameKey, localize "STR_CIV_PENALTIES"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "4", "6", "8", "10", "20", "25", "30", "40", "50"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 4, 6, 8, 10, 20, 25, 30, 40, 50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets penalty values that affect civilian behavior or losses."]
    ]],
    [GRLIB_PARAM_ModPresetWest, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, "A3_BLU"],
        [GRLIB_PARAM_NameKey, "MOD Preset Friendly"],
        [GRLIB_PARAM_OptionLabelKey, _list_west select 0],
        [GRLIB_PARAM_OptionValuesKey, _list_west select 1],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, "Selects the mod preset configuration for friendly (west) units."]
    ]],
    [GRLIB_PARAM_ModPresetEast, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, "A3_OPF"],
        [GRLIB_PARAM_NameKey, "MOD Preset Enemy"],
        [GRLIB_PARAM_OptionLabelKey, _list_east select 0],
        [GRLIB_PARAM_OptionValuesKey, _list_east select 1],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, "Selects the mod preset configuration for enemy (east) units."]
    ]],
    [GRLIB_PARAM_ModPresetCiv, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, "MOD Preset Civilian"],
        [GRLIB_PARAM_OptionLabelKey, ["All", "Friendly", "Enemy"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures the mod preset for civilian units."]
    ]],
    [GRLIB_PARAM_ModPresetTaxi, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, "MOD Preset Taxi"],
        [GRLIB_PARAM_OptionLabelKey, ["All", "Friendly", "Enemy", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures the mod preset for taxi units."]
    ]],
    [GRLIB_PARAM_Fatigue, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_FATIGUE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables fatigue mechanics affecting players."]
    ]],
    [GRLIB_PARAM_PAR_Revive, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_REVIVE"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_PARAMS_REVIVE1",
            localize "STR_PARAMS_REVIVE2",
            localize "STR_PARAMS_REVIVE3"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures the player revive options and settings."]
    ]],
    [GRLIB_PARAM_PAR_AI_Revive, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 7],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_AI_REVIVE"],
        [GRLIB_PARAM_OptionLabelKey, ["Unlimited", "3", "5", "7", "10", "15", "20"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 3, 5, 7, 10, 15, 20]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the maximum number of AI revives allowed (0 indicates unlimited)."]
    ]],
    [GRLIB_PARAM_PAR_BleedOut, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 300],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_BLEEDOUT"],
        [GRLIB_PARAM_OptionLabelKey, ["100", "200", "300", "400", "500", "600"]],
        [GRLIB_PARAM_OptionValuesKey, [100, 200, 300, 400, 500, 600]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Defines the bleed-out time (in seconds) for downed players."]
    ]],
    [GRLIB_PARAM_PAR_Grave, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_GRAVE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables grave mechanics following player death."]
    ]],
    [GRLIB_PARAM_DeathChat, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_DEATHCHAT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Toggles death chat notifications for player deaths."]
    ]],
    [GRLIB_PARAM_MaxSpawnPoint, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 3],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SPAWN_MAX"],
        [GRLIB_PARAM_OptionLabelKey, ["1", "2", "3", "4", "5", "6"]],
        [GRLIB_PARAM_OptionValuesKey, [1, 2, 3, 4, 5, 6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the maximum number of spawn points available."]
    ]],
    [GRLIB_PARAM_Redeploy, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_REDEPLOY"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAM_REDEPLOY_ALL", localize "STR_PARAM_REDEPLOY_FOB"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures redeployment options available to players."]
    ]],
    [GRLIB_PARAM_Respawn, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 20],
        [GRLIB_PARAM_NameKey, localize "STR_RESPAWN"],
        [GRLIB_PARAM_OptionLabelKey, ["5", "10", "20", "25", "30", "60"]],
        [GRLIB_PARAM_OptionValuesKey, [5, 10, 20, 25, 30, 60]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the respawn delay (in seconds) after a player dies."]
    ]],
    [GRLIB_PARAM_SquadSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SQUAD_SIZE_START"],
        [GRLIB_PARAM_OptionLabelKey, ["0", "1", "2", "3", "4", "5", "6"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Defines the starting squad size available to players."]
    ]],
    [GRLIB_PARAM_MaxSquadSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 5],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SQUAD_SIZE"],
        [GRLIB_PARAM_OptionLabelKey, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "20"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the maximum allowable squad size for players."]
    ]],
    [GRLIB_PARAM_PlatoonView, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_PLATOON"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures the display settings for platoon view."]
    ]],
    [GRLIB_PARAM_NameTags, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_NAMETAG"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Toggles display options for player nametags."]
    ]],
    [GRLIB_PARAM_MapMarkers, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_TEAM"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines how team map markers are displayed (user-defined, enabled, or disabled)"]
    ]],
    [GRLIB_PARAM_EnableArsenal, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ARSENAL"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_ARSENAL_FOB"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables the arsenal feature, including FOB-specific options"]
    ]],
    [GRLIB_PARAM_FilterArsenal, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_LIMIT_ARSENAL"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_LIMIT_ARSENAL_PARAM1",
            localize "STR_LIMIT_ARSENAL_PARAM2",
            localize "STR_LIMIT_ARSENAL_PARAM3",
            localize "STR_LIMIT_ARSENAL_PARAM4",
            localize "STR_LIMIT_ARSENAL_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets restrictions on the arsenal contents based on the chosen limitation parameter"]
    ]],
    [GRLIB_PARAM_ForcedLoadout, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_FORCE_LOADOUT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Preset 1", "Preset 2"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Forces players to use a predefined loadout if enabled"]
    ]],
    [GRLIB_PARAM_FreeLoadout, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_FREE_LOADOUT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Allows players to select their own loadout when enabled"]
    ]],
    [GRLIB_PARAM_Thermic, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_THERMAL"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Only at night", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables thermal vision with an option for night-only activation"]
    ]],
    [GRLIB_PARAM_MaxFobs, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 3],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_FOBS_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the maximum number of FOBs that can be deployed in the mission"]
    ]],
    [GRLIB_PARAM_MaxOutpost, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 4],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_OUTPOST_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, "Defines the maximum outpost count available during the mission"]
    ]],
    [GRLIB_PARAM_FobType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_FOB_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, ["Container", "Truck", "Boat"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, "Selects the type of FOB used (Container, Truck, or Boat)"]
    ]],
    [GRLIB_PARAM_HuronType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_HURON_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, ["CH-67 Huron", "CH-49 Mohawk", "UH-80 Ghost Hawk"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines the helicopter model used for Huron-type vehicles"]
    ]],
    [GRLIB_PARAM_NavalFobType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_NAVAL_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "USS Liberty", "USS Freedom", "Offshore Plateform"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, "Selects the naval FOB type, or disables naval FOBs altogether"]
    ]],
    [GRLIB_PARAM_FancyInfo, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_FANCY"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Info", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables additional in-game information overlay when enabled"]
    ]],
    [GRLIB_PARAM_EnableLock, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_VEH_LOCK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables vehicle locking to prevent unauthorized use"]
    ]],
    [GRLIB_PARAM_EnemyLock, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_OPFOR_VEH_LOCK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Prevents enemy forces from using locked vehicles when enabled"]
    ]],
    [GRLIB_PARAM_FuelConso, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_FUEL_CONSO"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Low", "Normal", "Medium", "High"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 0.5, 1, 1.5, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Adjusts the fuel consumption rate for vehicles to simulate different levels of efficiency"]
    ]],
    [GRLIB_PARAM_MaxGarageSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 6],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_GARAGE_SIZE"],
        [GRLIB_PARAM_OptionLabelKey, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the maximum number of vehicles allowed in the garage"]
    ]],
    [GRLIB_PARAM_SectorRadius, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SECTOR_RADIUS"],
        [GRLIB_PARAM_OptionLabelKey, [format ["AUTO (%1)", GRLIB_sector_size], "300", "400", "600", "800", "1000", "1200", "1500", "2000"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 300, 400, 600, 800, 1000, 1200, 1500, 2000]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Defines the radius for sector-based activation; 'AUTO' uses the default sector size"]
    ]],
    [GRLIB_PARAM_SectorDespawn, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 72],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SECTOR_DESPAWN"],
        [GRLIB_PARAM_OptionLabelKey, ["3", "6", "8", "12", "16", "20"]],
        [GRLIB_PARAM_OptionValuesKey, [(3*12), (6*12), (8*12), (12*12), (16*12), (20*12)]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the time multiplier for sector despawn delays, affecting sector persistence"]
    ]],
    [GRLIB_PARAM_BuildingRatio, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1.5],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_BUILDING_RATIO"],
        [GRLIB_PARAM_OptionLabelKey, ["0.5", "1", "1.5", "2", "2.5", "3"]],
        [GRLIB_PARAM_OptionValuesKey, [0.5, 1, 1.5, 2, 2.5, 3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines the ratio at which buildings spawn relative to mission scale"]
    ]],
    [GRLIB_PARAM_KeepScore, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_KEEP_SCORE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_RestartCatKey],
        [GRLIB_PARAM_DescriptionKey, "Keeps the current score between mission restarts when enabled"]
    ]],
    [GRLIB_PARAM_KeepContext, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_KEEP_CONTEXT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_RestartCatKey],
        [GRLIB_PARAM_DescriptionKey, "Maintains mission context (settings and state) between restarts"]
    ]],

    [GRLIB_PARAM_Permissions, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PERMISSIONS_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enforces permission levels for certain player actions and commands"]
    ]],
    [GRLIB_PARAM_CleanupVehicles, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1800],
        [GRLIB_PARAM_NameKey, localize "STR_CLEANUP_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 900, 1200, 1800, 3600, 7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the delay (in seconds) before unused vehicles are removed from the mission"]
    ]],
    [GRLIB_PARAM_AutoSave, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1800],
        [GRLIB_PARAM_NameKey, localize "STR_AUTO_SAVE"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 900, 1200, 1800, 3600, 7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines the interval (in seconds) for automatic mission saves"]
    ]],
    [GRLIB_PARAM_TFRadioRange, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2000],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_TFAR_RADIUS"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED", "1 km", "2 km", "3 km", "4 km", "5 km", "7.5 km", "10 km", "15 km"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1000, 2000, 3000, 4000, 5000, 7500, 10000, 15000]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the effective range of the TFAR radio for in-game communications"]
    ]],
    [GRLIB_PARAM_AdminMenu, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, "Enable the Admin Menu"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Turns on the admin menu for managing in-game settings and players"]
    ]],
    [GRLIB_PARAM_RespawnCD, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_RESPAWN_CD"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "4", "5", "6", "7", "8", "9", "10"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 240, 300, 360, 420, 480, 540, 600]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Specifies the cooldown period (in seconds) before a player can respawn"]
    ]],
    [GRLIB_PARAM_KickIdle, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_KICK_IDLE"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0, 900, 1200, 1800, 3600, 7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines the idle time limit (in seconds) before a player is automatically kicked"]
    ]],
    [GRLIB_PARAM_TK_mode, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_TK_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_TK_MODE_RELAX", localize "STR_TK_MODE_STRICT"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1, 2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Configures the team killing mode: disabled, relaxed, or strict enforcement"]
    ]],
    [GRLIB_PARAM_TK_count, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 4],
        [GRLIB_PARAM_NameKey, localize "STR_TK_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["3", "4", "5", "6", "7", "8", "9", "10"]],
        [GRLIB_PARAM_OptionValuesKey, [3, 4, 5, 6, 7, 8, 9, 10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Sets the allowable team kill count before penalty actions are triggered"]
    ]],
    [GRLIB_PARAM_Persistent, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PERSISTENT_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, "Enables or disables persistent mode, maintaining mission state across sessions"]
    ]],
    [GRLIB_PARAM_CommanderModeEnabled, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, "Commander Mode"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
		[GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ExperimentalCatKey],
        [GRLIB_PARAM_DescriptionKey, "Commander Mode replaces the normal mode of proximity-based sector activation with a commander mode that allows the commander to choose the sector for the team to attack"]
    ]],
    [GRLIB_PARAM_CommanderModeRadius, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 100],
        [GRLIB_PARAM_NameKey, "Commander Mode: Nearby sector defense activation range"],
        [GRLIB_PARAM_OptionLabelKey, ["100", "150", "200", "300", "400", "500", "600", "700", "800", "900", "1000"]],
        [GRLIB_PARAM_OptionValuesKey, [100, 150, 200, 300, 400, 500, 600, 700, 800, 900, 1000]],
		[GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ExperimentalCatKey],
        [GRLIB_PARAM_DescriptionKey, "When the commander chooses a sector to attack, nearby enemy sectors within the defined radius will be activated in defense of the chosen sector"]
    ]]
];