if (!isServer && hasInterface) exitWith {};
params ["_box", "_cmd", "_unit"];

if (isNil "_box") exitWith {};

private _msg = "";
private _count = 0;

// Add
if (_cmd == 1) then {
    private _box_class = typeOf _box;
    _count = GRLIB_warehouse getOrDefault [_box_class, -1];
    if (_count >= 0) then {
        _price = [_box_class, support_vehicles] call F_getObjectPrice;
        _msg = format ["Player %1 Add %2 to WareHouse.", name _unit, [_box] call F_getLRXName];
        [_unit, _price, 0] call ammo_add_remote_call;
        GRLIB_warehouse set [_box_class, _count + 1];
        deleteVehicle _box;
    };
};

// Take
if (_cmd == 2) then {
    _count = GRLIB_warehouse getOrDefault [_box, 0];
    if (_count > 0) then {
        _msg = format ["Player %1 Take %2 from WareHouse.", name _unit, [_box] call F_getLRXName];
        GRLIB_warehouse set [_box, _count - 1];
    };
};

if (_msg != "") then {
    [gamelogic, _msg] remoteExec ["globalChat", 0];

    // update all warehouse
    {
        if (_x getVariable ["GRLIB_WHS_Group", false]) then {
            [getPosATL (agent _x)] call warehouse_update;
        };
    } forEach agents;

    publicVariable "GRLIB_warehouse";
};
