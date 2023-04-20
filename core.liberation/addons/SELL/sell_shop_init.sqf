// LRX Sell Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

{
    _x addAction ["<t color='#00F080'>" + localize "STR_SELL_CARGO" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\SELL\do_sell.sqf","",-900,true,true,"","", 5];
} forEach (units GRLIB_SELL_Group);

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Sell Shop Initialized --------";