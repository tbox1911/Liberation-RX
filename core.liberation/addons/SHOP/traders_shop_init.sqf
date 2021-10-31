// LRX Trader Shop - init

SHOP_list = light_vehicles + heavy_vehicles + air_vehicles + support_vehicles + opfor_recyclable + ind_recyclable;
SHOP_desk = "Land_CashDesk_F";
SHOP_man = "C_Man_formal_1_F";
SHOP_ratio = [
    0.75, 0.57, 0.48, 0.72, 0.83, 0.59, 0.78, 0.55, 0.86, 0.69, 0.53, 0.76, 0.51,
    0.87, 0.67, 0.64, 0.75, 0.80, 0.72, 0.54, 0.51, 0.59, 0.54, 0.59, 0.85, 0.72,
    0.60, 0.74, 0.59, 0.61, 0.56, 0.64, 0.53, 0.76, 0.63, 0.73, 0.52, 0.54, 0.81,
    0.75
];

waituntil {sleep 1; !isNil "GRLIB_marker_init"};

{
    private _shop = nearestObjects [_x, ["House"], 10] select 0; 
    private _deskPos = (getposASL _shop) vectorAdd [0,0,0.25]; 
    private _deskDir = getdir _shop; 
    private _desk = createSimpleObject [SHOP_desk, _deskPos, true]; 
    _desk allowDamage false; 
    _desk setDir _deskDir; 
    _deskDir = (180 + _deskDir);
    private _manPos = _deskPos vectorAdd ([[-0.7, 0, 0], -_deskDir] call BIS_fnc_rotateVector2D); 
    private _man = SHOP_man createVehicleLocal _manPos; 
    _man allowDamage false; 
    _man disableCollisionWith _desk; 
    { _man disableAI _x } forEach ["MOVE","FSM","TARGET","AUTOTARGET","AUTOCOMBAT"];
    _man setDir _deskDir;
    _man switchMove "AidlPercMstpSnonWnonDnon_AI";
    _man setVariable ["SHOP_ratio", (SHOP_ratio select (_forEachIndex % count SHOP_ratio))];
    sleep 0.2;
} forEach GRLIB_Marker_SHOP;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";