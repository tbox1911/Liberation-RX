// LRX Trader Shop - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

private _reputation = [player] call F_getReput;
private _civilian_veh = [];
{
    if (count _civilian_veh == 5) exitWith {};
    if (_x isKindOf "LandVehicle") then {
        _civilian_veh pushBackUnique [_x, 5, 35 max (35 + -_reputation)];
    };
} forEach (civilian_vehicles call BIS_fnc_arrayShuffle);

private _shop_list_default = [
	[Arsenal_typename, 0, 67],
	[medicalbox_typename, 0, 48],
	[repairbox_typename, 0, 84]
] + _civilian_veh + opfor_recyclable;

private _shop_blacklist = [];
SHOP_list = _shop_list_default select { !((_x select 0) isKindOf "Air") && !((_x select 0) in _shop_blacklist)};

{
    if (_x getVariable ["GRLIB_SHOP_group", false]) then {
        (agent _x) addAction ["<t color='#00F080'>" + localize "STR_SHOP_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\SHOP\traders_shop.sqf","",-900,true,true,"","", 5];
    };
} forEach agents;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Traders Shop Initialized --------";