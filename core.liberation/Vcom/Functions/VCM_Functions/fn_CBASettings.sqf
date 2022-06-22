[] spawn
{
	sleep 1;
	waitUntil {!(isNil "CBAACT")};
	if (CBAACT && VCM_USECBASETTINGS) then
	{
[
    "VCM_ActivateAI", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Vcom Active", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ActivateAI = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

	//VCM_USECBASETTINGS = true; If CBA is enabled on the host, use the CBA default settings. If false, use the filepatching settings instead.
[
    "VCM_USECBASETTINGS", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Use CBA-Vcom Settings?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_USECBASETTINGS = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;	

[
    "VCM_Debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable Debug Mode. Mostly systemchat messages.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	false,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_Debug = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_SIDEENABLED", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "Sides impacted by Vcom.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [[[west,east,resistance],[west,east],[west],[east],[resistance],[resistance,west],[resistance,east]],[["West, East, Resistance"],["West, East"],["West"],["East"],["Resistance"],["Resistance, West"],["Resistance, East"]],0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_SIDEENABLED = _this;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYENABLE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable AI use of Artillery", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_ARTYENABLE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYSIDES", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "Sides that will use VCOM Artillery", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [[[west,east,resistance],[west,east],[west],[east],[resistance],[resistance,west],[resistance,east]],[["West, East, Resistance"],["West, East"],["West"],["East"],["Resistance"],["Resistance, West"],["Resistance, East"]],0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_ARTYSIDES = _this;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_CARGOCHNG", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Vcom handling of disembark/embarking for AI?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_CARGOCHNG = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_TURRETUNLOAD", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Disembark from turret positions?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_TURRETUNLOAD = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_DISEMBARKRANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI disembark from the enemy?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [50,1000,200,0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_DISEMBARKRANGE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;



[
    "VCM_StealVeh", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI steal empty/unlocked vehicles?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_StealVeh = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ClassSteal", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Class restriction for stealing vehicles", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_ClassSteal = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ForceSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enforce AI Speed 'FULL'?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_FullSpeed = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ADVANCEDMOVEMENT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI generate new waypoints to flank.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_ADVANCEDMOVEMENT = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_FRMCHANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI change formations based on location.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_FRMCHANGE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_SKILLCHANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI impacted by Vcom skill settings.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_SKILLCHANGE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AIDISTANCEVEHPATH", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI will steal vehicles from.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1000,100,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_AIDISTANCEVEHPATH = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_RAGDOLL", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI Ragdoll when hit?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_RAGDOLL = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_RAGDOLLCHC", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Chance for AI to ragdoll when hit.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,100,50,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_RAGDOLLCHC = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_HEARINGDISTANCE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI can hear gunfire.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,10000,800,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_HEARINGDISTANCE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_WARNDIST", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI will call for reinforcements from.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,10000,1000,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_WARNDIST = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_WARNDELAY", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Time (seconds) AI wait before support called.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,10000,30,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_WARNDELAY = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_STATICARMT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Time (seconds) AI stay on unarmed Static Weapons", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,10000,300,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_STATICARMT = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_MINECHANCE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Chance for AI to place a mine, once in combat.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,100,75,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_MINECHANCE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYDELAY", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Delay before artillery requests. SIDE BASED.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,5000,30,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_ARTYDELAY = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_AIMagLimit", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Mag count AI begin to look for additional mags.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [2,10,5,0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_AIMagLimit = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

};
diag_log "VCOM: Loaded CBA settings";





};