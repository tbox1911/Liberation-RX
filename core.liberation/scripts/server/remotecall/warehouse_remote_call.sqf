if (!isServer && hasInterface) exitWith {};
params [ "_box", "_cmd", "_unit" ];

if (isNil "_box") exitWith {};
if (!isNil "GRLIB_warehouse_in_use") then { waitUntil {sleep 0.1; isNil "GRLIB_warehouse_in_use"} };
GRLIB_warehouse_in_use = true;
publicVariable "GRLIB_warehouse_in_use";

if (_cmd == 1) then {
    if (!isNull _box) then {
        _price = support_vehicles select {(_x select 0) == (typeOf _box)} select 0 select 2;
        [_unit, _price, 0] call ammo_add_remote_call;
        _r1 = GRLIB_warehouse select {(_x select 0) == (typeOf _box)} select 0;
        _r1 set [1, (_r1 select 1) + 1];
        deleteVehicle _box;
    };
};

if (_cmd == 2) then {
    _r1 = GRLIB_warehouse select {(_x select 0) == (_box)} select 0;
    if ((_r1 select 1) > 0) then {
        _r1 set [1, (_r1 select 1) - 1];
    };
};

// update all warehouse
{
    if (typeOf _x == WRHS_Man) then {
        if (!isNull (_x getVariable ["GRLIB_Warehouse", objNull])) then {
            [_x] call warehouse_update;
        };
    };
} forEach (units GRLIB_WHS_Group);

sleep 1;
GRLIB_warehouse_in_use = nil;
publicVariable "GRLIB_warehouse_in_use";
publicVariable "GRLIB_warehouse";
