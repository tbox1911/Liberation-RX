/*
    KP_fnc_cratefiller_settings

    File: fn_cratefiller_settings.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2020-10-09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        CBA Settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// KP_param_cratefiller_spawnAndDelete
// Enables/Disables the ability to spawn and delete pre defined crates.
// Default: true
[
    "KP_param_cratefiller_spawnAndDelete",
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_SPAWNDELETE", localize "STR_KP_CRATEFILLER_SPAWNDELETE_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_generatePreset
// Enables/Disables the item preset generation from configFile.
// Default: true
[
    "KP_param_cratefiller_generatePreset",
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_GENERATEPRESET", localize "STR_KP_CRATEFILLER_GENERATEPRESET_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {[] call KP_fnc_cratefiller_presets;}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_buildings
// Classnames of the buildings which will get the cratefiller action.
// Default: ["Land_RepairDepot_01_tan_F", "Land_RepairDepot_01_green_F", "Land_RepairDepot_01_civ_F"]
[
    "KP_param_cratefiller_buildings",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BUILDINGS", localize "STR_KP_CRATEFILLER_BUILDINGS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""Land_RepairDepot_01_tan_F"", ""Land_RepairDepot_01_green_F"", ""Land_RepairDepot_01_civ_F""]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_crates
// Classnames of the crates which will be available for spawn and delete.
// Default: ["B_supplyCrate_F", "CargoNet_01_box_F"]
[
    "KP_param_cratefiller_crates",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_CRATES", localize "STR_KP_CRATEFILLER_CRATES_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""B_supplyCrate_F"", ""CargoNet_01_box_F""]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_inventoryBlacklist
// Classnames of the inventories which will be ignored as valid storage.
// Default: []
[
    "KP_param_cratefiller_inventoryBlacklist",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST", localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_items
// Classnames of the items which should be available at the cratefiller on deactivated preset generation.
// Default: ["arifle_SPAR_01_snd_F", "MMG_01_tan_F", "HandGrenade", "MiniGrenade", "DemoCharge_Remote_Mag", "ATMine_Range_Mag", "FirstAidKit", "ToolKit", "B_FieldPack_cbr", "B_AssaultPack_cbr"]
[
    "KP_param_cratefiller_items",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ITEMS", localize "STR_KP_CRATEFILLER_ITEMS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""arifle_SPAR_01_snd_F"", ""MMG_01_tan_F"", ""HandGrenade"", ""MiniGrenade"", ""DemoCharge_Remote_Mag"", ""ATMine_Range_Mag"", ""FirstAidKit"", ""ToolKit"", ""B_FieldPack_cbr"", ""B_AssaultPack_cbr""]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_blacklist
// Classnames of the items which should be blacklisted from the cratefiller.
// Default: []
[
    "KP_param_cratefiller_blacklist",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BLACKLIST", localize "STR_KP_CRATEFILLER_BLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_additional
// Classnames of the items which should be added after the generated to presets to prevent missing items due to bad config entries.
// Default: []
[
    "KP_param_cratefiller_additional",
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ADDITIONAL", localize "STR_KP_CRATEFILLER_ADDITIONAL_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_usageRadius
// Defines the range where inventories can be edited and crates will spawn.
// Default: 25
[
    "KP_param_cratefiller_usageRadius",
    "SLIDER",
    [localize "STR_KP_CRATEFILLER_USAGERADIUS", localize "STR_KP_CRATEFILLER_USAGERADIUS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    [1, 250, 25, 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_interactRadius
// Defines the range for the interaction (addAction / ACE).
// Default: 5
[
    "KP_param_cratefiller_interactRadius",
    "SLIDER",
    [localize "STR_KP_CRATEFILLER_INTERACTRADIUS", localize "STR_KP_CRATEFILLER_INTERACTRADIUS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    [1, 50, 5, 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_cratefillerOverview
// Enables/Disables the cratefiller tools.
// Default: true
[
    "KP_param_cratefiller_cratefillerOverview",
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW", localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// KP_param_cratefiller_useAceActions
// Enables/Disables the ACE interaction usage.
// Default: false
[
    "KP_param_cratefiller_useAceActions",
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_USEACEACTIONS", localize "STR_KP_CRATEFILLER_USEACEACTIONS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {},
	true
] call CBA_Settings_fnc_init;

true
