/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Creates the item lists if generateLists is enabled.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Reset variables
KPCF_weapons = [];
KPCF_grenades = [];
KPCF_explosives = [];
KPCF_items = [];
KPCF_backpacks = [];

private _configClasses = [];
private _classNames = [];
private _type = [];

// Get all classnames from config
{
    _configClasses append (
        "
            _type = (configName _x) call BIS_fnc_itemType;
            (getNumber (_x >> 'scope') == 2) &&
            ((_type select 0) != '') &&
            ((_type select 0) != 'VehicleWeapon')
        " configClasses _x
    );
} forEach [(configFile >> "CfgMagazines"), (configFile >> "CfgWeapons"), (configFile >> "CfgVehicles"), (configFile >> "CfgGlasses")];

// Convert to classname
{
    _classNames pushBack (configName _x)
} forEach _configClasses;

// Black & whitelisting
_classNames = _classNames - KPCF_blacklistedItems;
_classNames append KPCF_whitelistedItems;

private _specialItems = [];

// Search for special items with wrong config entrys
{
    if (_x isKindOf ["CBA_MiscItem", configfile >> "CfgWeapons"]) then {_specialItems pushBack _x};
} forEach _classNames;

// Sort all classnames into the different categories
{
    _type = _x call BIS_fnc_itemType;
    switch (_type select 0) do {
        case "Weapon": {if ((_type select 1) isEqualTo "UnknownWeapon") then {KPCF_items pushBack _x} else {if ((_x call BIS_fnc_baseWeapon) == _x) then {KPCF_weapons pushBack _x;};};};
        case "Mine": {KPCF_explosives pushBack _x};
        case "Magazine": {if ((((_type select 1) isEqualTo "Grenade") || ((_type select 1) isEqualTo "SmokeShell")) && !((getNumber (configFile >> "CfgMagazines" >> _x >> "type")) == 16)) then {KPCF_grenades pushBack _x}};
        case "Equipment": {if ((_type select 1) isEqualTo "Backpack") then {KPCF_backpacks pushBack _x}};
        case "Item": {
            switch (_type select 1) do {
                case "AccessoryMuzzle" : {};
                case "AccessoryPointer" : {};
                case "AccessorySights" : {};
                case "AccessoryBipod" : {};
                default {KPCF_items pushBack _x};
            };
        };
    };
} forEach (_classnames arrayIntersect _classnames);

KPCF_items append _specialItems;
