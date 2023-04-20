// LRX Trader Shop - init

private ["_shop", "_deskDir", "_deskPos", "_desk", "_man", "_offset", "_str"];

SHOP_list = light_vehicles + heavy_vehicles + air_vehicles + support_vehicles + opfor_recyclable + ind_recyclable;
SHOP_desk = "Land_CashDesk_F";
SHOP_man = "C_Man_formal_1_F";
SHOP_ratio = [
    0.75, 0.87, 0.78, 0.72, 0.83, 0.79, 0.78, 0.75, 0.86, 0.70, 0.83, 0.76, 0.71,
    0.87, 0.77, 0.84, 0.75, 0.80, 0.72, 0.84, 0.81, 0.79, 0.84, 0.79, 0.85, 0.72,
    0.70, 0.74, 0.79, 0.81, 0.86, 0.74, 0.83, 0.76, 0.73, 0.73, 0.82, 0.84, 0.81,
    0.75
];

waituntil {sleep 1; !isNil "GRLIB_marker_init"};

{
    _shop = nearestObjects [_x, ["House"], 10] select 0; 
    _deskDir = getdir _shop; 
    _offset = [-0.7, 1, 0.25];  // Default shop_01_v1_f
    _str =  toLower str _shop;
    if (_str find "warehouse_03" > 0) then { _offset = [-2, 0, 0]};  // Tanoa
    if (_str find "metalshelter_02" > 0) then { _deskDir = (180 + _deskDir); _offset = [2, 0, 0]};  // Tanoa
    if (_str find "villagestore" > 0) then { _offset = [4, 2, 0.70]};  // Enoch
    if (_str find "ind_workshop01_02" > 0) then { _offset = [0, 2, 0]};  // Chernarus
    
    _deskPos = (getposASL _shop) vectorAdd ([_offset, -_deskDir] call BIS_fnc_rotateVector2D);   
    _desk = createSimpleObject [SHOP_desk, _deskPos, true];  
    _desk allowDamage false;  
    _desk setDir _deskDir;  
    _deskDir = (180 + _deskDir); 
    _manPos = _deskPos vectorAdd ([[0, -0.7, 0], -_deskDir] call BIS_fnc_rotateVector2D);  
    _man = SHOP_man createVehicleLocal _manPos;  
    _man allowDamage false;  
    _man disableCollisionWith _desk;  
    { _man disableAI _x } forEach ["MOVE","FSM","TARGET","AUTOTARGET","AUTOCOMBAT"]; 
    _man setPosASL _manPos;
    _man setDir _deskDir; 
    _man switchMove "AidlPercMstpSnonWnonDnon_AI"; 
    _man setVariable ["SHOP_ratio", (SHOP_ratio select (_forEachIndex % count SHOP_ratio))];
    sleep 0.2;
} forEach GRLIB_Marker_SHOP;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";