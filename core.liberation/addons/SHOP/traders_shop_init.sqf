// LRX Trader Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

SHOP_list = [
	[Arsenal_typename, 0, 67],
	[medicalbox_typename, 0, 48],
	[repairbox_typename, 0, 84]
];

{
    if (_x getVariable ["GRLIB_SHOP_group", false]) then {
        (agent _x) addAction ["<t color='#00F080'>" + localize "STR_SHOP_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\SHOP\traders_shop.sqf","",-900,true,true,"","", 5];
    };
} forEach agents;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";