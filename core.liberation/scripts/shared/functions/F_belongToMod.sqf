params ["_item"];

if ([_item, GRLIB_MOD_signature] call F_startsWithMultiple) exitWith { true };

private _ret = false;

// Western Sahara
if (GRLIB_WS_enabled) then {
    if (tolower (getText (configfile >> "CfgWeapons" >> _item >> 'DLC')) == 'ws') then { _ret = true };
    if (tolower (getText (configfile >> "CfgGlasses" >> _item >> 'DLC')) == 'ws') then { _ret = true };
    if (tolower (getText (configfile >> "CfgVehicles" >> _item >> 'DLC')) == 'ws') then { _ret = true };
    if (tolower (getText (configfile >> "CfgMagazines" >> _item >> 'DLC')) == 'ws') then { _ret = true };
};

// EJ Weapons
if (GRLIB_EJW_enabled) then {
    if (tolower (getText (configfile >> "CfgWeapons" >> _item >> 'dlc')) == 'u100') then { _ret = true };
    if (tolower (getText (configfile >> "CfgGlasses" >> _item >> 'dlc')) == 'u100') then { _ret = true };
    if (tolower (getText (configfile >> "CfgVehicles" >> _item >> 'dlc')) == 'u100') then { _ret = true };
    if (tolower (getText (configfile >> "CfgMagazines" >> _item >> 'dlc')) == 'u100') then { _ret = true };
};

// Global Mobilizaton
if (GRLIB_GM_enabled) then {
    if (tolower (getText (configfile >> "CfgWeapons" >> _item >> 'dlc')) == 'gm') then { _ret = true };
    if (tolower (getText (configfile >> "CfgGlasses" >> _item >> 'dlc')) == 'gm') then { _ret = true };
    if (tolower (getText (configfile >> "CfgVehicles" >> _item >> 'dlc')) == 'gm') then { _ret = true };
    if (tolower (getText (configfile >> "CfgMagazines" >> _item >> 'dlc')) == 'gm') then { _ret = true };
};

// OPTRE
if (GRLIB_OPTRE_enabled) then {
    if (tolower (getText (configfile >> "CfgWeapons" >> _item >> 'dlc')) == 'optre') then { _ret = true };
    if (tolower (getText (configfile >> "CfgGlasses" >> _item >> 'dlc')) == 'optre') then { _ret = true };
    if (tolower (getText (configfile >> "CfgVehicles" >> _item >> 'dlc')) == 'optre') then { _ret = true };
    if (tolower (getText (configfile >> "CfgMagazines" >> _item >> 'dlc')) == 'optre') then { _ret = true };
};

// RHS
if (GRLIB_RHS_enabled) then {
    if (["RHS_", (getText (configfile >> "CfgWeapons" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["RHS_", (getText (configfile >> "CfgGlasses" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["RHS_", (getText (configfile >> "CfgVehicles" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["RHS_", (getText (configfile >> "CfgMagazines" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
};

// LOP
if (GRLIB_LOP_enabled) then {
    if (["PO_", (getText (configfile >> "CfgWeapons" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["PO_", (getText (configfile >> "CfgGlasses" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["PO_", (getText (configfile >> "CfgVehicles" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
    if (["PO_", (getText (configfile >> "CfgMagazines" >> _item >> 'DLC'))] call F_startsWith) then { _ret = true };
};

_ret;
