if (!isServer && hasInterface) exitWith {};
params ["_box", "_cmd", "_unit"];

if (isNil "_box") exitWith {};

if (_cmd == 1) then {
    if (isNull _box || !alive _box) exitWith {};
    if (isNull _unit || !alive _unit) exitWith {};
    private _price = support_vehicles select {(_x select 0) == (typeOf _box)} select 0 select 2;
    [_unit, _price, 0] call ammo_add_remote_call;
    private _r1 = GRLIB_warehouse select {(_x select 0) == (typeOf _box)} select 0;
    _r1 set [1, (_r1 select 1) + 1];
    deleteVehicle _box;
};

if (_cmd == 2) then {
    if (_box == "") exitWith {};
    private _r1 = GRLIB_warehouse select { (_x select 0) == _box } select 0;
    if ((_r1 select 1) > 0) then { _r1 set [1, (_r1 select 1) - 1] };
};

// update all warehouse
{
    if (typeOf _x == WRHS_Man) then {
        if (!isNull (_x getVariable ["GRLIB_Warehouse", objNull])) then {
            [_x] call warehouse_update;
        };
    };
} forEach (units GRLIB_WHS_Group);

publicVariable "GRLIB_warehouse";
