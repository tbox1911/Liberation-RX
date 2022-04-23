all_weapons = [];
all_grenades = [];
all_explosives = [];
all_items = [];
all_backpacks = [];

private _classnames = [];
private _blacklist = [];
private _type = [];
private _specialitems = [];

_blacklist = item_blacklist;

// Fetch all needed config classes

private _type = [];
private _configClasses = [];
{
    _configClasses append (
    "
    _type = (configname _x) call BIS_fnc_itemtype;
    (getNumber (_x >> 'scope') isEqualto 2) &&
    ((_type select 0) != '') &&
    ((_type select 0) != 'vehicleWeapon')
    " configClasses _x
    );
} forEach [(configFile >> "Cfgweapons"), (configFile >> "Cfgmagazines"), (configFile >> "Cfgvehicles"), (configFile >> "CfgGlasses")];

// Fetch classnames
{
    _classnames pushBack (configname _x);
} forEach _configClasses;

// Search for special items with wrong config entrys
{
    if (_x isKindOf ["CBA_MiscItem", configFile >> "Cfgweapons"]) then {
        _specialitems pushBack _x
    };
} forEach _classnames;

// Black- and Whitelisting
_classnames = _classnames - _blacklist;


// sort all classnames into the different categories
{
    _type = _x call BIS_fnc_itemtype;
    switch (_type select 0) do {
        case "Weapon": {
            if ((_type select 1) isEqualto "UnknownWeapon") then {
                _items pushBack _x
            } else {
                if ((_x call BIS_fnc_baseWeapon) isEqualto _x) then {
                    all_weapons pushBack _x;
                };
            };
        };
        case "mine": {
            all_explosives pushBack _x
        };
        case "Magazine": {
            if ((((_type select 1) isEqualto "Grenade") || ((_type select 1) isEqualto "SmokeShell")) && !((getNumber (configFile >> "Cfgmagazines" >> _x >> "type")) isEqualto 16)) then {
                all_grenades pushBack _x
            }
        };
        case "Equipment": {
            if ((_type select 1) isEqualto "backpack") then {
                all_backpacks pushBack _x
            }
        };
        case "Item": {
            switch (_type select 1) do {
                case "AccessoryMuzzle" : {};
                case "AccessoryPointer" : {};
                case "AccessorySights" : {};
                case "AccessoryBipod" : {};
                default {
                    all_items pushBack _x
                };
            };
        };
    };
} forEach (_classnames arrayintersect _classnames);

all_items append _specialitems;

