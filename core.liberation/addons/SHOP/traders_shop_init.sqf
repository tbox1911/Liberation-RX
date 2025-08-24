// LRX Trader Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

private _shop_list_default = [
	[Arsenal_typename, 0, 67],
	[medicalbox_typename, 0, 48],
	[repairbox_typename, 0, 84]
] + opfor_recyclable;

private _shop_blacklist = [];
SHOP_list = _shop_list_default select { !((_x select 0) isKindOf "Air") && !((_x select 0) in _shop_blacklist)};

// SHOP price Ratio (from 0.45 up to 0.70) of the regular price
private _getRatio = { parseNumber(0.70 min (0.45 + random 0.25) toFixed 2) };
{
    if (_x getVariable ["GRLIB_SHOP_group", false]) then {
        (agent _x) addAction ["<t color='#00F080'>" + localize "STR_SHOP_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\SHOP\traders_shop.sqf","",-900,true,true,"","", 5];
        _x setVariable ["SHOP_ratio", ([] call _getRatio)];
    };
} forEach agents;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";