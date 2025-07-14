// LRX Trader Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

private _shop_list_default = [
	[Arsenal_typename, 0, 67],
	[medicalbox_typename, 0, 48],
	[repairbox_typename, 0, 84]
] + opfor_recyclable;

private _shop_blacklist = [];
SHOP_list = _shop_list_default select { !((_x select 0) isKindOf "Air") && !((_x select 0) in _shop_blacklist)};

SHOP_ratio = [
    0.25, 0.87, 0.78, 0.22, 0.83, 0.39, 0.78, 0.75, 0.86, 0.30, 0.83, 0.76, 0.71,
    0.87, 0.77, 0.84, 0.75, 0.80, 0.22, 0.84, 0.31, 0.79, 0.24, 0.79, 0.35, 0.72,
    0.70, 0.34, 0.29, 0.81, 0.86, 0.24, 0.83, 0.76, 0.73, 0.33, 0.22, 0.34, 0.81,
    0.25
];

{
    if (_x getVariable ["GRLIB_SHOP_group", false]) then {
        (agent _x) addAction ["<t color='#00F080'>" + localize "STR_SHOP_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\SHOP\traders_shop.sqf","",-900,true,true,"","", 5];
        _x setVariable ["SHOP_ratio", (SHOP_ratio select (_forEachIndex % count SHOP_ratio))];
    };
} forEach agents;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";