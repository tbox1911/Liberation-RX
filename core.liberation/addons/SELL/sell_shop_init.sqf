// LRX Sell Shop - init

waituntil {sleep 1; !isNil "GRLIB_marker_init"};
private ["_man"];

{
    _man = _x nearEntities [SELL_Man, 10] select 0;
    _man addAction ["<t color='#00F080'>" + localize "STR_SELL_CARGO" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\SELL\do_sell.sqf","",-900,true,true,"","", 5];
} forEach GRLIB_Marker_SRV;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Sell Shop Initialized --------";