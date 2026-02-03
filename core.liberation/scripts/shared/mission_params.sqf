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
        _faction = _x;
        if ([_faction] call GRLIB_Template_Modloaded) then {
            (_mod_data select 0) pushBack ([_faction] call _lrx_getParamValue);
            (_mod_data select 1) pushBack _faction;
        };
	} foreach _mod_list;
	_mod_data;
};

waitUntil {sleep 0.5; !isNil "GRLIB_mod_list_west"};
waitUntil {sleep 0.5; !isNil "GRLIB_mod_list_east"};
private _list_west = ([GRLIB_mod_list_west] call _lrx_get_mod_template);
private _list_east = ([GRLIB_mod_list_east] call _lrx_get_mod_template);

GRLIB_PARAM_separatorKey = "=========";

// Parameter key mapping
GRLIB_PARAM_introductionKey = "Introduction";
GRLIB_PARAM_DeploymentCinematic = "DeploymentCinematic";
GRLIB_PARAM_Opforcap = "Opforcap";
GRLIB_PARAM_Unitcap = "Unitcap";
GRLIB_PARAM_Difficulty = "Difficulty";
GRLIB_PARAM_Aggressivity = "Aggressivity";
GRLIB_PARAM_VulnerabilityTimer = "VulnerabilityTimer";
GRLIB_PARAM_VictoryCondition = "VictoryCondition";
GRLIB_PARAM_HideOpfor = "HideOpfor";
GRLIB_PARAM_ShowBlufor = "ShowBlufor";
GRLIB_PARAM_Weather = "Weather";
GRLIB_PARAM_DayDuration = "DayDuration";
GRLIB_PARAM_NightDuration = "NightDuration";
GRLIB_PARAM_PassiveIncome = "PassiveIncome";
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
GRLIB_PARAM_SideVerification = "SideVerification";
GRLIB_PARAM_ModPresetCiv = "ModPresetCiv";
GRLIB_PARAM_ModPresetTaxi = "ModPresetTaxi";
GRLIB_PARAM_Fatigue = "Fatigue";
GRLIB_PARAM_PAR_Revive = "PAR_Revive";
GRLIB_PARAM_PAR_AI_Revive = "PAR_AI_Revive";
GRLIB_PARAM_PAR_BleedOut = "PAR_BleedOut";
GRLIB_PARAM_PAR_Grave = "PAR_Grave";
GRLIB_PARAM_PAR_RespawnBtn = "PAR_Respawn";
GRLIB_PARAM_DeathChat = "DeathChat";
GRLIB_PARAM_ForceEnglish = "ForceEnglish";
GRLIB_PARAM_MaxSpawnPoint = "MaxSpawnPoint";
GRLIB_PARAM_Redeploy = "Redeploy";
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
GRLIB_PARAM_Drones = "EnableDrones";
GRLIB_PARAM_VehicleDefense = "VehicleDefense";
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
GRLIB_PARAM_UndercoverModeEnabled = "UndercoverMode";
GRLIB_PARAM_CommanderModeEnabled = "CommanderMode";
GRLIB_PARAM_CommanderModeRadius = "CommanderRadius";
GRLIB_PARAM_CommanderVoteTimeout = "CommVoteTimeout";
GRLIB_PARAM_CommanderAutoStart = "CommAutoStart";
GRLIB_PARAM_CommPlayerVote = "CommPlayerVote";
GRLIB_PARAM_Alarms = "Alarms";
GRLIB_PARAM_MineProbability = "MineProbability";
GRLIB_PARAM_ArtyMaxShot = "ArtyMaxShot";
GRLIB_PARAM_A3WCount = "A3WCount";
GRLIB_PARAM_A3WDelay = "A3WDelay";

// Categories
GRLIB_PARAM_GameCatKey          = localize "STR_PARAMCAT_GAME";
GRLIB_PARAM_PlayerCatKey        = localize "STR_PARAMCAT_PLAYER";
GRLIB_PARAM_ArsenalCatKey       = localize "STR_PARAMCAT_ARSENAL";
GRLIB_PARAM_TemplateCatKey      = localize "STR_PARAMCAT_TEMPLATE";
GRLIB_PARAM_MiscCatKey          = localize "STR_PARAMCAT_MISC";
GRLIB_PARAM_RestartCatKey       = localize "STR_PARAMCAT_RESTART";
GRLIB_PARAM_ExperimentalCatKey  = localize "STR_PARAMCAT_EXPERIMENTAL";
GRLIB_PARAM_SystemCatKey        = localize "STR_PARAMCAT_SYSTEM";
GRLIB_PARAM_FobCatKey           = localize "STR_PARAMCAT_FOB";
GRLIB_PARAM_CommanderCatKey     = localize "STR_PARAMCAT_COMMANDER";

// Categories will be displayed in this order - this can be changed whenever, but any new categories MUST be added to this list
GRLIB_PARAM_CatOrder = [
    GRLIB_PARAM_TemplateCatKey,
    GRLIB_PARAM_GameCatKey,
    GRLIB_PARAM_CommanderCatKey,
    GRLIB_PARAM_PlayerCatKey,
    GRLIB_PARAM_ArsenalCatKey,
    GRLIB_PARAM_FobCatKey,
    GRLIB_PARAM_MiscCatKey,
    GRLIB_PARAM_SystemCatKey,
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
GRLIB_PARAM_OptionDescriptionKey = "OptionDescriptions";

// Params format

// [GRLIB_PARAM_{newKey}, createHashMapFromArray [                                                          // {newKey} Required: String - Replace {newKey} with the key name
//     [GRLIB_PARAM_ValueKey, {defaultValue} e.g. 1],                                                       // {defaultValue} Required: Any variable type - Replace {defaultValue} with the default value, ABSOLUTELY MUST be contained within the OptionValuesKey array
//     [GRLIB_PARAM_NameKey, {Name} eg "Name"],                                                             // {Name} Required: String - Replace {Name} with the name of the parameter, this is what will be displayed in the menu
//     [GRLIB_PARAM_OptionLabelKey, {["label", "label1", "label2"]} eg ["label", "label1", "label2"]],      // {["label", "label1", "label2"]} Required: Array - Replace {["label", "label1", "label2"]} with the labels for each value in the OptionValuesKey array, MUST be the same length as the OptionValuesKey array
//     [GRLIB_PARAM_OptionValuesKey, {[Value, Value1, Value2]} eg [0, 1, 2]],                               // {[Value, Value1, Value2]} Required: Array - Replace {[Value, Value1, Value2]} with the values for each label in the OptionLabelKey array, MUST be the same length as the OptionLabelKey array - types must match the ValueKey type
//     [GRLIB_PARAM_CategoryKey, {Category} eg GRLIB_PARAM_GameCatKey],                                     // {Category} Required: String - Replace {Category} with the category of the parameter, this is MUST be a category defined above in the GRLIB_PARAM_CatOrder array
//     [GRLIB_PARAM_DescriptionKey, {Description} eg "Description"]                                         // {Description} Optional: String - Replace {Description} with the description of the parameter, this is what will be displayed in the menu when hovering over the parameter name
//     [GRLIB_PARAM_OptionDescriptionKey, {["label", "label1", "label2"]} eg ["label", "label1", "label2"]]    // {["label", "label1", "label2"]} Optional: Array - Replace {["label", "label1", "label2"]} with the descriptions for each value in the OptionValuesKey array, MUST be the same length as the OptionValuesKey array
// ]],

_Mission_Params = [
    [GRLIB_PARAM_introductionKey, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_INTRO"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_INTRO_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_INTRO_OPT0",
            localize "STR_PARAMS_INTRO_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_DeploymentCinematic, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_DEPLOYMENTCAMERA"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0, 1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_DEPLOYMENTCAMERA_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_DEPLOYMENTCAMERA_OPT0",
            localize "STR_PARAMS_DEPLOYMENTCAMERA_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_Opforcap, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 200],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_OPFORCAP"],
        [GRLIB_PARAM_OptionLabelKey, ["100", "200", "300", "400"]],
        [GRLIB_PARAM_OptionValuesKey, [100, 200, 300, 400]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_OPFORCAP_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_OPFORCAP_OPT0",
            localize "STR_PARAMS_OPFORCAP_OPT1",
            localize "STR_PARAMS_OPFORCAP_OPT2",
            localize "STR_PARAMS_OPFORCAP_OPT3"
        ]]
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
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_UNITCAP_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_UNITCAP_OPT0",
            localize "STR_PARAMS_UNITCAP_OPT1",
            localize "STR_PARAMS_UNITCAP_OPT2",
            localize "STR_PARAMS_UNITCAP_OPT3",
            localize "STR_PARAMS_UNITCAP_OPT4",
            localize "STR_PARAMS_UNITCAP_OPT5"
        ]]
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
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_DIFFICULTY_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_DIFFICULTY_OPT0",
            localize "STR_PARAMS_DIFFICULTY_OPT1",
            localize "STR_PARAMS_DIFFICULTY_OPT2",
            localize "STR_PARAMS_DIFFICULTY_OPT3",
            localize "STR_PARAMS_DIFFICULTY_OPT4",
            localize "STR_PARAMS_DIFFICULTY_OPT5",
            localize "STR_PARAMS_DIFFICULTY_OPT6",
            localize "STR_PARAMS_DIFFICULTY_OPT7"
        ]]
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
        [GRLIB_PARAM_DescriptionKey, localize "STR_AGGRESSIVITY_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_AGGRESSIVITY_PARAM_OPT0",
            localize "STR_AGGRESSIVITY_PARAM_OPT1",
            localize "STR_AGGRESSIVITY_PARAM_OPT2",
            localize "STR_AGGRESSIVITY_PARAM_OPT3",
            localize "STR_AGGRESSIVITY_PARAM_OPT4"
        ]]
    ]],
    [GRLIB_PARAM_VulnerabilityTimer, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 900],
        [GRLIB_PARAM_NameKey, localize "STR_VULN_TIMER"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_CLEANUP_PARAM0",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3"
        ]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_OptionValuesKey, [600,900,1200,1800]],
        [GRLIB_PARAM_DescriptionKey, localize "STR_VULN_TIMER_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_CLEANUP_PARAM0",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6,7,8,9,10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_VICTORY_CONDITION_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_VICTORY_COND_OPT0",
            localize "STR_VICTORY_COND_OPT1",
            localize "STR_VICTORY_COND_OPT2",
            localize "STR_VICTORY_COND_OPT3",
            localize "STR_VICTORY_COND_OPT4",
            localize "STR_VICTORY_COND_OPT5",
            localize "STR_VICTORY_COND_OPT6",
            localize "STR_VICTORY_COND_OPT7",
            localize "STR_VICTORY_COND_OPT8",
            localize "STR_VICTORY_COND_OPT9",
            localize "STR_VICTORY_COND_OPTA"
        ]]
    ]],
    [GRLIB_PARAM_HideOpfor, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_OPFORMARK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_ALL", localize "STR_FOG_OF_WAR"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_OPFORMARK_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_OPFORMARK_OPT0",
            localize "STR_OPFORMARK_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_ShowBlufor, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_BLUFORMARK"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_PLAYER_ONLY",
            localize "STR_PARAMS_ENABLED"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_BLUFORMARK_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_BLUFORMARK_OPT0",
            localize "STR_BLUFORMARK_OPT1",
            localize "STR_BLUFORMARK_OPT2"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_WEATHER_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_WEATHER_PARAM_OPT0",
            localize "STR_WEATHER_PARAM_OPT1",
            localize "STR_WEATHER_PARAM_OPT2",
            localize "STR_WEATHER_PARAM_OPT3",
            localize "STR_WEATHER_PARAM_OPT4"
        ]]
    ]],
    [GRLIB_PARAM_DayDuration, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_DAYDURATION"],
        [GRLIB_PARAM_OptionLabelKey, ["x0.25","x0.5","x1","x1.5","x2","x2.5","x3","x5","x7","x10","x20","x30","x40","x50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25,0.5,1,1.5,2,2.5,3,5,7,10,20,30,40,50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_DAYDURATION_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            format [localize "STR_PARAMS_DAYDURATION_OPT0", 0.25],
            format [localize "STR_PARAMS_DAYDURATION_OPT0", 0.5],
            format [localize "STR_PARAMS_DAYDURATION_OPT1", 1],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 1.5],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 2],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 2.5],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 3],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 5],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 7],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 10],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 20],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 30],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 40],
            format [localize "STR_PARAMS_DAYDURATION_OPT2", 50]
        ]]
    ]],
    [GRLIB_PARAM_NightDuration, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_NIGHTDURATION"],
        [GRLIB_PARAM_OptionLabelKey, ["x0.25","x0.5","x1","x1.5","x2","x2.5","x3","x5","x7","x10","x20","x30","x40","x50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25,0.5,1,1.5,2,2.5,3,5,7,10,20,30,40,50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_NIGHTDURATION_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            format [localize "STR_PARAMS_NIGHTDURATION_OPT0", 0.25],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT0", 0.5],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT1", 1],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 1.5],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 2],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 2.5],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 3],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 5],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 7],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 10],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 20],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 30],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 40],
            format [localize "STR_PARAMS_NIGHTDURATION_OPT2", 50]
        ]]
    ]],
    [GRLIB_PARAM_PassiveIncome, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_PASSIVE_INCOME"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0,1200,1800,3600,7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_PASSIVE_INCOME_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_PASSIVE_INCOME_OPT0",
            localize "STR_PARAM_PASSIVE_INCOME_DELAY_OPT0",
            localize "STR_PARAM_PASSIVE_INCOME_DELAY_OPT1",
            localize "STR_PARAM_PASSIVE_INCOME_DELAY_OPT2",
            localize "STR_PARAM_PASSIVE_INCOME_DELAY_OPT3"
        ]]
    ]],
    [GRLIB_PARAM_PassiveIncomeAmmount, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 300],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["100","200","300","400","500","1000","1500"]],
        [GRLIB_PARAM_OptionValuesKey, [100,200,300,400,500,1000,1500]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT0",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT1",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT2",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT3",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT4",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT5",
            localize "STR_PARAM_PASSIVE_INCOME_AMMOUNT_OPT6"
        ]]
    ]],
    [GRLIB_PARAM_ResourcesMultiplier, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_RESOURCESMULTIPLIER"],
        [GRLIB_PARAM_OptionLabelKey, ["x0.25","x0.5","x0.75","x1","x1.25","x1.5","x2","x3","x5","x10","x20","x50"]],
        [GRLIB_PARAM_OptionValuesKey, [0.25,0.5,0.75,1,1.25,1.5,2,3,5,10,20,50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_RESOURCESMULTIPLIER_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT0",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT1",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT2",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT3",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT4",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT5",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT6",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT7",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT8",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT9",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT10",
            localize "STR_PARAMS_RESOURCESMULTIPLIER_OPT11"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,1,5,10,15,20,30]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_HALO_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_HALO_PARAM_OPT0",
            localize "STR_HALO_PARAM_OPT1",
            localize "STR_HALO_PARAM_OPT2",
            localize "STR_HALO_PARAM_OPT3",
            localize "STR_HALO_PARAM_OPT4",
            localize "STR_HALO_PARAM_OPT5",
            localize "STR_HALO_PARAM_OPT6"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,0.5,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_PATROLS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_PATROLS_OPT0",
            localize "STR_PARAMS_PATROLS_OPT1",
            localize "STR_PARAMS_PATROLS_OPT2",
            localize "STR_PARAMS_PATROLS_OPT3"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,0.5,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_CIVILIANS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_CIVILIANS_OPT0",
            localize "STR_PARAMS_CIVILIANS_OPT1",
            localize "STR_PARAMS_CIVILIANS_OPT2",
            localize "STR_PARAMS_CIVILIANS_OPT3"
        ]]
    ]],
    [GRLIB_PARAM_Wildlife, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_WILDLIFE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_WILDLIFE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_WILDLIFE_OPT0",
            localize "STR_PARAM_WILDLIFE_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_AirSupport, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ENABLE_AIR_SUPPORT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_ENABLE_AIR_SUPPORT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_ENABLE_AIR_SUPPORT_OPT0",
            localize "STR_ENABLE_AIR_SUPPORT_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_CivPenalties, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 20],
        [GRLIB_PARAM_NameKey, localize "STR_CIV_PENALTIES"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED", "4", "6", "8", "10", "20", "25", "30", "40", "50"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0,4,6,8,10,20,25,30,40,50]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_GameCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_CIV_PENALTIES_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_CIV_PENALTIES_OPT0",
            localize "STR_CIV_PENALTIES_OPT1",
            localize "STR_CIV_PENALTIES_OPT2",
            localize "STR_CIV_PENALTIES_OPT3",
            localize "STR_CIV_PENALTIES_OPT4",
            localize "STR_CIV_PENALTIES_OPT5",
            localize "STR_CIV_PENALTIES_OPT6",
            localize "STR_CIV_PENALTIES_OPT7",
            localize "STR_CIV_PENALTIES_OPT8",
            localize "STR_CIV_PENALTIES_OPT9"
        ]]
    ]],
    [GRLIB_PARAM_Alarms, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ALARMS"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_ALARMS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_ALARMS_OPT0",
            localize "STR_ALARMS_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_MineProbability, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 100],
        [GRLIB_PARAM_NameKey, localize "STR_MINE_PROBABILITY"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","5%","10%","15%","25%","50%","75%","100%"]],
        [GRLIB_PARAM_OptionValuesKey, [0,5,10,15,25,50,75,100]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_MINE_PROBABILITY_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_MINE_PROBABILITY_OPT0",
            localize "STR_MINE_PROBABILITY_OPT1",
            localize "STR_MINE_PROBABILITY_OPT2",
            localize "STR_MINE_PROBABILITY_OPT3",
            localize "STR_MINE_PROBABILITY_OPT4",
            localize "STR_MINE_PROBABILITY_OPT5",
            localize "STR_MINE_PROBABILITY_OPT6",
            localize "STR_MINE_PROBABILITY_OPT7"
        ]]
    ]],
    [GRLIB_PARAM_ModPresetWest, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, "A3_BLU"],
        [GRLIB_PARAM_NameKey, localize "STR_MOD_PRESET_WEST"],
        [GRLIB_PARAM_OptionLabelKey, _list_west select 0],
        [GRLIB_PARAM_OptionValuesKey, _list_west select 1],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_MOD_PRESET_WEST_DESC"]
    ]],
    [GRLIB_PARAM_ModPresetEast, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, "A3_OPF"],
        [GRLIB_PARAM_NameKey, localize "STR_MOD_PRESET_EAST"],
        [GRLIB_PARAM_OptionLabelKey, _list_east select 0],
        [GRLIB_PARAM_OptionValuesKey, _list_east select 1],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_MOD_PRESET_EAST_DESC"]
    ]],
    [GRLIB_PARAM_ModPresetCiv, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_MOD_PRESET_CIV"],
        [GRLIB_PARAM_OptionLabelKey, ["All","Friendly","Enemy"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_MOD_PRESET_CIV_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_MOD_PRESET_CIV_OPT0",
            localize "STR_MOD_PRESET_CIV_OPT1",
            localize "STR_MOD_PRESET_CIV_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_ModPresetTaxi, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_MOD_PRESET_TAXI"],
        [GRLIB_PARAM_OptionLabelKey, ["All","Friendly","Enemy", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_MOD_PRESET_TAXI_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_MOD_PRESET_TAXI_OPT0",
            localize "STR_MOD_PRESET_TAXI_OPT1",
            localize "STR_MOD_PRESET_TAXI_OPT2",
            localize "STR_MOD_PRESET_TAXI_OPT3"
        ]]
    ]],
    [GRLIB_PARAM_SideVerification, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_SIDE_VERIF"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_TemplateCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_SIDE_VERIF_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_SIDE_VERIF_OPT0",
            localize "STR_SIDE_VERIF_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_Fatigue, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_FATIGUE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_FATIGUE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_FATIGUE_OPT0",
            localize "STR_PARAMS_FATIGUE_OPT1"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_PAR_REVIVE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_PAR_REVIVE_OPT0",
            localize "STR_PARAMS_PAR_REVIVE_OPT1",
            localize "STR_PARAMS_PAR_REVIVE_OPT2",
            localize "STR_PARAMS_PAR_REVIVE_OPT3"
        ]]
    ]],
    [GRLIB_PARAM_PAR_AI_Revive, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 7],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_AI_REVIVE"],
        [GRLIB_PARAM_OptionLabelKey, ["Unlimited","3","5","7","10","15","20"]],
        [GRLIB_PARAM_OptionValuesKey, [0,3,5,7,10,15,20]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_PAR_AI_REVIVE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT0",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT1",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT2",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT3",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT4",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT5",
            localize "STR_PARAMS_PAR_AI_REVIVE_OPT6"
        ]]
    ]],
    [GRLIB_PARAM_PAR_BleedOut, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 300],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_BLEEDOUT"],
        [GRLIB_PARAM_OptionLabelKey, ["100","200","300","400","500","600"]],
        [GRLIB_PARAM_OptionValuesKey, [100,200,300,400,500,600]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_PAR_BLEEDOUT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT0",
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT1",
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT2",
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT3",
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT4",
            localize "STR_PARAMS_PAR_BLEEDOUT_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_PAR_Grave, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_PAR_GRAVE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_PAR_GRAVE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_PAR_GRAVE_OPT0",
            localize "STR_PARAMS_PAR_GRAVE_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_PAR_RespawnBtn, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 20],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_RESPAWN"],
        [GRLIB_PARAM_OptionLabelKey, ["5","10","20","25","30","60"]],
        [GRLIB_PARAM_OptionValuesKey, [5,10,20,25,30,60]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_RESPAWN_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_RESPAWN_OPT0",
            localize "STR_RESPAWN_OPT1",
            localize "STR_RESPAWN_OPT2",
            localize "STR_RESPAWN_OPT3",
            localize "STR_RESPAWN_OPT4",
            localize "STR_RESPAWN_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_SquadSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SQUAD_SIZE_START"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_SQUAD_SIZE_START_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_SQUAD_SIZE_START_OPT0",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT1",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT2",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT3",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT4",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT5",
            localize "STR_PARAM_SQUAD_SIZE_START_OPT6"
        ]]
    ]],
    [GRLIB_PARAM_MaxSquadSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 5],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SQUAD_SIZE"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6","7","8","9","10"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6,7,8,9,10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_SQUAD_SIZE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_SQUAD_SIZE_OPT0",
            localize "STR_PARAM_SQUAD_SIZE_OPT1",
            localize "STR_PARAM_SQUAD_SIZE_OPT2",
            localize "STR_PARAM_SQUAD_SIZE_OPT3",
            localize "STR_PARAM_SQUAD_SIZE_OPT4",
            localize "STR_PARAM_SQUAD_SIZE_OPT5",
            localize "STR_PARAM_SQUAD_SIZE_OPT6",
            localize "STR_PARAM_SQUAD_SIZE_OPT7",
            localize "STR_PARAM_SQUAD_SIZE_OPT8",
            localize "STR_PARAM_SQUAD_SIZE_OPT9",
            localize "STR_PARAM_SQUAD_SIZE_OPT10"
        ]]
    ]],
    [GRLIB_PARAM_DeathChat, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_DEATHCHAT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_DEATHCHAT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_DEATHCHAT_OPT0",
            localize "STR_DEATHCHAT_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_ForceEnglish, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_FORCE_ENG"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_FORCE_ENG_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_FORCE_ENG_OPT0",
            localize "STR_FORCE_ENG_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_MaxSpawnPoint, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 3],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SPAWN_MAX"],
        [GRLIB_PARAM_OptionLabelKey, ["1","2","3","4","5","6"]],
        [GRLIB_PARAM_OptionValuesKey, [1,2,3,4,5,6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_SPAWN_MAX_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_SPAWN_MAX_OPT0",
            localize "STR_PARAM_SPAWN_MAX_OPT1",
            localize "STR_PARAM_SPAWN_MAX_OPT2",
            localize "STR_PARAM_SPAWN_MAX_OPT3",
            localize "STR_PARAM_SPAWN_MAX_OPT4",
            localize "STR_PARAM_SPAWN_MAX_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_Redeploy, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_REDEPLOY"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAM_REDEPLOY_ALL", localize "STR_PARAM_REDEPLOY_FOB"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_REDEPLOY_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_REDEPLOY_OPT0",
            localize "STR_REDEPLOY_OPT1",
            localize "STR_REDEPLOY_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_PlatoonView, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_PLATOON"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_GUI_PLATOON_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_GUI_PLATOON_OPT0",
            localize "STR_GUI_PLATOON_OPT1",
            localize "STR_GUI_PLATOON_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_NameTags, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_NAMETAG"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_GUI_NAMETAG_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_GUI_NAMETAG_OPT0",
            localize "STR_GUI_NAMETAG_OPT1",
            localize "STR_GUI_NAMETAG_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_MapMarkers, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_GUI_TEAM"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_USER_DEF", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_DISABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_PlayerCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_GUI_TEAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_GUI_TEAM_OPT0",
            localize "STR_GUI_TEAM_OPT1",
            localize "STR_GUI_TEAM_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_EnableArsenal, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ARSENAL"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED", localize "STR_PARAMS_ARSENAL_FOB"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_ARSENAL_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_ARSENAL_OPT0",
            localize "STR_ARSENAL_OPT1",
            localize "STR_ARSENAL_OPT2"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_LIMIT_ARSENAL_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_LIMIT_ARSENAL_OPT0",
            localize "STR_LIMIT_ARSENAL_OPT1",
            localize "STR_LIMIT_ARSENAL_OPT2",
            localize "STR_LIMIT_ARSENAL_OPT3",
            localize "STR_LIMIT_ARSENAL_OPT4",
            localize "STR_LIMIT_ARSENAL_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_ForcedLoadout, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_FORCE_LOADOUT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Preset 1", "Preset 2"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_FORCE_LOADOUT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_FORCE_LOADOUT_OPT0",
            localize "STR_FORCE_LOADOUT_OPT1",
            localize "STR_FORCE_LOADOUT_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_FreeLoadout, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_FREE_LOADOUT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_FREE_LOADOUT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_FREE_LOADOUT_OPT0",
            localize "STR_FREE_LOADOUT_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_Thermic, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_THERMAL"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", "Only at night", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_ArsenalCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_THERMAL_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_THERMAL_OPT0",
            localize "STR_THERMAL_OPT1",
            localize "STR_THERMAL_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_MaxFobs, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 3],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_FOBS_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6","7","8","9","10"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6,7,8,9,10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_FOBS_COUNT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_FOBS_COUNT_OPT0",
            localize "STR_PARAM_FOBS_COUNT_OPT1",
            localize "STR_PARAM_FOBS_COUNT_OPT2",
            localize "STR_PARAM_FOBS_COUNT_OPT3",
            localize "STR_PARAM_FOBS_COUNT_OPT4",
            localize "STR_PARAM_FOBS_COUNT_OPT5",
            localize "STR_PARAM_FOBS_COUNT_OPT6",
            localize "STR_PARAM_FOBS_COUNT_OPT7",
            localize "STR_PARAM_FOBS_COUNT_OPT8",
            localize "STR_PARAM_FOBS_COUNT_OPT9",
            localize "STR_PARAM_FOBS_COUNT_OPT10"
        ]]
    ]],
    [GRLIB_PARAM_MaxOutpost, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 4],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_OUTPOST_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6","7","8","9","10"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6,7,8,9,10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_OUTPOST_COUNT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_OUTPOST_COUNT_OPT0",
            localize "STR_PARAM_OUTPOST_COUNT_OPT1",
            localize "STR_PARAM_OUTPOST_COUNT_OPT2",
            localize "STR_PARAM_OUTPOST_COUNT_OPT3",
            localize "STR_PARAM_OUTPOST_COUNT_OPT4",
            localize "STR_PARAM_OUTPOST_COUNT_OPT5",
            localize "STR_PARAM_OUTPOST_COUNT_OPT6",
            localize "STR_PARAM_OUTPOST_COUNT_OPT7",
            localize "STR_PARAM_OUTPOST_COUNT_OPT8",
            localize "STR_PARAM_OUTPOST_COUNT_OPT9",
            localize "STR_PARAM_OUTPOST_COUNT_OPT10"
        ]]
    ]],
    [GRLIB_PARAM_FobType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_FOB_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, ["Container","Truck","Boat"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_FOB_TYPE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_FOB_TYPE_OPT0",
            localize "STR_PARAM_FOB_TYPE_OPT1",
            localize "STR_PARAM_FOB_TYPE_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_HuronType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_HURON_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, ["CH-67 Huron","CH-49 Mohawk","UH-80 Ghost Hawk"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_HURON_TYPE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_HURON_TYPE_OPT0",
            localize "STR_PARAM_HURON_TYPE_OPT1",
            localize "STR_PARAM_HURON_TYPE_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_NavalFobType, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_NAVAL_TYPE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","USS Liberty","USS Freedom","Offshore Platform"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_FobCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_NAVAL_TYPE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_NAVAL_TYPE_OPT0",
            localize "STR_PARAM_NAVAL_TYPE_OPT1",
            localize "STR_PARAM_NAVAL_TYPE_OPT2",
            localize "STR_PARAM_NAVAL_TYPE_OPT3"
        ]]
    ]],
    [GRLIB_PARAM_FancyInfo, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2],
        [GRLIB_PARAM_NameKey, localize "STR_FANCY"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","Info",localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_FANCY_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_FANCY_OPT0",
            localize "STR_FANCY_OPT1",
            localize "STR_FANCY_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_EnableLock, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_VEH_LOCK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_VEH_LOCK_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_VEH_LOCK_OPT0",
            localize "STR_VEH_LOCK_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_EnemyLock, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_OPFOR_VEH_LOCK"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_OPFOR_VEH_LOCK_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_OPFOR_VEH_LOCK_OPT0",
            localize "STR_OPFOR_VEH_LOCK_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_FuelConso, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_FUEL_CONSO"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","Low","Normal","Medium","High"]],
        [GRLIB_PARAM_OptionValuesKey, [0,0.5,1,1.5,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_FUEL_CONSO_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_FUEL_CONSO_OPT0",
            localize "STR_PARAMS_FUEL_CONSO_OPT1",
            localize "STR_PARAMS_FUEL_CONSO_OPT2",
            localize "STR_PARAMS_FUEL_CONSO_OPT3",
            localize "STR_PARAMS_FUEL_CONSO_OPT4"
        ]]
    ]],
    [GRLIB_PARAM_Drones, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_ENABLE_DRONES"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_ENABLE_DRONES_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_ENABLE_DRONES_OPT1",
            localize "STR_PARAMS_ENABLE_DRONES_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_VehicleDefense, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_ENABLE_DEFENSE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_ENABLE_DEFENSE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_ENABLE_DEFENSE_OPT1",
            localize "STR_PARAMS_ENABLE_DEFENSE_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_MaxGarageSize, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 6],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_GARAGE_SIZE"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6","7","8","9","10"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6,7,8,9,10]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_GARAGE_SIZE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_GARAGE_SIZE_OPT0",
            localize "STR_PARAM_GARAGE_SIZE_OPT1",
            localize "STR_PARAM_GARAGE_SIZE_OPT2",
            localize "STR_PARAM_GARAGE_SIZE_OPT3",
            localize "STR_PARAM_GARAGE_SIZE_OPT4",
            localize "STR_PARAM_GARAGE_SIZE_OPT5",
            localize "STR_PARAM_GARAGE_SIZE_OPT6",
            localize "STR_PARAM_GARAGE_SIZE_OPT7",
            localize "STR_PARAM_GARAGE_SIZE_OPT8",
            localize "STR_PARAM_GARAGE_SIZE_OPT9",
            localize "STR_PARAM_GARAGE_SIZE_OPT10"
        ]]
    ]],
    [GRLIB_PARAM_SectorRadius, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SECTOR_RADIUS"],
        [GRLIB_PARAM_OptionLabelKey, [format ["AUTO (%1)", GRLIB_sector_size],"300","400","600","800","1000","1200","1500","2000"]],
        [GRLIB_PARAM_OptionValuesKey, [0,300,400,600,800,1000,1200,1500,2000]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_SECTOR_RADIUS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_SECTOR_RADIUS_OPT0",
            localize "STR_PARAM_SECTOR_RADIUS_OPT1",
            localize "STR_PARAM_SECTOR_RADIUS_OPT2",
            localize "STR_PARAM_SECTOR_RADIUS_OPT3",
            localize "STR_PARAM_SECTOR_RADIUS_OPT4",
            localize "STR_PARAM_SECTOR_RADIUS_OPT5",
            localize "STR_PARAM_SECTOR_RADIUS_OPT6",
            localize "STR_PARAM_SECTOR_RADIUS_OPT7",
            localize "STR_PARAM_SECTOR_RADIUS_OPT8"
        ]]
    ]],
    [GRLIB_PARAM_SectorDespawn, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 72],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_SECTOR_DESPAWN"],
        [GRLIB_PARAM_OptionLabelKey, ["3","6","8","12","16","20"]],
        [GRLIB_PARAM_OptionValuesKey, [(3*12),(6*12),(8*12),(12*12),(16*12),(20*12)]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_SECTOR_DESPAWN_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_SECTOR_DESPAWN_OPT0",
            localize "STR_PARAM_SECTOR_DESPAWN_OPT1",
            localize "STR_PARAM_SECTOR_DESPAWN_OPT2",
            localize "STR_PARAM_SECTOR_DESPAWN_OPT3",
            localize "STR_PARAM_SECTOR_DESPAWN_OPT4",
            localize "STR_PARAM_SECTOR_DESPAWN_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_BuildingRatio, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1.5],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_BUILDING_RATIO"],
        [GRLIB_PARAM_OptionLabelKey, ["0.5","1","1.5","2","2.5","3","6"]],
        [GRLIB_PARAM_OptionValuesKey, [0.5,1,1.5,2,2.5,3,6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_BUILDING_RATIO_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_BUILDING_RATIO_OPT0",
            localize "STR_PARAMS_BUILDING_RATIO_OPT1",
            localize "STR_PARAMS_BUILDING_RATIO_OPT2",
            localize "STR_PARAMS_BUILDING_RATIO_OPT3",
            localize "STR_PARAMS_BUILDING_RATIO_OPT4",
            localize "STR_PARAMS_BUILDING_RATIO_OPT5",
            localize "STR_PARAMS_BUILDING_RATIO_OPT6"
        ]]
    ]],
    [GRLIB_PARAM_ArtyMaxShot, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 10],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_MAX_SHOT"],
        [GRLIB_PARAM_OptionLabelKey, ["10","15","20","25","30"]],
        [GRLIB_PARAM_OptionValuesKey, [10,15,20,25,30]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_MAX_SHOT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            "10 round","15 round","20 round","25 round","30 round"
        ]]
    ]],
    [GRLIB_PARAM_A3WCount, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 4],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_A3W_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["0","1","2","3","4","5","6"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2,3,4,5,6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_A3W_COUNT"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            "0","1","2","3","4","5","6"
        ]]
    ]],
    [GRLIB_PARAM_A3WDelay, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1800],
        [GRLIB_PARAM_NameKey, localize "STR_PARAMS_A3W_DELAY"],
        [GRLIB_PARAM_OptionLabelKey, ["10 min","15 min","20 min","30 min","1h","2h"]],
        [GRLIB_PARAM_OptionValuesKey, [600,900,1200,1800,3600,7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAMS_A3W_DELAY"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_CLEANUP_PARAM0",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]]
    ]],
    [GRLIB_PARAM_UndercoverModeEnabled, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_UNDERCOVER_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_MiscCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_UNDERCOVER_MODE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_PARAMS_ENABLED"
        ]]
    ]],
    [GRLIB_PARAM_KeepScore, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_KEEP_SCORE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_RestartCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_KEEP_SCORE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_KEEP_SCORE_OPT0",
            localize "STR_KEEP_SCORE_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_KeepContext, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_KEEP_CONTEXT"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_RestartCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_KEEP_CONTEXT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_KEEP_CONTEXT_OPT0",
            localize "STR_KEEP_CONTEXT_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_Permissions, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_PERMISSIONS_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PERMISSIONS_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PERMISSIONS_PARAM_OPT0",
            localize "STR_PERMISSIONS_PARAM_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_CleanupVehicles, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1200],
        [GRLIB_PARAM_NameKey, localize "STR_CLEANUP_PARAM"],
        [GRLIB_PARAM_OptionLabelKey, [
            localize "STR_PARAMS_DISABLED",
            localize "STR_CLEANUP_PARAM1",
            localize "STR_CLEANUP_PARAM2",
            localize "STR_CLEANUP_PARAM3",
            localize "STR_CLEANUP_PARAM4",
            localize "STR_CLEANUP_PARAM5"
        ]],
        [GRLIB_PARAM_OptionValuesKey, [0,900,1200,1800,3600,7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_CLEANUP_PARAM_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_CLEANUP_PARAM_OPT0",
            localize "STR_CLEANUP_PARAM_OPT1",
            localize "STR_CLEANUP_PARAM_OPT2",
            localize "STR_CLEANUP_PARAM_OPT3",
            localize "STR_CLEANUP_PARAM_OPT4",
            localize "STR_CLEANUP_PARAM_OPT5"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,900,1200,1800,3600,7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_AUTO_SAVE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_AUTO_SAVE_OPT0",
            localize "STR_AUTO_SAVE_OPT1",
            localize "STR_AUTO_SAVE_OPT2",
            localize "STR_AUTO_SAVE_OPT3",
            localize "STR_AUTO_SAVE_OPT4",
            localize "STR_AUTO_SAVE_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_TFRadioRange, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 2000],
        [GRLIB_PARAM_NameKey, localize "STR_PARAM_TFAR_RADIUS"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","1 km","2 km","3 km","4 km","5 km","7.5 km","10 km","15 km"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1000,2000,3000,4000,5000,7500,10000,15000]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PARAM_TFAR_RADIUS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PARAM_TFAR_RADIUS_OPT0",
            localize "STR_PARAM_TFAR_RADIUS_OPT1",
            localize "STR_PARAM_TFAR_RADIUS_OPT2",
            localize "STR_PARAM_TFAR_RADIUS_OPT3",
            localize "STR_PARAM_TFAR_RADIUS_OPT4",
            localize "STR_PARAM_TFAR_RADIUS_OPT5",
            localize "STR_PARAM_TFAR_RADIUS_OPT6",
            localize "STR_PARAM_TFAR_RADIUS_OPT7",
            localize "STR_PARAM_TFAR_RADIUS_OPT8"
        ]]
    ]],
    [GRLIB_PARAM_AdminMenu, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_ADMIN_MENU"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_ADMIN_MENU_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_ADMIN_MENU_OPT0",
            localize "STR_ADMIN_MENU_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_RespawnCD, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_RESPAWN_CD"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED","4","5","6","7","8","9","10"]],
        [GRLIB_PARAM_OptionValuesKey, [0,240,300,360,420,480,540,600]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_RESPAWN_CD_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_RESPAWN_CD_OPT0",
            localize "STR_RESPAWN_CD_OPT1",
            localize "STR_RESPAWN_CD_OPT2",
            localize "STR_RESPAWN_CD_OPT3",
            localize "STR_RESPAWN_CD_OPT4",
            localize "STR_RESPAWN_CD_OPT5",
            localize "STR_RESPAWN_CD_OPT6",
            localize "STR_RESPAWN_CD_OPT7"
        ]]
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
        [GRLIB_PARAM_OptionValuesKey, [0,900,1200,1800,3600,7200]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_KICK_IDLE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_KICK_IDLE_OPT0",
            localize "STR_KICK_IDLE_OPT1",
            localize "STR_KICK_IDLE_OPT2",
            localize "STR_KICK_IDLE_OPT3",
            localize "STR_KICK_IDLE_OPT4",
            localize "STR_KICK_IDLE_OPT5"
        ]]
    ]],
    [GRLIB_PARAM_TK_mode, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, localize "STR_TK_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_TK_MODE_RELAX", localize "STR_TK_MODE_STRICT"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1,2]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_TK_MODE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_TK_MODE_OPT0",
            localize "STR_TK_MODE_OPT1",
            localize "STR_TK_MODE_OPT2"
        ]]
    ]],
    [GRLIB_PARAM_TK_count, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 4],
        [GRLIB_PARAM_NameKey, localize "STR_TK_COUNT"],
        [GRLIB_PARAM_OptionLabelKey, ["3","4","5","6"]],
        [GRLIB_PARAM_OptionValuesKey, [3,4,5,6]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_TK_COUNT_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            format [localize "STR_TK_COUNT_OPT0", 3],
            format [localize "STR_TK_COUNT_OPT0", 4],
            format [localize "STR_TK_COUNT_OPT0", 5],
            format [localize "STR_TK_COUNT_OPT0", 6]
        ]]
    ]],
    [GRLIB_PARAM_Persistent, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_PERSISTENT_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_SystemCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_PERSISTENT_MODE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_PERSISTENT_MODE_OPT0",
            localize "STR_PERSISTENT_MODE_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_CommanderModeEnabled, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, localize "STR_COMMANDER_MODE"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_CommanderCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_COMMANDER_MODE_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_COMMANDER_MODE_OPT0",
            localize "STR_COMMANDER_MODE_OPT1"
        ]]
    ]],
    [GRLIB_PARAM_CommanderModeRadius, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, GRLIB_sector_size],
        [GRLIB_PARAM_NameKey, localize "STR_COMMANDER_MODE_RADIUS"],
        [GRLIB_PARAM_OptionLabelKey, ["500m","600m","700m","800m","900m","1000m","1500m"]],
        [GRLIB_PARAM_OptionValuesKey, [500,600,700,800,900,1000,1500]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_CommanderCatKey],
        [GRLIB_PARAM_DescriptionKey, localize "STR_COMMANDER_MODE_RADIUS_DESC"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            localize "STR_COMMANDER_MODE_RADIUS_OPT5",
            localize "STR_COMMANDER_MODE_RADIUS_OPT6",
            localize "STR_COMMANDER_MODE_RADIUS_OPT7",
            localize "STR_COMMANDER_MODE_RADIUS_OPT8",
            localize "STR_COMMANDER_MODE_RADIUS_OPT9",
            localize "STR_COMMANDER_MODE_RADIUS_OPT10",
            localize "STR_COMMANDER_MODE_RADIUS_OPT15"
        ]]
    ]],
    [GRLIB_PARAM_CommanderVoteTimeout, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 60],
        [GRLIB_PARAM_NameKey, "Vote timer duration"],
        [GRLIB_PARAM_OptionLabelKey, ["20s","30s","60s","120s","180s","240s","300s"]],
        [GRLIB_PARAM_OptionValuesKey, [20,30,60,120,180,240,300]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_CommanderCatKey],
        [GRLIB_PARAM_DescriptionKey, "Length of the vote timer which determines how long the voting period lasts"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            "20 seconds to vote for the next sector",
            "30 seconds to vote for the next sector",
            "60 seconds to vote for the next sector",
            "120 seconds to vote for the next sector",
            "180 seconds to vote for the next sector",
            "240 seconds to vote for the next sector",
            "300 seconds to vote for the next sector"
        ]]
    ]],
    [GRLIB_PARAM_CommanderAutoStart, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 0],
        [GRLIB_PARAM_NameKey, "Auto-start vote timer"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_CommanderCatKey],
        [GRLIB_PARAM_DescriptionKey, "Determines if the vote timer should start automatically when there are no active sectors, if no votes, a random one is chosen"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            "The first player to vote will start the timer",
            "The timer will start automatically"
        ]]
    ]],
    [GRLIB_PARAM_CommPlayerVote, createHashMapFromArray [
        [GRLIB_PARAM_ValueKey, 1],
        [GRLIB_PARAM_NameKey, "Allow players to vote for the next sector"],
        [GRLIB_PARAM_OptionLabelKey, [localize "STR_PARAMS_DISABLED", localize "STR_PARAMS_ENABLED"]],
        [GRLIB_PARAM_OptionValuesKey, [0,1]],
        [GRLIB_PARAM_CategoryKey, GRLIB_PARAM_CommanderCatKey],
        [GRLIB_PARAM_DescriptionKey, "This option allows players to vote for the next sector, useful if no commander is present"],
        [GRLIB_PARAM_OptionDescriptionKey, [
            "Only the commander can decide the next sector, or if auto-start is enabled, the system will can automatically choose a sector",
            "Players are allowed to vote for the next sector"
        ]]
    ]]
];

// ParamsValidator
try {
    if (isNil "_Mission_Params") then {
        diag_log "--- LRX: Missing parameters ---";
        throw "ERROR: Parameters are missing";
    } else {
        if (!((typeName _Mission_Params) isEqualTo "ARRAY")) then {
            diag_log format ["--- LRX: Parameters are not an array ---"];
            throw "ERROR: Parameters are not an array";
        } else {
            if ((_Mission_Params isEqualTo [])) then {
                diag_log format ["--- LRX: Parameters count is zero ---"];
                throw "ERROR: Parameters count is zero";
            };
        };
    };

    {
        _key = _x select 0;
        if (isNil "_key") then {
            diag_log format ["--- LRX: Missing parameter key ---"];
            throw "ERROR: Parameter key is missing";
        } else {
            if (!((typeName _key) isEqualTo "STRING")) then {
                diag_log format ["--- LRX: Parameter key is not a string ---"];
                throw "ERROR: Parameter key is not a string";
            } else {
                if (_key isEqualTo "") then {
                    diag_log format ["--- LRX: Parameter key is too short ---"];
                    throw "ERROR: Parameter key is too short";
                };
            };
        };

        _hash = _x select 1;
        if (isNil "_hash") then {
            diag_log format ["--- LRX: Missing hash for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the hash";
        } else {
            if (!((typeName _hash) isEqualTo "HASHMAP")) then {
                diag_log format ["--- LRX: Parameter %1 is not a hash ---", str _key];
                throw "ERROR: Malformed parameters - a parameter is not a hash";
            };
        };

        _defaultValue = _hash get GRLIB_PARAM_ValueKey;
        if (isNil "_defaultValue") then {
            diag_log format ["--- LRX: Missing default value for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the default value";
        } else {
            if (!((typeName _defaultValue) isEqualTo "SCALAR") && !((typeName _defaultValue) isEqualTo "STRING")) then {
                diag_log format ["--- LRX: Parameter %1 default value is not a number or string ---", str _key];
                throw "ERROR: Malformed parameters - a parameter default value is not a number or string";
            } else {
                if (_defaultValue isEqualTo "") then {
                    diag_log format ["--- LRX: Parameter %1 default value is too short ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter default value is too short";
                };
            };
        };
        _name = _hash get GRLIB_PARAM_NameKey;
        if (isNil "_name") then {
            diag_log format ["--- LRX: Missing name for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the name";
        } else {
            if (!((typeName _name) isEqualTo "STRING")) then {
                diag_log format ["--- LRX: Parameter %1 name is not a string ---", str _key];
                throw "ERROR: Malformed parameters - a parameter name is not a string";
            } else {
                if (_name isEqualTo "") then {
                    diag_log format ["--- LRX: Parameter %1 name is too short ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter name is too short";
                };
            };
        };

        _optionLabel = _hash get GRLIB_PARAM_OptionLabelKey;
        if (isNil "_optionLabel") then {
            diag_log format ["--- LRX: Missing option label for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the option label";
        } else {
            if (!((typeName _optionLabel) isEqualTo "ARRAY")) then {
                diag_log format ["--- LRX: Parameter %1 option label is not an array ---", str _key];
                throw "ERROR: Malformed parameters - a parameter option label is not an array";
            } else {
                if (((count _optionLabel) <= 0)) then {
                    diag_log format ["--- LRX: Parameter %1 option label does not match the option values ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter option label does not match the option values";
                };
                {
                    if (!((typeName _x) isEqualTo "STRING")) then {
                        diag_log format ["--- LRX: Parameter %1 option label is not a string ---", str _key];
                        throw "ERROR: Malformed parameters - a parameter option label is not a string";
                    } else {
                        if (_x isEqualTo "") then {
                            diag_log format ["--- LRX: Parameter %1 option label is too short ---", str _key];
                            throw "ERROR: Malformed parameters - a parameter option label is too short";
                        };
                    };
                } forEach _optionLabel;
            };
        };

        _optionValues = _hash get GRLIB_PARAM_OptionValuesKey;
        if (isNil "_optionValues") then {
            diag_log format ["--- LRX: Missing option values for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the option values";
        } else {
            if (!((typeName _optionValues) isEqualTo "ARRAY")) then {
                diag_log format ["--- LRX: Parameter %1 option values is not an array ---", str _key];
                throw "ERROR: Malformed parameters - a parameter option values is not an array";
            } else {
                if (!((count _optionValues) isEqualTo (count _optionLabel))) then {
                    diag_log format ["--- LRX: Parameter %1 option values does not match the option label ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter option values does not match the option label";
                };
                {
                    if (!(_x isEqualType _defaultValue)) then {
                        diag_log format ["--- LRX: Parameter %1 option values does not match the value type ---", str _key];
                        throw "ERROR: Malformed parameters - a parameter option values does not match the value type";
                    };
                } forEach _optionValues;
            };
        };

        _category = _hash get GRLIB_PARAM_CategoryKey;
        if (isNil "_category") then {
            diag_log format ["--- LRX: Missing category for parameter %1 ---", str _key];
            throw "ERROR: Malformed parameters - a parameter is missing the category";
        } else {
            if (!((typeName _category) isEqualTo "STRING")) then {
                diag_log format ["--- LRX: Parameter %1 category is not a string ---", str _key];
                throw "ERROR: Malformed parameters - a parameter category is not a string";
            };
        };

        _description = _hash get GRLIB_PARAM_DescriptionKey;
        if (isNil "_description") then {
            diag_log format ["--- LRX: Missing optional description for parameter %1, a description is strongly recommended ---", str _key];
        } else {
            if (!((typeName _description) isEqualTo "STRING")) then {
                diag_log format ["--- LRX: Parameter %1 description is not a string ---", str _key];
                throw "ERROR: Malformed parameters - a parameter description is not a string";
            } else {
                if (_description isEqualTo "") then {
                    diag_log format ["--- LRX: Parameter %1 description is too short ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter description is too short";
                };
            };
        };

        _optionDescription = _hash get GRLIB_PARAM_OptionDescriptionKey;
        if (isNil "_optionDescription") then {
            if (_key in [GRLIB_PARAM_ModPresetWest, GRLIB_PARAM_ModPresetEast]) exitWith {};
            diag_log format ["--- LRX: Missing optional option description for parameter %1, a description is strongly recommended ---", str _key];
        } else {
            if (!((typeName _optionDescription) isEqualTo "ARRAY")) then {
                diag_log format ["--- LRX: Parameter %1 option description is not an array ---", str _key];
                throw "ERROR: Malformed parameters - a parameter option description is not an array";
            } else {
                if (!((count _optionDescription) isEqualTo (count _optionLabel))) then {
                    diag_log format ["--- LRX: Parameter %1 option description does not match the option label ---", str _key];
                    throw "ERROR: Malformed parameters - a parameter option description does not match the option label";
                };
                {
                    if (!((typeName _x) isEqualTo "STRING")) then {
                        diag_log format ["--- LRX: Parameter %1 option description is not a string ---", str _key];
                        throw "ERROR: Malformed parameters - a parameter option description is not a string";
                    } else {
                        if (_description isEqualTo "") then {
                            diag_log format ["--- LRX: Parameter %1 option description is too short ---", str _key];
                            throw "ERROR: Malformed parameters - a parameter option description is too short";
                        };
                    };
                } forEach _optionDescription;
            };
        };
    } forEach _Mission_Params;
} catch {
    diag_log format ["--- LRX: Error in mission parameters ---"];
    systemChat format ["--- LRX: Error in mission parameters ---"];
    endMission "LRXEND1";
    forceEnd;
};

LRX_Mission_Params = compileFinal createHashMapFromArray _Mission_Params;

// Group the parameters by category - respects order of params
_groupedParams = createHashMap;
{
	_key = _x#0;
	_hash = _x#1;
	_category = _hash get GRLIB_PARAM_CategoryKey;
	_groupParams = _groupedParams getOrDefault [_category, []];
	_groupParams pushBack [_key, _hash];
	_groupedParams set [_category, _groupParams];
} forEach _Mission_Params;

GRLIB_groupedParams = compileFinal _groupedParams;