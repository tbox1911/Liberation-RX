// LRX Sell Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

{
    if (_x getVariable ["GRLIB_SELL_group", false]) then {
        (agent _x) addAction ["<t color='#00F080'>" + localize "STR_SELL_CARGO" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\SELL\do_sell.sqf","",-900,true,true,"","", 5];
    };
} forEach agents;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Sell Shop Initialized --------";