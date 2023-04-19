if (!isServer && hasInterface) exitWith {};
params [ "_veh", "_cmd", "_unit" ];

if (isNil "_veh") exitWith {};
if (!isNil "GRLIB_warehouse_in_use") then { waitUntil {sleep 0.1; isNil "GRLIB_warehouse_in_use"} };
GRLIB_warehouse_in_use = true;
publicVariable "GRLIB_warehouse_in_use";

diag_log _this;

// update all warehouse
{
    if (typeOf _x == WRHS_Man) then {
        if (!isNull (_x getVariable ["GRLIB_Warehouse", objNull])) then {
            [_x] call warehouse_update;
        };
    };
} forEach (units (group chimeraofficer));

sleep 1;
GRLIB_warehouse_in_use = nil;
publicVariable "GRLIB_warehouse_in_use";
