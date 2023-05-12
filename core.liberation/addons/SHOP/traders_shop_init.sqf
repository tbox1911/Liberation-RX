// LRX Trader Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

SHOP_list = light_vehicles + heavy_vehicles + air_vehicles + support_vehicles + opfor_recyclable + ind_recyclable;
SHOP_ratio = [
    0.75, 0.87, 0.78, 0.72, 0.83, 0.79, 0.78, 0.75, 0.86, 0.70, 0.83, 0.76, 0.71,
    0.87, 0.77, 0.84, 0.75, 0.80, 0.72, 0.84, 0.81, 0.79, 0.84, 0.79, 0.85, 0.72,
    0.70, 0.74, 0.79, 0.81, 0.86, 0.74, 0.83, 0.76, 0.73, 0.73, 0.82, 0.84, 0.81,
    0.75
];

{
    _x setVariable ["SHOP_ratio", (SHOP_ratio select (_forEachIndex % count SHOP_ratio))];
    _x addAction ["<t color='#00F080'>" + localize "STR_SHOP_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\SHOP\traders_shop.sqf","",-900,true,true,"","", 5];
} forEach (units GRLIB_SHOP_Group);

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";