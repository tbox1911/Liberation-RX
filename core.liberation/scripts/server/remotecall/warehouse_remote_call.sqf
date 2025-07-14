if (!isServer && hasInterface) exitWith {};
params ["_box", "_cmd", "_unit"];

if (isNil "_box") exitWith {};

if (_cmd == 1) then {
    if (isNull _box || !alive _box) exitWith {};
    if (isNull _unit || !alive _unit) exitWith {};
    private _price = [typeOf _box, support_vehicles] call F_getObjectPrice;
    [_unit, _price, 0] call ammo_add_remote_call;
    private _r1 = GRLIB_warehouse select {(_x select 0) == (typeOf _box)} select 0;
    _r1 set [1, (_r1 select 1) + 1];
    private _msg = format ["Player %1 Add %2 to WareHouse.", name _unit, [_box] call F_getLRXName];
    [gamelogic, _msg] remoteExec ["globalChat", 0];
    deleteVehicle _box;
};

if (_cmd == 2) then {
    if (_box == "") exitWith {};
    private _r1 = GRLIB_warehouse select { (_x select 0) == _box } select 0;
    if ((_r1 select 1) > 0) then {
        _r1 set [1, (_r1 select 1) - 1];
        private _msg = format ["Player %1 Take %2 from WareHouse.", name _unit, [_box] call F_getLRXName];
        [gamelogic, _msg] remoteExec ["globalChat", 0];
    };
};

// update all warehouse
{
    if (_x getVariable ["GRLIB_WHS_Group", false]) then {
        [getPosATL (agent _x)] call warehouse_update;
    };
} forEach agents;

publicVariable "GRLIB_warehouse";
