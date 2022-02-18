// LRX Sell Shop - init

private ["_man", "_manPos"];
private _distvehclose = 5;
waituntil {sleep 1; !isNil "GRLIB_marker_init"};

{
    _manPos = _x;
    _manPos set [2, 1];
    _man = "C_Story_Mechanic_01_F" createVehicleLocal _manPos;  
    _man allowDamage false;  
    { _man disableAI _x } forEach ["MOVE","FSM","TARGET","AUTOTARGET","AUTOCOMBAT"]; 
    _man setPosATL _manPos;
    _man switchMove "LHD_krajPaluby"; 
    _man addAction ["<t color='#00F080'>" + localize "STR_SELL_CARGO" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\SELL\do_sell.sqf","",-900,true,true,"","", 5];
    sleep 0.2;
} forEach GRLIB_Marker_SRV;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Sell Shop Initialized --------";