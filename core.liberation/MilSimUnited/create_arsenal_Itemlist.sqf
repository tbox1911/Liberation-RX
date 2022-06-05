equipment = [];
private _all_weapons = [];
private _all_magazines = [];
private _all_grenades = [];
private _all_explosives = [];
private _all_items = [];
private _all_backpacks = [];
private _all_accessorys = [];
private _classnames = [];
private _blacklist = [];
private _type = [];
private _specialitems = [];
private _all_gear = [];
private _blacklist = item_blacklist;

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
} forEach [(configFile >> "Cfgweapons"), (configFile >> "Cfgmagazines"), (configFile >> "Cfgvehicles"), (configFile >> "CfgGlasses"), (configFile >> "CfgUniforms"), (configFile >> "CfgHelments"), (configFile >> "CfgVests")];

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

// Blackisting
_classnames = _classnames - _blacklist;

// sort all classnames into the different categories
{
    _type = _x call BIS_fnc_itemtype;
    switch (_type select 0) do {
        case "Weapon": {
            if ((_type select 1) isEqualto "UnknownWeapon") then {
                _all_items pushBack _x
            } else {
                if ((_x call BIS_fnc_baseWeapon) isEqualto _x) then {
                    _all_weapons pushBack _x;
                };
            };
        };
        case "Mine": {
            _all_explosives pushBack _x
        };
        case "Magazine": {
            if ((((_type select 1) isEqualto "Grenade") || ((_type select 1) isEqualto "SmokeShell"))) then {
                _all_grenades pushBack _x;
            } else {
                if (((_type select 1) isEqualto "Bullet") || ((_type select 1) isEqualto "Missile") || ((_type select 1) isEqualto "Rocket") || ((_type select 1) isEqualto "ShotgunShell") || ((_type select 1) isEqualto "UnknownMagazine") || ((_type select 1) isEqualto "Shell")) then {
                    _all_magazines pushBack _x;
                };
            };
        };
        case "Equipment": {
            if (((_type select 1) isEqualto "Backpack") || ((_type select 1) isEqualto "Glasses")) then {
                _all_backpacks pushBack _x
            };
            if (((_type select 1) isEqualto "Uniform") || ((_type select 1) isEqualto "Headgear") || ((_type select 1) isEqualto "Vest")) then {
                _all_gear pushBack _x
            };
        };
        case "Item": {
            switch (_type select 1) do {
                case "AccessoryMuzzle" : {
                    _all_accessorys pushBack _x
                };
                case "AccessoryPointer" : {
                    _all_accessorys pushBack _x
                };
                case "AccessorySights" : {
                    _all_accessorys pushBack _x
                };
                case "AccessoryBipod" : {
                    _all_accessorys pushBack _x
                };
                default {
                    _all_items pushBack _x
                };
            };
        };
    };
} forEach (_classnames arrayintersect _classnames);

_all_items append _specialitems;


equipment = _all_weapons + _all_magazines + _all_grenades + _all_explosives + _all_items + _all_backpacks + _all_accessorys + _all_gear;
